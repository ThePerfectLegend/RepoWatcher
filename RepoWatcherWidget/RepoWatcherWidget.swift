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
        var entries: [RepositoryEntry] = []

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct RepositoryEntry: TimelineEntry {
    let date: Date
    let repo: Repository
}

struct RepoWatcherWidgetEntryView : View {
    var entry: RepositoryEntry

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .frame(width: 50, height: 50)
                    Text(entry.repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                HStack {
                    StatLabel(value: entry.repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: entry.repo.forks, systemImageName: "tuningfork")
                    StatLabel(value: entry.repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                }
            }
            Spacer()
            VStack {
                Text("99")
                    .font(.system(size: 70, weight: .bold))
                    .frame(width: 90)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                Text("days ago")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

struct RepoWatcherWidget: Widget {
    let kind: String = "RepoWatcherWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            RepoWatcherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}


fileprivate struct StatLabel: View {
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
        } icon: {
            Image(systemName: systemImageName)
                .foregroundColor(.green)
        }
        .fontWeight(.medium)
    }
}
