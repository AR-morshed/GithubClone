//
//  TrendingDeveloperView.swift
//  MonstarHubSwiftUI
//
//  Created by Md. Arman Morshed on 30/11/21.
//

import Commons
import SwiftUI
import ComposableArchitecture

public struct TrendingDeveloperView: View, ClientStoreBased {
    public typealias Feature = TrendingDevelopersFeature
    public let store: StoreOf<Feature>
    
    public init(store: StoreOf<Feature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ZStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 10) {
                            ForEach(viewStore.trendingUsers, id: \.self) { developer in
                                VStack(alignment: .leading) {
                                    HStack(alignment: .top, spacing: 20) {
                                        AsyncImage(
                                            url: URL(string: developer.avatar ?? ""),
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
                                            Text(developer.name ?? "")
                                                .font(.title2)
                                                .fontWeight(.bold)
                                            Text(developer.username ?? "")
                                                .font(.body)
                                            Text(developer.url ?? "")
                                                .font(.footnote)
                                        }
                                    }
                                    Divider()
                                }
                            }
                        }
                        .padding()
                    }

                    if viewStore.state.isLoadingDeveloperView {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .frame(width: 800, height: 800, alignment: .center)
                    }
                }
                .navigationTitle("Trending Developers")
                .onAppear {
                    viewStore.send(.onAppear)
                }
                .alert(self.store.scope(state: \.alert), dismiss: .alertDismissed)
            }
        }
    }
}

struct TrendingDeveloperView_Previews: PreviewProvider {
    static var previews: some View {
        TrendingDeveloperView(store:
            Store(initialState: TrendingDevelopersFeature.State(), reducer: TrendingDevelopersFeature())
        )
    }
}
