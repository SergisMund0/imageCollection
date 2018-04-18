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

private enum OauthComplete {
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
    
    private func authorize(completion: @escaping (OauthComplete)->Void) {
        tumblrOAuth.authorize(withCallbackURL: OAuthConstants.callbackURL, success: { (oauthCredentials, oauthResponse, oauthParameters) in
            completion(OauthComplete.success)
        }) { (oauthError) in
            completion(OauthComplete.failure)
        }
    }
}
