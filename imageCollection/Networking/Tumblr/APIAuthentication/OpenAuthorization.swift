//
//  OpenAuthorization.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 18/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import OAuthSwift
import OAuthSwiftAlamofire
import Alamofire

private enum OauthResult {
    case success
    case failure
}

final class TumblrOAuth {
    private let tumblrOAuth = OAuth1Swift(consumerKey: OAuthConstants.consumerKey,
                                          consumerSecret: OAuthConstants.consumerSecret,
                                          requestTokenUrl: OAuthConstants.requestTokenURL,
                                          authorizeUrl: OAuthConstants.authorizeURL,
                                          accessTokenUrl: OAuthConstants.accessTokenURL)
    
    private var oauthRequestAdapter: OAuthSwiftRequestAdapter?
    private let sessionManager = SessionManager.default
    
    func getSessionManager(completion: @escaping (SessionManager)->Void) {
        authorize { (oauthComplete) in
            switch oauthComplete {
            case .success:
                self.oauthRequestAdapter = self.tumblrOAuth.requestAdapter
                self.sessionManager.adapter = self.oauthRequestAdapter
                completion(self.sessionManager)
            case .failure:
                print("Authorization error")
            }
        }
    }
    
    private func authorize(completion: @escaping (OauthResult)->Void) {
        if self.hasOauthCredential() {
            do {
                // Create a new Keychain items for the open authentication credentials.
                let oauthTokenPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: OAuthKeys.oauthToken)
                let oauthTokenSecretPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: OAuthKeys.oauthTokenSecret)
                
                // Read the password for the items.
                let oauthTokenPassword = try oauthTokenPasswordItem.readPassword()
                let oauthTokenSecretPassword = try oauthTokenSecretPasswordItem.readPassword()
                
                // Setup the open authorization credentials for the session.
                tumblrOAuth.client.credential.oauthToken = oauthTokenPassword
                tumblrOAuth.client.credential.oauthTokenSecret = oauthTokenSecretPassword
                completion(OauthResult.success)
            }
            catch {
                fatalError("Error reading password from keychain - \(error)")
            }
        } else {
            // // Request an Open Authorization to Tumblr server.
            tumblrOAuth.authorize(withCallbackURL: OAuthConstants.callbackURL, success: { (oauthCredentials, oauthResponse, oauthParameters) in
                do {
                    let oauthTokenPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: OAuthKeys.oauthToken)
                    let oauthTokenSecretPasswordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName, account: OAuthKeys.oauthTokenSecret)
                    
                    // Save the password for the new items.
                    try oauthTokenPasswordItem.savePassword(oauthCredentials.oauthToken)
                    try oauthTokenSecretPasswordItem.savePassword(oauthCredentials.oauthTokenSecret)
                }
                catch {
                    fatalError("Error updating keychain - \(error)")
                }
                // If credentials have been stored successfully, changes the state of the hasOauthCredentialKey variable.
                UserDefaults.standard.set(true, forKey: UserDefaultsConstants.hasOauthCredentialKey)
                completion(OauthResult.success)
            }) { (oauthError) in
                completion(OauthResult.failure)
            }
        }
    }
    
    /// This function checks if the open authorization credentials has been stored.
    ///
    /// - Returns: A Boolean value that indicates whether the information is stored.
    private func hasOauthCredential() -> Bool {
        return UserDefaults.standard.bool(forKey: UserDefaultsConstants.hasOauthCredentialKey)
    }
}
