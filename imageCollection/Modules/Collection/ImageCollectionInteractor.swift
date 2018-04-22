//
//  ImageCollectionInteractor.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import CoreData

final class ImageCollectionInteractor {
    var presenter: ImageCollectionInteractorProtocol?
    
    let apiClient = APIClient()
    var tumblrModel: TumblrTaggedPhotos?
}

extension ImageCollectionInteractor: ImageCollectionInteractorBehaviorProtocol {
    /// Requests images by tag using the API client for tumblr.
    ///
    /// - Parameter tag: Tag describing the search
    func requestImages(by tag: String) {
        apiClient.fetchImages(tagged: tag) { response, error in
            if error == nil {
                if let elements = response?.response.count {
                    if elements > 0 {
                        self.tumblrModel = response
                        let model = self.parsedDataModel()
                        // There are elements to show.
                        self.presenter?.fetchImage(response: model, error: nil)
                    } else {
                        // The request was correctly executed but there are no elements to show.
                        self.presenter?.fetchImage(response: nil, error: nil)
                    }
                }
            } else {
                // The request was wrong.
                self.presenter?.fetchImage(response: nil, error: error)
            }
        }
    }

    /// When the data is obtained from API client. We have to treat them in a specific way.
    /// To do this we join all tags in once string and avoid the nil values from the data model response of photos.
    /// Then the usefull data is stored in Core Data.
    ///
    /// - Returns: A model readable for the view.
    func parsedDataModel() -> [ImageCollectionCellModel] {
        var mappedModel = [ImageCollectionCellModel]()
        if let tumblrModel = tumblrModel {
            let  fixedPhotos = tumblrModel.response.compactMap({ $0.photos })
            for (photo, response) in zip(fixedPhotos, tumblrModel.response) {
                // Delete old stored values from Core Data.
                CoreDataWrapper.delete(entityName: "TaggedPhoto")
                // Save the useful entities for our UITableView.
                CoreDataWrapper.save(entityName: "TaggedPhoto", value: photo[0].originalSize.url, keyPath: "photoURLString")
                CoreDataWrapper.save(entityName: "TaggedPhoto", value: response.tags.joined(separator: " #"), keyPath: "tag")
                CoreDataWrapper.save(entityName: "TaggedPhoto", value: "Powered by Tumblr", keyPath: "powered")
                CoreDataWrapper.save(entityName: "TaggedPhoto", value: response.blogName, keyPath: "blogName")
                
                mappedModel.append(ImageCollectionCellModel(photoURLString: photo[0].originalSize.url, tag: response.tags.joined(separator: " #"), powered: "Powered by Tumblr", blogName: response.blogName))
            }
        }
        
        return mappedModel
    }
}
