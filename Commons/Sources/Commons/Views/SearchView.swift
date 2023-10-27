//
//  SearchView.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 13/3/22.
//

import Domain
import SwiftUI
import Foundation
import ComposableArchitecture

public enum SearchEvent {
    case searchBoxTouch
    case clearText
    case cancelAll
}

public struct SearchFeature: Reducer {
    public struct State: Equatable {
        public init () {}
        var searchBoxPlaceHolderText = "Search keyword..."
        var searchQuery = ""
        var isEditingSearch: Bool = false
        var isEntireLatter: Bool = false
    }

    public enum Action: Equatable {
        case searchQueryChanged(String)
        case searchQueryEditing(SearchEvent)
    }
    
    public init () {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case let .searchQueryChanged(query):
            struct SearchLocationId: Hashable {}

            if query.count > 0 {
                state.isEntireLatter = true
            } else {
                state.isEntireLatter = false
            }

            state.searchQuery = query

        case let .searchQueryEditing(isEditing):
            switch isEditing {
            case .clearText:
                state.searchQuery = ""
            case .searchBoxTouch:
                state.isEditingSearch = true
            case .cancelAll:
                state.searchQuery = ""
                state.isEditingSearch = false
            }
        }
        return .none
    }
}

struct SearchBarRepositoryView: View {
    let store: StoreOf<SearchFeature>
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                TextField(viewStore.state.searchBoxPlaceHolderText, text: viewStore.binding(
                    get: \.searchQuery, send: SearchFeature.Action.searchQueryChanged
                ))
                .padding(15)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .foregroundColor(Color.black)
                .cornerRadius(8)
            }
        }
    }
}

public struct SearchBarView: View {
    private let store: StoreOf<SearchFeature>
    
    public init(store: StoreOf<SearchFeature>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            HStack {
                SearchBarRepositoryView(store: store)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .foregroundColor(Color.black)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 15)
                            if viewStore.state.isEntireLatter {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                                    .onTapGesture {
                                        viewStore.send(.searchQueryEditing(.clearText))
                                    }
                            }
                        }
                    )

                if viewStore.state.isEditingSearch {
                    Button {
                        viewStore.send(.searchQueryEditing(.cancelAll))
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                        to: nil,
                                                        from: nil,
                                                        for: nil)
                    } label: {
                        Text("Cancel")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default, value: viewStore.state.isEditingSearch)
                }
            }
            .onTapGesture {
                viewStore.send(.searchQueryEditing(.searchBoxTouch))
            }
            .padding(.horizontal, 16)
        }
    }
}
