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
        ContributorEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ContributorEntry) -> Void) {
        let entry = ContributorEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<ContributorEntry>) -> Void) {
        let nextUpdate = Date().addingTimeInterval(43200) // 12 hours in seconds
        
        let entry = ContributorEntry(date: Date())
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct ContributorEntry: TimelineEntry {
    let date: Date
}

struct ContributorEntryView: View {
    var entry: ContributorEntry
    
    var body: some View {
        Text(entry.date.description)
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
