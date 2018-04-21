//
//  ImageCollectionDetailWireFrame.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

final class ImageCollectionDetailWireFrame: ImageCollectionDetailWireFrameBehaviorProtocol {
    static func setupModule(detailModel: ImageCollectionCellModel) -> UIViewController? {
        guard let view = mainStoryboard.instantiateViewController(withIdentifier: "ImageCollectionDetailViewController") as? ImageCollectionDetailViewController else { return nil }
        
        var presenter: ImageCollectionDetailPresenterBehaviorProtocol & ImageCollectionDetailViewProtocol & ImageCollectionDetailInteractorProtocol = ImageCollectionDetailPresenter()
        var interactor: ImageCollectionDetailInteractorBehaviorProtocol = ImageCollectionDetailInteractor()
        let wireFrame: ImageCollectionDetailWireFrameBehaviorProtocol = ImageCollectionDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.imageCollectionDetailModel = detailModel
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
