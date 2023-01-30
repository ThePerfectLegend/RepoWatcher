//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nizami Tagiyev on 16.01.2023.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Image(uiImage: UIImage(data: repo.avatarData) ?? UIImage(systemName: "person.circle")!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.5)
                        .lineLimit(1)
                }
                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
            }
            Spacer()
            VStack {
                Text("\(repo.daysSinceLastActivity)")
                    .font(.system(size: 70, weight: .bold))
                    .frame(width: 90)
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                    .foregroundColor(repo.daysSinceLastActivity > 50 ? .pink : .green)
                Text("days ago")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
    }
}

fileprivate struct StatLabel: View {
    let value: Int
    let systemImageName: String
    
    var body: some View {
        Label {
            Text("\(value)")
                .font(.footnote)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        } icon: {
            Image(systemName: systemImageName)
                .foregroundColor(.green)
        }
        .fontWeight(.medium)
    }
}
