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
    case urlError
}

class APIController {
    
    private let baseURL = URL(string: "https://free-nba.p.rapidapi.com")!
    
    let headers = Headers.shared.headers
    
    var players: [Player] = []
    
    func getAllPlayers(completion: @escaping (Result<PlayerSearch, NetworkingError>) -> Void) {
        let playersURL = baseURL.appendingPathComponent("players")
        var request = URLRequest(url: playersURL)
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
    
    func searchFor(player: String, completion: @escaping (Result<PlayerSearch, NetworkingError>) -> Void) {
        let playersURL = baseURL.appendingPathComponent("players")
        var components = URLComponents(url: playersURL, resolvingAgainstBaseURL: true)
        let searchQueryItem = URLQueryItem(name: "search", value: player)
        components?.queryItems = [searchQueryItem]
        
        guard let requestURL = components?.url else {
            completion(.failure(.urlError))
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.serverError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.failure(.unexpectedStatusCode))
                return
            }
            
            guard let data = data else {
                NSLog("No data returned from player search")
                completion(.failure(.noData))
                return
            }
            
            do {
                let players = try JSONDecoder().decode(PlayerSearch.self, from: data)
                self.players = players.data
                completion(.success(players))
            } catch {
                NSLog("Unable to decode data into PlayerSearch: \(error)")
                completion(.failure(.badDecode))
            }
            
        }.resume()
        
    }
    
}
