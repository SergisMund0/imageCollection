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
        let navigationController = mainStoryboard.instantiateViewController(withIdentifier: "NavigationController")
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
    /// ImageCollectionDetail view will be pushed. This view is normally presented with details of first request to API.
    ///
    /// - Parameters:
    ///   - view: Context which will be pushed.
    ///   - model: Data model for the context that will be pushed.
    func navigateToImageCollectionDetailModule(from view: ImageCollectionViewBehaviorProtocol, model: ImageCollectionCellModel) {
        guard let imageCollectionDetailViewController = ImageCollectionDetailWireFrame.setupModule(detailModel: model) else { return }
        
        if let sourceViewController = view as? UIViewController {
            sourceViewController.navigationController?.pushViewController(imageCollectionDetailViewController, animated: true)
        }
    }
    
    /// IssuesControl view will be present as modal. This view is normally presented when a error is produced.
    ///
    /// - Parameters:
    ///   - view: Context which will be presented.
    ///   - model: Data model for the context that will be presented.
    func presentIssuesControlModule(from view: ImageCollectionViewBehaviorProtocol, model: IssuesControlModel) {
        guard let issuesControlViewController = IssuesControlWireFrame.setupModule(issuesControlModel: model) as? IssuesControlViewController else { return }
        
        if let sourceViewController = view as? UIViewController {
            sourceViewController.navigationController?.present(issuesControlViewController, animated: true)
        }
    }
}

