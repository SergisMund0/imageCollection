//
//  ImageCollectionProtocols.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCollectionViewBehaviorProtocol {
    var presenter: ImageCollectionViewProtocol? { get set }
    
    func viewDidReceiveUpdates(model: [ImageCollectionCellModel])
}

protocol ImageCollectionViewProtocol {
    func updateTableViewFor(tag: String)
    func imageCollectionDidSelect(model: ImageCollectionCellModel)
}

protocol ImageCollectionInteractorBehaviorProtocol {
    var presenter: ImageCollectionInteractorProtocol? { get set }
    
    func requestImages(by tag: String)
}

protocol ImageCollectionInteractorProtocol {
    func fetchImage(response: [ImageCollectionCellModel]?, error: Error?)
}

protocol ImageCollectionPresenterBehaviorProtocol {
    var view: ImageCollectionViewBehaviorProtocol? { get set }
    var interactor: ImageCollectionInteractorBehaviorProtocol? { get set }
    var wireFrame: ImageCollectionWireFrameBehaviorProtocol? { get set }
}

protocol ImageCollectionWireFrameBehaviorProtocol {
    static func setupModule() -> UIViewController?
    func navigateToImageCollectionDetailModule(from view: ImageCollectionViewBehaviorProtocol, model: ImageCollectionCellModel)
    func presentIssuesControlModule(from view: ImageCollectionViewBehaviorProtocol, model: IssuesControlModel) 
}
