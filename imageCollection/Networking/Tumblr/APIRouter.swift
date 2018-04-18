//
//  APIRouter.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 18/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter {
    case fetchImages(tagged: String)
    
    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .fetchImages:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .fetchImages(let tag):
            return "/tagged?tag=\(tag)"
        }
    }
    
    // MARK: - URLStringRequest
    func asURLString() -> String {
        return APIConstants.baseURL.rawValue + path
    }
}
