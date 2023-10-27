//
//  AuthenticationFeature.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 6/3/22.
//

import Commons
import SwiftUI
import ComposableArchitecture

public struct AuthenticationFeature: Reducer {
    public struct State: Equatable {
        public var isSignIn = false
        var alert: AlertState<LoginAction>?
        var email: String = ""
        var isActivityIndicatorVisible: Bool = false
        var isFormDisabled: Bool = false
        var isLoginButtonDisabled: Bool = false
        var password: String = ""
        var isTwoFactorActive: Bool = false
        var presentTrendingView: Bool = false
        
        public init() {}
    }

    public enum Action: Equatable {
        case emailTypingChanged(String)
        case checkValidation
        case presentHomeView(Result<Bool, Never>)
        case onDidPresent
        case loginSuccessful
        case onAppear
    }
    
    public init() {}

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .emailTypingChanged:
            return .none

        case .presentHomeView:
            return .none

        case .checkValidation:
            AppPersistence.isSignIn = true
            state.isSignIn = true

        case .onDidPresent:
            return .none

        case .loginSuccessful:
            return .none

        case .onAppear:
            state.isSignIn = AppPersistence.isSignIn
        }
        return .none
    }
}

public enum LoginAction: Equatable {
    case alertDismissed
    case emailChanged(String)
    case passwordChanged(String)
    case loginButtonTapped
}
