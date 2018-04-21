//
//  ImageCollectionProtocols.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

protocol ImageCollectionViewBehaviorProtocol {
    var presenter: ImageCollectionViewProtocol? { get set }
    
    func viewDidReceiveUpdates(model: [ImageCollectionCellModel])
}

protocol ImageCollectionViewProtocol {
    func updateTableViewFor(tag: String)
}

protocol ImageCollectionInteractorBehaviorProtocol {
    var presenter: ImageCollectionInteractorProtocol? { get set }
    
    func requestImages(by tag: String)
}

protocol ImageCollectionInteractorProtocol {
    func fetchImage(response: [ImageCollectionCellModel])
}

protocol ImageCollectionPresenterBehaviorProtocol {
    var view: ImageCollectionViewBehaviorProtocol? { get set }
    var interactor: ImageCollectionInteractorBehaviorProtocol? { get set }
    var wireFrame: ImageCollectionWireFrameBehaviorProtocol? { get set }
}

protocol ImageCollectionWireFrameBehaviorProtocol {
    
}
