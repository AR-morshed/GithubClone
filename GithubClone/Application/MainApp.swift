//
//  MainApp.swift
//  GithubClone
//
//  Created by Rokon on 11/9/21.
//

import ComposableArchitecture
import SwiftUI
import Root

#warning("Please rename to your app name")
@main
struct MainApp: App {
    let store = Store(initialState: Root.State()) {
        Root()
    }

    var body: some Scene {
        WindowGroup {
            RootView(store: store)
        }
    }
}
