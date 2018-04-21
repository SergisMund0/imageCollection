//
//  ImageCollectionInteractor.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

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
                self.tumblrModel = response
                let model = self.parsedDataModel()
                self.presenter?.fetchImage(response: model)
            }
        }
    }

    /// When the data is obtained from API client. We have to treat them in a specific way.
    /// To do this we join all tags in once string and avoid the nil values from the data model response of photos.
    ///
    /// - Returns: A model readable for the view.
    func parsedDataModel() -> ImageCollectionCellModel {
        var mappedModel = ImageCollectionCellModel(photoURLString: [String](), tag: [String](), dateString: [String]())
        if let tumblrModel = tumblrModel {
            let  fixedPhotos = tumblrModel.response.compactMap({ $0.photos })
            for photo in fixedPhotos {
                mappedModel.photoURLString.append(photo[0].originalSize.url)
            }
            for currentPhoto in tumblrModel.response {
                mappedModel.tag.append(currentPhoto.tags.joined(separator: " "))
            }
        }
        return mappedModel
    }
}
