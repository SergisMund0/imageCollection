//
//  ImageCollectionWireFrame.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

final class ImageCollectionWireframe {
    static func setupModule() -> UIViewController? {
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "ImageCollectionViewController")
        guard let view = navigationController.childViewControllers.first as? ImageCollectionViewController else { return nil }
        
        var presenter: ImageCollectionPresenterBehaviorProtocol & ImageCollectionViewProtocol & ImageCollectionInteractorProtocol = ImageCollectionPresenter()
        var interactor: ImageCollectionInteractorBehaviorProtocol = ImageCollectionInteractor()
        let wireFrame: ImageCollectionWireFrameBehaviorProtocol = ImageCollectionWireframe()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        
        return navigationController
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

extension ImageCollectionWireframe: ImageCollectionWireFrameBehaviorProtocol {
    
}

