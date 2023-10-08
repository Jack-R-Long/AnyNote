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
    var length: Int
    var date: Date
    var transcript: String?
    var noteType: NoteType?
    var savedToCloudflare: SaveStaus = .unsaved
    var aiNote: String?
    
    init(id: UUID=UUID(), title: String, length: Int, date: Date? = nil, transcript: String? = nil, noteType: NoteType? = nil, savedToCloudflare: SaveStaus = .unsaved, aiNote: String? = nil) {
        self.id = id
        self.title = title
        self.length = length
        self.date = Date()
        self.transcript = transcript
        self.noteType = noteType
        self.savedToCloudflare = savedToCloudflare
        self.aiNote = aiNote
    }
}

extension Memo {
    static let sampleData: [Memo] =
    [
        Memo(title: "Anakin's Podrace Prep", length: 18, transcript: "This is Anakin. The Boonta Eve Classic is approaching, and I need to ensure my podracer is in top condition. The left thruster's been shaky lately. Also, Sebulba has been acting sneaky around my pod, need to watch out for him. Qui-Gon believes I can win this. Let's prove him right. Need to remember to pick up some power couplings from Watto's shop. Also, give mom a big hug before the race.", noteType: .md , savedToCloudflare: .saved),
        
        Memo(title: "Obi-Wan's Report from Kamino", length: 20, transcript: "Met with Prime Minister Lama Su. Discovered the creation of a clone army, supposedly ordered by Master Sifo-Dyas. The clones are based on a bounty hunter named Jango Fett. Something feels off; I've taken a sample of their DNA to analyze back at the temple. On a side note, the rain on Kamino is relentless. Must remember to waterproof my boots.", noteType: .md, savedToCloudflare: .unsaved),
        
        Memo(title: "Leia's Message to Obi-Wan", length: 7, transcript: "This is Princess Leia Organa. General Kenobi, years ago you served my father in the Clone Wars. I regret that I am unable to present my father's request to you in person, but my ship has fallen under attack. I've placed information vital to the survival of the Rebellion into the memory systems of this R2 unit. My father will know how to retrieve it.", noteType: .pdf,  savedToCloudflare: .unsaved),
        
        Memo(title: "Han's Kessel Run Notes", length: 10, transcript: "Han Solo here. Made the Kessel Run in less than twelve parsecs with the Falcon, and I've got some thoughts. First, need to adjust the hyperdrive calibrations; we can't have another hiccup like that. Chewie mentioned some unusual noise from the rear thrusters, gotta check it out. And oh, remind me to never gamble with Lando again. Almost lost the Falcon!", noteType: .md, savedToCloudflare: .unsaved)
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
