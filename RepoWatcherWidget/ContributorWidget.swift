//
//  ContributorWidget.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nizami Tagiyev on 17.01.2023.
//

import WidgetKit
import SwiftUI

struct ContributorProvider: TimelineProvider {
    func placeholder(in context: Context) -> ContributorEntry {
        ContributorEntry(date: Date(), repo: MockData.repoOne)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> Void) {
        let entry = ContributorEntry(date: Date(), repo: MockData.repoOne)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>) -> Void) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                //MARK: Get Repo
                var repo = try await NetworkManager.shared.getRepo(url: "https://api.github.com/repos/kodecocodes/swift-style-guide")
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                //MARK: Get Contributors
                let contributors = try await NetworkManager.shared.getContributors(url: repo.contributorsUrl)
                
                //MARK: Filter to top 4
                var topFour = Array(contributors.prefix(4))
                
                //MARK: Download top 4 avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avatarData = avatarData ?? Data()
                }
                
                repo.contributors = topFour
                
                //MARK: Create entry and timeline
                let entry = ContributorEntry(date: Date(), repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error: \(error.localizedDescription)")
            }

        }
    }
}

struct ContributorEntry: TimelineEntry {
    let date: Date
    let repo: Repository
}

struct ContributorEntryView: View {
    var entry: ContributorEntry
    
    var body: some View {
        VStack {
            RepoMediumView(repo: entry.repo)
            ContributorMediumView(repo: entry.repo)
        }
    }
}

struct ContributorWidget: Widget {
    let kind: String = "ContributorWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ContributorProvider()) { entry in
            ContributorEntryView(entry: entry)
        }
        .configurationDisplayName("Contributors")
        .description("Keep track of repository's top contributors.")
        .supportedFamilies([.systemLarge])
    }
}
