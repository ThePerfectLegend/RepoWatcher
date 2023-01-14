//
//  Repository.swift
//  RepoWatcher
//
//  Created by Nizami Tagiyev on 14.01.2023.
//

import Foundation

struct Repository: Decodable {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String
    
    static let placeholder = Repository(name: "Your Repo",
                                        owner: Owner(avatarUrl: ""),
                                        hasIssues: true,
                                        forks: 12,
                                        watchers: 35,
                                        openIssues: 3,
                                        pushedAt: "2023-01-10T12:43:31Z")
    
}

struct Owner: Decodable {
    let avatarUrl: String
}
