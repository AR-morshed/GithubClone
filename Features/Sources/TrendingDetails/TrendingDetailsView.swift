//
//  TrendingDetailsView.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 23/3/22.
//

import Commons
import SwiftUI
import ComposableArchitecture

public struct TrendingDetailsView: View, StoreBased {
    public let store: StoreOf<Feature>
    public typealias Feature = TrendingDetailsFeature
    
    public init(store: StoreOf<Feature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading) {
                AsyncImage(
                    url: URL(string: viewStore.trendingRepository?.avatar ?? ""),
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

                Text("Details info")
                    .font(.title)
                    .fontWeight(.bold)
                Text(
                    """
                     **Stars** : \(safeUnwrap(viewStore.trendingRepository?.stars)) | **Forks** : \(safeUnwrap(viewStore.trendingRepository?.forks))
                           **Language**   : \(safeUnwrap(viewStore.trendingRepository?.language))
                           **Author**     : \(safeUnwrap(viewStore.trendingRepository?.author))
                           **Name**       : \(safeUnwrap(viewStore.trendingRepository?.name))
                           **Fullname**   : \(safeUnwrap(viewStore.trendingRepository?.fullname))
                           **Description**: \(safeUnwrap(viewStore.trendingRepository?.descriptionField))

                    """
                ).font(.title3)

                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }

    func safeUnwrap(_ string: Any?) -> String {
        if let str = string as? String {
            return str
        } else if let str = string as? Int {
            return "\(str)"
        }
        return "\(string ?? 0.0)"
    }
}
