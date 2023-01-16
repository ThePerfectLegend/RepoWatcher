//
//  RepoWatcherWidget.swift
//  RepoWatcherWidget
//
//  Created by Nizami Tagiyev on 14.01.2023.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> RepositoryEntry {
        RepositoryEntry(date: Date(), repo: Repository.placeholder)
    }

    func getSnapshot(in context: Context, completion: @escaping (RepositoryEntry) -> ()) {
        let entry = RepositoryEntry(date: Date(), repo: Repository.placeholder)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
            
            do {
                var repo = try await NetworkManager.shared.getRepo(url: "https://api.github.com/repos/twostraws/HackingWithSwift")
                let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
                repo.avatarData = avatarImageData ?? Data()
                let entry = RepositoryEntry(date: .now, repo: repo)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)
            } catch {
                print("❌ Error: \(error.localizedDescription)")
            }
        }
    }
}

struct RepositoryEntry: TimelineEntry {
    let date: Date
    let repo: Repository
}

struct RepoWatcherWidgetEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: RepositoryEntry

    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            VStack(spacing: 36) {
                RepoMediumView(repo: entry.repo)
                RepoMediumView(repo: entry.repo)
            }
        default:
            EmptyView()
        }
    }
}

struct RepoWatcherWidget: Widget {
    let kind: String = "RepoWatcherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RepoWatcherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Repo Watcher")
        .description("Keep on eye on one or two GitHub repositories.")
        .supportedFamilies([.systemMedium, .systemLarge])
    }
}
