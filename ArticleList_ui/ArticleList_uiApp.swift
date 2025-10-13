//
//  ArticleList_uiApp.swift
//  ArticleList_ui
//
//  Created by Koushik Reddy Kambham on 10/13/25.
//

import SwiftUI

@main
struct ArticleList_uiApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = NewsViewModel(networkObj: NetworkManager.shared)
            ContentView(newsViewModel: viewModel)
        }
    }
}
