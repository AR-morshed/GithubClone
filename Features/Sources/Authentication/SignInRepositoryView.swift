//
//  SigninRepository.swift
//  MonstarHubSwiftUI
//
//  Created by BD Mobile Team on 5/3/22.
//

import ComposableArchitecture
import SwiftUI

public struct SignInRepositoryView: View {
    private let store: StoreOf<AuthenticationFeature>
    @State private var isPresent: Bool
    
    public init(store: StoreOf<AuthenticationFeature>, isPresent: Bool = false) {
        self.store = store
        self.isPresent = isPresent
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()

                    VStack {
                        Text("Sign In")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 30)

                        SocialLoginButton(image: Image(R.image.apple),
                                          text: Text("Sign in with Apple"))

                        SocialLoginButton(image: Image(R.image.google),
                                          text: Text("Sign in with Google")
                                              .foregroundColor(Color("PrimaryColor")))
                            .padding(.vertical)

                        Text("or enter a valid mail")
                            .foregroundColor(Color.black.opacity(0.4))

                        TextField("Work email address", text: viewStore.binding(
                            get: \.email, send: AuthenticationFeature.Action.emailTypingChanged
                        ))
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08),
                                radius: 60,
                                x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,
                                y: 16)
                        .padding(.vertical)
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .textContentType(.emailAddress)

                        PrimaryButton(title: "sign in")
                            .onTapGesture {
                                viewStore.send(.checkValidation)
                            }
                    }
                    Spacer()
                    Divider()
                    Spacer()
                    Text("You are completely safe.")
                    Text("Read our Terms & Conditions.")
                        .foregroundColor(Color("PrimaryColor"))
                    Spacer()
                }

                .padding()
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct SocialLoginButton: View {
    var image: Image
    var text: Text

    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}
