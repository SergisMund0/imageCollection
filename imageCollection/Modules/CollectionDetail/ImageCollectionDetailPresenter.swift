//
//  ImageCollectionDetailPresenter.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

final class ImageCollectionDetailPresenter {
    var view: ImageCollectionDetailViewBehaviorProtocol?
    var interactor: ImageCollectionDetailInteractorBehaviorProtocol?
    var wireFrame: ImageCollectionDetailWireFrameBehaviorProtocol?
    
    var imageCollectionDetailModel: ImageCollectionCellModel?
}

extension ImageCollectionDetailPresenter: ImageCollectionDetailPresenterBehaviorProtocol {
    
}

extension ImageCollectionDetailPresenter: ImageCollectionDetailViewProtocol {
    func updateView() {
        guard let imageCollectionDetailModel = imageCollectionDetailModel else { return }
        
        view?.viewDidReceiveUpdates(model: imageCollectionDetailModel)
    }
}

extension ImageCollectionDetailPresenter: ImageCollectionDetailInteractorProtocol {
    
}
