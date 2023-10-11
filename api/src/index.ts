import OpenAI from 'openai';
import fetchAdapter from '@vespaiach/axios-fetch-adapter';

export interface Env {
	MEMOS_KV: KVNamespace;
	OPENAI_API_KEY: string;
}

type MemoData = {
	id: string;
	transcript?: string;
	length?: number;
	savedToCloudflare?: string;
	title?: string;
	date?: number;
	modelType?: AIModelType;
};

enum AIModelType {
	gpt3 = "gpt-3.5-turbo",
    gpt4 = "gpt-4"
}

async function handleRequest(request: Request, env: Env): Promise<Response> {
	const url = new URL(request.url);

	try {
		// Check for Content-Type
		const contentType = request.headers.get('Content-Type');
		if (!contentType || !contentType.includes('application/json')) {
			return new Response('Content type must be application/json', { status: 400 });
		}

		const rawData: MemoData = await request.json();

		// Validate that rawData contains an 'id' field
		if (!rawData.id || typeof rawData.id !== 'string') {
			return new Response('Invalid data: id field is missing or not a string', { status: 400 });
		}

		const memoId = rawData.id;

		// Assign model from POST JSON (default to gpt-4)
		const model = rawData.modelType ?? AIModelType.gpt4

		// Save memo in KV
		if (url.pathname === '/') {
			// TODO - should this be a PUT route? 
			if (request.method === 'POST') {
				await env.MEMOS_KV.put(memoId, JSON.stringify(rawData));
				return new Response('Memo saved', { status: 200 });
			}
		}

		// Create AI generated note
		else if (url.pathname === '/note') {
			if (request.method === 'POST') {
				console.log(`Fetching object with id ${memoId}`);
				const storedMemoData = (await env.MEMOS_KV.get(memoId, 'json')) as MemoData;

				if (!storedMemoData) {
					return new Response('Memo not found for provided id', { status: 404 });
				} 
				// Check if memo has a transcript
				else if (!storedMemoData.transcript || storedMemoData.transcript.trim() === "") {
					return new Response('Memo lacks a transcript', { status: 404 });
				}

				// Constructing the user message dynamically
				const date = storedMemoData.date ? new Date(storedMemoData.date).toLocaleString() : new Date().toLocaleString();
				const userMessageContent = `
				Title: ${storedMemoData.title}
				Date: ${date}
				Transcript: '${storedMemoData.transcript}'
				`;

				// Initialize OpenAI instance within the function scope
				const openai = new OpenAI({
					apiKey: env.OPENAI_API_KEY,
				});

				let chatCompletion;
				try {
					chatCompletion = await openai.chat.completions.create({
						messages: [
							{
								role: 'system',
								content:
									'You are a helpful note creator. The user will supply transcripts of voice memos, and you will create well formatted notes in Markdown.',
							},
							{
								role: 'user',
								content: userMessageContent,
							},
						],
						model: model,
					});
				} catch (err: any) {
					// To allow accessing err.message
					console.error(err);
					return new Response(`Error calling OpenAI API: ${err.message}`, { status: 500 });
				}

				if (!chatCompletion.choices || chatCompletion.choices.length === 0) {
					return new Response('Unexpected response format from OpenAI', { status: 500 });
				}

				const responseFromOpenAI = chatCompletion.choices[0].message.content; // Assuming the actual content is under `content`
				console.log(responseFromOpenAI);

				const jsonResponse = {
					note: responseFromOpenAI,
				};

				return new Response(JSON.stringify(jsonResponse), {
					status: 200,
					headers: { 'Content-Type': 'application/json' },
				});
			}
		}

		// Test OpenAI API connection
		else if (url.pathname === '/test') {
			if (request.method === 'GET') {
				try {
					// Initialize OpenAI instance within the function scope
					const openai = new OpenAI({
						apiKey: env.OPENAI_API_KEY,
					});
					const chatCompletion = await openai.chat.completions.create({
						messages: [{ role: 'user', content: 'Say this is a test' }],
						model: 'gpt-3.5-turbo',
					});

					const responseFromOpenAI = chatCompletion.choices[0].message;
					return new Response(`OpenAI API success.  Response:\n ${JSON.stringify(responseFromOpenAI)}}`, { status: 200 });
				} catch (err) {
					console.error(err);
					return new Response('Error calling OpenAI API', { status: 500 });
				}
			}
		}
		return new Response('Method not allowed', { status: 405 });
	} catch (err) {
		if (err instanceof SyntaxError) {
			return new Response('Invalid JSON payload', { status: 400 });
		} else {
			console.error(err);
			return new Response('Internal Server Error', { status: 500 });
		}
	}
}

export default {
	async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
		return handleRequest(request, env);
	},
};
