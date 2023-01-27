//
//  UserDefaults.swift
//  RepoWatcher
//
//  Created by Nizami Tagiyev on 26.01.2023.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.NizamiDev.RepoWatcher")!
    }
    
    static let repoKey = "repos"
}

enum UserDefaultsError: Error {
    case retrieval
}
