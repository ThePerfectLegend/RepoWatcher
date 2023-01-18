//
//  Contributors.swift
//  RepoWatcher
//
//  Created by Nizami Tagiyev on 18.01.2023.
//

import Foundation

struct Contributor: Identifiable {
    let id = UUID().uuidString
    let login: String
    let avatarUrl: String
    let contributions: Int
    let avatarData: Data
}

extension Contributor {
    struct CodingData: Decodable {
        let login: String
        let avatarUrl: String
        let contributions: Int
    }
    
    var contributor: Contributor {
        Contributor(login: login,
                    avatarUrl: avatarUrl,
                    contributions: contributions,
                    avatarData: Data())
    }
}
