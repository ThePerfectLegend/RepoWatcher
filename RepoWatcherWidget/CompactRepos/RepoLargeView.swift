//
//  RepoLargeView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Nizami Tagiyev on 17.01.2023.
//

import SwiftUI

struct RepoLargeView: View {
    let topRepo: Repository
    let bottomRepo: Repository
    
    var body: some View {
        VStack(spacing: 36) {
            RepoMediumView(repo: topRepo)
            RepoMediumView(repo: bottomRepo)
        }
    }
}
