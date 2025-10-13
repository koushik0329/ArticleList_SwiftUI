//
//  ContentView.swift
//  ArticleList_ui
//
//  Created by Koushik Reddy Kambham on 10/13/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var newsViewModel : NewsViewModel
    
    init(newsViewModel: NewsViewModel) {
        self.newsViewModel = newsViewModel
    }
    
    let sampleList = Array(repeating: "Sample", count: 10)
    
    var body : some View {
        
        VStack{
            Text("News")
                .font(.title)
            
            List(newsViewModel.news, id: \.self) { article in
                RowView(
                    title: article.author ?? "",
                    description: article.description ?? "",
                    imageTitle: article.urlToImage ?? "",
                    dateLabel: article.publishedAt ?? ""
                )
            }
        }
        .task {
            do {
                try await newsViewModel.loadNews()
            } catch {
                print("Failed to load news: \(error)")
            }
        }
    }
}

struct RowView : View {
    
    var title : String?
    var description : String?
    var imageTitle : String?
    var dateLabel : String?
    
    var body : some View {
        HStack {
            VStack(alignment: .leading, spacing: 5)  {
                Text(title ?? "")
                    .font(.title2)
                    .foregroundColor(.blue)
                    
                Text(description ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack {
                    
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.blue)
                    
                    Text(dateLabel ?? "")
                        .font(.subheadline)
                        .foregroundColor(.gray.opacity(0.8))
                }
            }
            
            Spacer()
            
            Image(imageTitle ?? "")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
    }
}

#Preview {
    let viewModel = NewsViewModel(networkObj: NetworkManager.shared)
    
    ContentView(newsViewModel: viewModel)
}
