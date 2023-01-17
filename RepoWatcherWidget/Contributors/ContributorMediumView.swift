//
//  ContributorMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nizami Tagiyev on 17.01.2023.
//

import SwiftUI

struct ContributorMediumView: View {
    var body: some View {
        VStack {
            Text("Top Contributors")
                .font(.caption)
                .bold()
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2),
                      alignment: .leading,
                      spacing: 20) {
                ForEach(0..<4) { contributor in
                    HStack {
                        Image(uiImage: UIImage(systemName: "person.circle")!)
                            .resizable()
                            .frame(width: 44, height: 44)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.caption)
                                .minimumScaleFactor(0.7)
                                .lineLimit(1)
                            Text("43")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
            
        }
        .padding()
    }
}
