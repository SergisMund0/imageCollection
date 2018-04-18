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
}

extension ImageCollectionInteractor: ImageCollectionInteractorBehaviorProtocol {
}
