//
//  RecordsManager.swift
//  TRIVIA
//
//  Created by Federico Mireles on 19/08/24.
//

import UIKit

class RecordsManager: NSObject {
    static let shared = RecordsManager()
    
    private let fileName = "Records.plist"
    private var records: [Player] = []
    
    override init() {
        super.init()
        loadRecords()
    }
    
    func loadRecords() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = PropertyListDecoder()
                records = try decoder.decode([Player].self, from: data)
            } catch {
                print("Error al cargar records: \(error)")
                initializeWithDummyData()
            }
        } else {
            initializeWithDummyData()
        }
    }
    
    func saveRecords() {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(records)
            try data.write(to: fileURL)
        } catch {
            print("Error al guardar records: \(error)")
        }
    }
    
    private func initializeWithDummyData() {
        records = [
            Player(name: "King", score: 100, avatar: "avatar13"),
            Player(name: "Cop", score: 90, avatar: "avatar8"),
            Player(name: "Gamer", score: 80, avatar: "avatar12"),
            Player(name: "User", score: 70, avatar: "avatar7"),
            Player(name: "Loser", score: 60, avatar: "avatar0")
        ]
        saveRecords()
    }
    
    private func getDocumentsDirectory() -> URL {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        print("Documents Directory: \(documentsDirectory.path)")
        return documentsDirectory
    }

    
    func addRecord(_ player: Player) {
        records.append(player)
        records.sort { $0.score > $1.score }
        if records.count > 5 {
            records = Array(records.prefix(5))
        }
        saveRecords()
    }
    
    func getTopRecords() -> [Player] {
        return records.sorted { $0.score > $1.score }.prefix(5).map { $0 }
    }
}
