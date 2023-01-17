//
//  CompactRepoWidget.swift
//  CompactRepoWidget
//
//  Created by Nizami Tagiyev on 14.01.2023.
//

import WidgetKit
import SwiftUI

struct CompactRepoProvider: TimelineProvider {
    func placeholder(in context: Context) -> CompactRepoEntry {
        CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
    }

    func getSnapshot(in context: Context, completion: @escaping (CompactRepoEntry) -> ()) {
        let entry = CompactRepoEntry(date: Date(), repo: MockData.repoOne, bottomRepo: MockData.repoTwo)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                // MARK: Get top repo
                var repo = try await NetworkManager.shared.getRepo(url: "https://api.github.com/repos/twostraws/HackingWithSwift")
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                
                // MARK: Get bottom repo if in large widget
                var bottomRepo: Repository?
                if context.family == .systemLarge {
                    bottomRepo = try await NetworkManager.shared.getRepo(url: "https://api.github.com/repos/SwiftfulThinking/SwiftfulUI")
                    let avatarImageData = await NetworkManager.shared.downloadImageData(from: bottomRepo!.owner.avatarUrl)
                    bottomRepo!.avatarData = avatarImageData ?? Data()
                }
                
                // MARK: Create Entry Timeline
                let entry = CompactRepoEntry(date: .now, repo: repo, bottomRepo: bottomRepo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }
}

struct CompactRepoEntry: TimelineEntry {
    let date: Date
    let repo: Repository
    let bottomRepo: Repository?
}

struct CompactRepoEntryView: View {
    @Environment(\.widgetFamily) var family
    var entry: CompactRepoEntry

    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            if let unwrappedBottomRepo = entry.bottomRepo {
                RepoLargeView(topRepo: entry.repo, bottomRepo: unwrappedBottomRepo)
            }
        default:
            EmptyView()
        }
    }
}

struct CompactRepoWidget: Widget {
    let kind: String = "CompactRepoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CompactRepoProvider()) { entry in
            CompactRepoEntryView(entry: entry)
        }
        .configurationDisplayName("Repo Watcher")
        .description("Keep on eye on one or two GitHub repositories.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}
