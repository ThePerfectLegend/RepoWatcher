//
//  RepoWatcherWidgetBundle.swift
//  CompactRepoWidget
//
//  Created by Nizami Tagiyev on 14.01.2023.
//

import WidgetKit
import SwiftUI

@main
struct RepoWatcherWidgetBundle: WidgetBundle {
    var body: some Widget {
        SingleRepoWidget()
        DoubleRepoWidget()
    }
}
