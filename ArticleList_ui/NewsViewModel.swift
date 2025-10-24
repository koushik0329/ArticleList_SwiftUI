//
//  NewsViewModel.swift
//  NewsListII
//
//  Created by Koushik Reddy Kambham on 10/11/25.
//

import SwiftUI

@Observable
class NewsViewModel {

    //made it as published
    var news : [News] = []
    let networkObj : Network
    
    var onUpdate: (() -> Void)?
    
    init(networkObj : Network) {
        self.networkObj = networkObj
    }
    
    func loadNews() async throws{
        do{
            let newsList : NewsList = try await networkObj.fetchData(from: Server.endPoint.rawValue)
            news = newsList.articles
            onUpdate?()
        }
        catch {
            throw NetworkError.requestFailed(error)
        }
    }
    
    func loadImage(from urlString: String?) async -> UIImage? {
        guard let url = urlString else {
            return UIImage(systemName: "photo")
        }

        do {
            let image = try await networkObj.fetchImage(from: url)
            return image
        } catch {
            return UIImage(systemName: "x.circle")
        }
    }
    
}
