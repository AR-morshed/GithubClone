//
//  TrendingRepositoryView.swift
//  MonstarHubSwiftUI
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Commons
import SwiftUI
import TrendingDetails
import ComposableArchitecture

public struct TrendingRepositoryView: View, ClientStoreBased {
    public typealias Feature = TrendingRepositoryFeature
    public let store: StoreOf<Feature>
    
    public init(store: StoreOf<Feature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ZStack {
                    VStack {
                        SearchBarView(store: self.store.scope(state: \.searchState,
                                                              action: TrendingRepositoryFeature.Action.search))

                        ScrollView(showsIndicators: false) {
                            VStack {
                                ForEach(viewStore.trendingRepositories, id: \.self) { repository in
                                    NavigationLink(
                                        destination:
                                        TrendingDetailsView(store:
                                            self.store.scope(state: \.trendingDetailsState,
                                                             action: TrendingRepositoryFeature.Action.details))
                                            .onAppear {
                                                viewStore.send(.presentDetails(repository))
                                            },
                                        label: {
                                            HStack(alignment: .top, spacing: 20) {
                                                AsyncImage(
                                                    url: URL(string: repository.avatar ?? ""),
                                                    content: { image in
                                                        image.resizable()
                                                            .frame(width: 72, height: 72)
                                                            .clipShape(Circle())
                                                    },
                                                    placeholder: {
                                                        Image(systemName: "photo.circle.fill")
                                                            .font(.system(size: 64))
                                                            .foregroundColor(.gray)
                                                    }
                                                )

                                                VStack(alignment: .leading, spacing: 5) {
                                                    Text(repository.author ?? "")
                                                        .font(.title2)
                                                        .fontWeight(.bold)
                                                    Text(repository.name ?? "")
                                                        .font(.body)
                                                    HStack {
                                                        Image(systemName: "star.fill")
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 16, height: 16)
                                                        Text("\(repository.stars ?? 0)")
                                                            .font(.body)
                                                    }

                                                    HStack {
                                                        Image("fork_icon")
                                                            .resizable()
                                                            .renderingMode(.template)
                                                            .aspectRatio(contentMode: .fit)
                                                            .frame(width: 18, height: 20)
                                                        Text("\(repository.forks ?? 0)")
                                                            .font(.body)
                                                    }
                                                    Divider()
                                                }
                                            }
                                        }
                                    )
                                }
                            }
                            .padding()
                        }

                        if viewStore.state.isLoadingRepositoryView {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        }
                    }
                }
                .navigationTitle("Trending Repositories")
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}

struct TrendingRepositoryView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingRepositoryView(
            store: Store(initialState: TrendingRepositoryFeature.State()) {  TrendingRepositoryFeature()
            })
    }
}
