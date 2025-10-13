//
//  NetworkError.swift
//  NewsListII
//
//  Created by Koushik Reddy Kambham on 10/11/25.
//

import Foundation

enum NetworkError : Error {
    case invalidURL
    case requestFailed(Error)
    case decodingFailed(Error)
    
    var userMessage: String {
        switch self {
        case .invalidURL :
            return "invalid url"
        case .requestFailed(let error):
            return "request failed: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "decoding failed: \(error.localizedDescription)"
        }
    }
}
