//
//  LocalNotification.swift
//  NetworkPlatform
//
//  Created by Md. Arman Morshed on 25/11/21.
//

import Combine
import Foundation

// https://stackoverflow.com/questions/58559908/combine-going-from-notification-center-addobserver-with-selector-to-notificatio

class NetworkLoadingNotificationSender {
    var loading: Bool

    init(_ loadingToSend: Bool) {
        loading = loadingToSend
    }

    static let notification = Notification.Name("NetworkLoadingNotification")
}

class NetworkInfoNotificationSender {
    var message: String

    init(_ messageToSend: String) {
        message = messageToSend
    }

    static let notification = Notification.Name("NetworkPopupNotification")
}
