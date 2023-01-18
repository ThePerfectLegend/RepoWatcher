//
//  MockData.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nizami Tagiyev on 17.01.2023.
//

import Foundation

struct MockData {
    static let repoOne = Repository(name: "First Repo",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: true,
                                    forks: 12,
                                    watchers: 35,
                                    openIssues: 3,
                                    pushedAt: "2023-01-10T12:43:31Z",
                                    contributorsUrl: "",
                                    avatarData: Data(),
                                    contributors: [Contributor(login: "Nizami", avatarUrl: "", contributions: 23, avatarData: Data())])
    static let repoTwo = Repository(name: "Second Repo",
                                    owner: Owner(avatarUrl: ""),
                                    hasIssues: false,
                                    forks: 9,
                                    watchers: 156,
                                    openIssues: 3,
                                    pushedAt: "2022-07-02T12:43:31Z",
                                    contributorsUrl: "",
                                    avatarData: Data())
}
