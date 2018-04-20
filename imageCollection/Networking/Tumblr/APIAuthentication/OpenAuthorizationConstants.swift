//
//  OpenAuthorizationConstants.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 18/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

/// OAuth setup constants.
struct OAuthConstants {
    static let consumerKey = "oHDfCSisWD5euj37WAjgvh8536rotvOKfRQHo5satW344Y1GvS"
    static let consumerSecret = "xeVgJFAb5rI5baSVpeIb5iBof8LYgrhjlIsydQ2sE5E6r7HidL"
    static let requestTokenURL = "https://www.tumblr.com/oauth/request_token"
    static let authorizeURL = "https://www.tumblr.com/oauth/authorize"
    static let accessTokenURL = "https://www.tumblr.com/oauth/access_token"
    static let callbackURL = "imageCollection://oauth-callback"
}


/// Keys used to store OAuth credentials in Keychain.
struct OAuthKeys {
    static let oauthToken = "oauthToken"
    static let oauthTokenSecret = "oauthTokenSecret"
}

/// Key used to read if there are values stored in the Keychain.
struct UserDefaultsConstants {
    static let hasOauthCredentialKey = "hasOauthCredential"
}
