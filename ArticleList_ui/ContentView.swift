//
//  ContentView.swift
//  ArticleList_ui
//
//  Created by Koushik Reddy Kambham on 10/13/25.
//

import SwiftUI

struct ContentView: View {
    var newsViewModel : NewsViewModel
    
    init(newsViewModel: NewsViewModel) {
        self.newsViewModel = newsViewModel
    }
    
    var body : some View {
        
        VStack{
            Text("News")
                .font(.title)
            
            List(newsViewModel.news, id: \.self) { article in
                RowView(
                    title: article.author ?? "",
                    description: article.description ?? "",
                    imageTitle: article.urlToImage ?? "",
                    dateLabel: article.publishedAt ?? "",
                    imageLoader: ImageLoader()
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
    @ObservedObject private var imageLoader : ImageLoader
    
    init(
        title: String?,
        description: String?,
        imageTitle: String?,
        dateLabel: String?,
        imageLoader: ImageLoader
    ) {
        self.title = title
        self.description = description
        self.imageTitle = imageTitle
        self.dateLabel = dateLabel
        self.imageLoader = imageLoader
    }
    
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
    
            
            if let image = imageLoader.image {
                Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: .infinity, height: .infinity)
            }
        }
        .task {
            if let urlString = imageTitle {
                await imageLoader.loadImage(from: urlString)
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    func loadImage(from urlString: String) async {
        let viewModel = NewsViewModel(networkObj: NetworkManager.shared)
        image = await viewModel.loadImage(from: urlString)
    }
}

#Preview {
    let viewModel = NewsViewModel(networkObj: NetworkManager.shared)
    
    ContentView(newsViewModel: viewModel)
}
