//
//  DataManager.swift
//  moviessl
//
//  Created by Juan Aguilar on 07/07/24.
//

import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()
    private var dbConnection: Connection?
    
    private let showsTable = Table("realtry")
    private let id = Expression<Int>("id")
    private let elementId = Expression<Int>("elementId")
    private let url = Expression<String?>("url")
    private let name = Expression<String?>("name")
    private let type = Expression<String?>("type")
    private let language = Expression<String?>("language")
    private let genres = Expression<String?>("genres")
    private let status = Expression<String?>("status")
    private let runtime = Expression<Int?>("runtime")
    private let premiered = Expression<String?>("premiered")
    private let ended = Expression<String?>("ended")
    private let officialSite = Expression<String?>("officialSite")
    private let rating = Expression<Int?>("rating")
    private let imageUrl = Expression<String?>("imageUrl")
    private let summary = Expression<String?>("summary")
    private let isFavorite = Expression<Bool?>("isFavorite")
    private let externals = Expression<String?>("externals")
    
    private init() {
        do {
            let fileURL = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                .appendingPathComponent("shows_database.sqlite3")
            
            dbConnection = try Connection(fileURL.path)
            
            try createShowsTable()
        } catch {
            print("Error opening database: \(error)")
            dbConnection = nil
        }
    }
    
    private func createShowsTable() throws {
        try dbConnection?.run(showsTable.create(ifNotExists: true) { table in
            table.column(id)
            table.column(elementId, primaryKey: .autoincrement)
            table.column(url)
            table.column(name)
            table.column(type)
            table.column(language)
            table.column(genres)
            table.column(status)
            table.column(runtime)
            table.column(premiered)
            table.column(ended)
            table.column(officialSite)
            table.column(rating)
            table.column(imageUrl)
            table.column(summary)
            table.column(isFavorite)
            table.column(externals)
        })
    }
    
    // MARK: - CRUD Operations
    
    func insertShow(show: ShowModel) {
        do {
            let insert = showsTable.insert(
                id <- show.id ?? 0,
                url <- show.url ?? "",
                name <- show.name ?? "",
                type <- show.type ?? "",
                language <- show.language ?? "",
                genres <- show.genres?.joined(separator: ","),
                status <- show.status ?? "",
                runtime <- show.runtime ?? 0,
                premiered <- show.premiered ?? "",
                ended <- show.ended ?? "",
                officialSite <- show.officialSite ?? "",
                rating <- show.rating ?? 0,
                imageUrl <- show.imageUrl ?? "",
                summary <- show.summary ?? "",
                isFavorite <- show.isFavorite ?? false,
                externals <- show.externals ?? ""
            )
            try dbConnection?.run(insert)
        } catch {
            print("Error inserting show: \(error)")
        }
    }
    
    func getAllShows() -> [ShowModel] {
        var shows: [ShowModel] = []
        
        do {
            for row in try dbConnection!.prepare(showsTable) {
                let show = ShowModel(
                    id: row[id],
                    elementId: row[elementId],
                    url: row[url],
                    name: row[name],
                    type: row[type],
                    language: row[language],
                    genres: row[genres]?.components(separatedBy: ","),
                    status: row[status],
                    runtime: row[runtime],
                    premiered: row[premiered],
                    ended: row[ended],
                    officialSite: row[officialSite],
                    rating: row[rating],
                    summary: row[summary],
                    externals: row[externals],
                    imageUrl: row[imageUrl],
                    isFavorite: row[isFavorite]
                )
                shows.append(show)
            }
        } catch {
            print("Error fetching shows: \(error)")
        }
        
        return shows
    }
    
    func deleteShow(id: Int) {
        let show = showsTable.filter(self.id == id)
        do {
            let deletedRows = try dbConnection?.run(show.delete())
            if deletedRows == nil {
                print("No rows were eliminated for the ID \(id)")
            }
        } catch {
            print("Error deleting show: \(error)")
        }
    }
}
