import OpenAI from 'openai';
import fetchAdapter from '@vespaiach/axios-fetch-adapter';

export interface Env {
	// Example binding to KV. Learn more at https://developers.cloudflare.com/workers/runtime-apis/kv/
	MEMOS_KV: KVNamespace;
	OPENAI_API_KEY: string;
}

async function handleRequest(request: Request, env: Env): Promise<Response> {
	const url = new URL(request.url);
	console.log("URL Path:", url.pathname);
	if (url.pathname === '/') {
		if (request.method === 'POST') {
			try {
				const rawData = await request.json();
	
				//  TODO - Validation: Make sure to validate rawData before proceeding
	
				// @ts-ignore
				const memoId = rawData.id;
				await env.MEMOS_KV.put(memoId, JSON.stringify(rawData));
	
				return new Response('Memo saved', { status: 200 });
			} catch(err) {
				console.error(err)
				return new Response('Error decoding and/or saving data to KV', {status: 500})
			}
		}
	} else if (url.pathname === '/note') {
		if (request.method === 'POST') {
			try {
				// Initialize OpenAI instance within the function scope
				const openai = new OpenAI({
					apiKey: env.OPENAI_API_KEY,
				});
				const chatCompletion = await openai.chat.completions.create({
					messages: [{ role: 'user', content: 'Say this is a test' }],
					model: 'gpt-3.5-turbo',
				});
	
				const responseFromOpenAI = chatCompletion.choices[0].message
				return new Response('OpenAI API success', { status: 200 });
			} catch(err) {
				console.error(err)
				return new Response('Error calling OpenAI API', {status: 500})
			}
		}
	}

	return new Response('Method not allowed', { status: 405 });
}

export default {
	async fetch(request: Request, env: Env, ctx: ExecutionContext): Promise<Response> {
		return handleRequest(request, env);
	},
};
