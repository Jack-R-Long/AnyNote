//
//  Memo.swift
//  AnyNote
//
//  Created by Jack long on 8/20/23.
//

import Foundation

struct Memo: Identifiable, Codable{
    var id: UUID
    var title: String
    var date: Date
    var transcript: String?
    var noteType: NoteType?
    var savedToCloudflare: SaveStaus = .unsaved
    var aiNote: String?
    var modelType: AIModelType
    
    init(id: UUID=UUID(), title: String, date: Date? = nil, transcript: String? = nil, noteType: NoteType? = nil, savedToCloudflare: SaveStaus = .unsaved, aiNote: String? = nil, modelType: AIModelType = .gpt4) {
        self.id = id
        self.title = title
        self.date = Date()
        self.transcript = transcript
        self.noteType = noteType
        self.savedToCloudflare = savedToCloudflare
        self.aiNote = aiNote
        self.modelType = modelType
    }
}

extension Memo {
    static let sampleData: [Memo] = [
        Memo(title: "Anakin's Podrace Prep", transcript: "This is Anakin. The Boonta Eve Classic is approaching, and I need to ensure my podracer is in top condition. The left thruster's been shaky lately. Also, Sebulba has been acting sneaky around my pod, need to watch out for him. Qui-Gon believes I can win this. Let's prove him right. Need to remember to pick up some power couplings from Watto's shop. Also, give mom a big hug before the race.", noteType: .md , savedToCloudflare: .saved, aiNote: "# Anakin's Monday Memo\n## Date: September 20, 2023\n---\n### ToDo List:\n\n1. **Fix Pod after School**\n- The left thruster is malfunctioning and needs to be repaired for the Boonta Eve race.\n2. **Repair C3PO's Wiring**\n- Some parts were borrowed for the Pod, causing C3PO to malfunction. He needs fixing.\n3. **Deal with Greedo**\n- Greedo persistently asks about the credits owed.\n- This needs to be addressed, especially considering the dice game win from last week.\n\nTomorrow is slated to be a busy day."),
        
        Memo(title: "Obi-Wan's Report from Kamino", transcript: "Met with Prime Minister Lama Su. Discovered the creation of a clone army, supposedly ordered by Master Sifo-Dyas. The clones are based on a bounty hunter named Jango Fett. Something feels off; I've taken a sample of their DNA to analyze back at the temple. On a side note, the rain on Kamino is relentless. Must remember to waterproof my boots.", noteType: .md, savedToCloudflare: .saved, aiNote: "# Obi-Wan's Kamino Visit\n## Date: TBD\n---\n- **Meeting with Prime Minister Lama Su**:\n    - Discovery of clone army creation, apparently commissioned by Master Sifo-Dyas.\n    - Clones have been modeled after bounty hunter Jango Fett.\n- **Suspicion**:\n    - Unsure of the intent behind the creation of this army.\n    - Taken DNA samples for further analysis.\n- **Note to Self**: \n    - Waterproof boots. The rainfall on Kamino is non-stop."),
        
        Memo(title: "Leia's Message to Obi-Wan", transcript: "This is Princess Leia Organa. General Kenobi, years ago you served my father in the Clone Wars. I regret that I am unable to present my father's request to you in person, but my ship has fallen under attack. I've placed information vital to the survival of the Rebellion into the memory systems of this R2 unit. My father will know how to retrieve it.", noteType: .md, savedToCloudflare: .saved, aiNote: "# Leia's Urgent Message\n## Date: TBD\n---\n\n**To**: General Kenobi\n\n- **Historical Context**:\n    - You've served alongside my father in the Clone Wars.\n- **Current Situation**:\n    - My ship is under attack.\n    - Important information for the Rebellion's survival has been stored in an R2 unit.\n- **Next Steps**:\n    - My father will be the point of contact for retrieval."),
        
        Memo(title: "Han's Kessel Run Notes", transcript: "Han Solo here. Made the Kessel Run in less than twelve parsecs with the Falcon, and I've got some thoughts. First, need to adjust the hyperdrive calibrations; we can't have another hiccup like that. Chewie mentioned some unusual noise from the rear thrusters, gotta check it out. And oh, remind me to never gamble with Lando again. Almost lost the Falcon!", noteType: .md, savedToCloudflare: .saved, aiNote: "# Han's Kessel Run Reflections\n## Date: TBD\n---\n\n- **Achievement**:\n    - Completed the Kessel Run in <12 parsecs with the Millennium Falcon.\n- **To-Do**:\n    - Adjust hyperdrive calibrations to prevent mishaps.\n    - Investigate the unusual noise from rear thrusters (as pointed out by Chewie).\n- **Personal Reminder**:\n    - Stay away from gambling games with Lando.")
    ]
}

enum SaveStaus: String, Codable {
    case unsaved
    case saving
    case saved
}

enum NoteType: String, Codable {
    case md  //markdown
    case pdf
}

enum AIModelType: String, Codable {
    case gpt35 = "gpt-3.5-turbo"
    case gpt4 = "gpt-4"
}
