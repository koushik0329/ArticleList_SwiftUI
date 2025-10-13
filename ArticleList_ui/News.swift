//
//  News.swift
//  NewsListII
//
//  Created by Koushik Reddy Kambham on 10/11/25.
//
import Foundation

//made hashable
struct News : Decodable, Hashable {
    let author : String?
    let description : String?
    let publishedAt : String?
    let urlToImage : String?
}

struct NewsList : Decodable {
    var articles : [News]
}
