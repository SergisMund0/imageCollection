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
    func updateTableViewFor(tag: String) {
        interactor?.requestImages(by: tag)
    }
    
    func imageCollectionDidSelect(model: ImageCollectionCellModel) {
        guard let view = view else { return }
        
        wireFrame?.navigateToImageCollectionDetailModule(from: view, model: model)
    }
}

extension ImageCollectionPresenter: ImageCollectionInteractorProtocol {
    func fetchImage(response: [ImageCollectionCellModel]?, error: Error?) {
        guard let response = response else {
            guard let view = view else { return }
            // If the error is controlled.
            if let error = error {
                let issuesControlModel = IssuesControlModel(title: "imageCollection", buttonHidden: false, buttonTitle: "Retry", subtitle: error.localizedDescription)
                wireFrame?.presentIssuesControlModule(from: view, model: issuesControlModel)
            } else {
                // Else we put a generic message in the error.
                let issuesControlModel = IssuesControlModel(title: "imageCollection", buttonHidden: false, buttonTitle: "Retry", subtitle: "Something was wrong")
                wireFrame?.presentIssuesControlModule(from: view, model: issuesControlModel)
            }
            return
        }
        view?.viewDidReceiveUpdates(model: response)
    }
}
