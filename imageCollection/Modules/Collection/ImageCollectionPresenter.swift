//
//  ImageCollectionPresenter.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

final class ImageCollectionPresenter: ImageCollectionPresenterBehaviorProtocol {
    var view: ImageCollectionViewBehaviorProtocol?
    var interactor: ImageCollectionInteractorBehaviorProtocol?
    var wireFrame: ImageCollectionWireFrameBehaviorProtocol?
}

extension ImageCollectionPresenter: ImageCollectionViewProtocol {
    func updateTableView(initialTag: String) {
        interactor?.requestImages(by: initialTag)
    }
}

extension ImageCollectionPresenter: ImageCollectionInteractorProtocol {
    func fetchImage(response: [ImageCollectionCellModel]) {
        view?.viewDidReceiveUpdates(model: response)
    }
}
