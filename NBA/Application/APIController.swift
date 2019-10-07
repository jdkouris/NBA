//
//  APIController.swift
//  NBA
//
//  Created by John Kouris on 10/7/19.
//  Copyright © 2019 John Kouris. All rights reserved.
//

import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkingError: Error {
    case noData
    case noBearer
    case serverError(Error)
    case unexpectedStatusCode
    case badDecode
}

class APIController {
    
    private let baseURL = URL(string: "https://free-nba.p.rapidapi.com/players")!
    let headers = [
        "x-rapidapi-host": "free-nba.p.rapidapi.com",
        "x-rapidapi-key": "28e12433femsh7d97d7c2469e068p199c9djsn14672ad2ac4d"
    ]
    
    var players: [Player] = []
    
    func getAllPlayers(completion: @escaping (Result<PlayerSearch, NetworkingError>) -> Void) {
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error fetching players: \(error)")
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let players = try JSONDecoder().decode(PlayerSearch.self, from: data)
                self.players = players.data
                completion(.success(players))
            } catch {
                NSLog("Error decoding players: \(error)")
                completion(.failure(.badDecode))
            }
        }.resume()
        
    }
    
}
