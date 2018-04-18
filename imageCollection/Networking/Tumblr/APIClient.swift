//
//  APIClient.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 18/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import Alamofire

final class APIClient {
    func fetchImages(tagged: String, completion: @escaping (_ entity: (TumblrTaggedPhotos?), _ error: Error?)->Void) {
        let sessionManager = TumblrOAuth()
        sessionManager.getSessionManager { (sessionManager) in
            sessionManager.request(APIRouter.fetchImages(tagged: tagged).asURLString()).validate().responseData { response in
                switch response.result {
                case .success:
                    if let jsonData = response.result.value {
                        let jsonDecoder = JSONDecoder()
                        
                        guard let data = try? jsonDecoder.decode(TumblrTaggedPhotos.self, from: jsonData) else { return }
                        completion(data, nil)
                    }
                case .failure(let error):
                    completion(nil, error)
                }
            }
        }
    }
}
