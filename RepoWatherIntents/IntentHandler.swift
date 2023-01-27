//
//  IntentHandler.swift
//  RepoWatherIntents
//
//  Created by Nizami Tagiyev on 27.01.2023.
//

import Intents

// MARK: Communication layer between app data and selection option in widget
class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}

extension IntentHandler: SelectSingleRepoIntentIntentHandling {
    
    // MARK: Getting data from UserDefaults for showing available selection options
    func provideRepoOptionsCollection(for intent: SelectSingleRepoIntentIntent) async throws -> INObjectCollection<NSString> {
        guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
            throw UserDefaultsError.retrieval
        }
        return INObjectCollection(items: repos as [NSString])
    }
    
    //MARK: Optional default value, don't use if wanna make blank selection option. Keeps widget black until selecting
    func defaultRepo(for intent: SelectSingleRepoIntentIntent) -> String? {
        return "sallen0400/swift-news"
    }
}

extension IntentHandler: SelectTwoReposIntentHandling {
    
    func provideTopRepoOptionsCollection(for intent: SelectTwoReposIntent) async throws -> INObjectCollection<NSString> {
        guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
            throw UserDefaultsError.retrieval
        }
        return INObjectCollection(items: repos as [NSString])
    }
    
    func provideBottomRepoOptionsCollection(for intent: SelectTwoReposIntent) async throws -> INObjectCollection<NSString> {
        guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else {
            throw UserDefaultsError.retrieval
        }
        return INObjectCollection(items: repos as [NSString])
    }
}
