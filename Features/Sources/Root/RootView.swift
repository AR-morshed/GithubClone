//
//  MainView.swift
//  MonstarHubSwiftUI
//
//  Created by Rokon on 11/9/21.
//

import SwiftUI
import TrendingRepository
import ComposableArchitecture

public struct RootView: View {
    let store: StoreOf<Root>
    
    public init(store: StoreOf<Root>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            TabView {
                TrendingRepositoryView(
                    store: store.scope(state: \.trendingRepositoryState,
                                       action: Root.Action.trendingRepositoryAction))
                .tabItem {
                    Label("Repositories", systemImage: "book.closed.fill")
                }
            }
            .onAppear(perform: {
                if #available(iOS 15.0, *) {
                    let appearance = UITabBarAppearance()
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            })
            .padding(.top, 10)
        }
    }
}
