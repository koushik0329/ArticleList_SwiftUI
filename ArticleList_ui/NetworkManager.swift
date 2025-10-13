//
//  NetworkManager.swift
//  NewsListII
//
//  Created by Koushik Reddy Kambham on 10/11/25.
//

import Foundation
import UIKit

protocol Network {
    func fetchData<T: Decodable>(from urlString : String) async throws -> T
    func fetchImage(from urlString : String) async throws -> UIImage
}

class NetworkManager : Network {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchData<T: Decodable>(from urlString : String) async throws -> T {

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let fetchedData = try JSONDecoder().decode(T.self, from: data)
            return fetchedData
        }
        catch {
            throw NetworkError.requestFailed(error)
        }
    }
    
    func fetchImage(from urlString : String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                throw NetworkError.invalidURL
            }
            return image
        }
        catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
