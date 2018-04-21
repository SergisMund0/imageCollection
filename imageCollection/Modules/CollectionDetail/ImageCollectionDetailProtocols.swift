//
//  ImageCollectionDetailProtocols.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCollectionDetailViewBehaviorProtocol {
    var presenter: ImageCollectionDetailViewProtocol? { get set }
    
    func viewDidReceiveUpdates(model: ImageCollectionCellModel)
}

protocol ImageCollectionDetailViewProtocol {
    func updateView()
}

protocol ImageCollectionDetailInteractorBehaviorProtocol {
    var presenter: ImageCollectionDetailInteractorProtocol? { get set }
    
    //func requestImages(by tag: String)
}

protocol ImageCollectionDetailInteractorProtocol {
    //func fetchImage(response: [ImageCollectionCellModel])
}

protocol ImageCollectionDetailPresenterBehaviorProtocol {
    var view: ImageCollectionDetailViewBehaviorProtocol? { get set }
    var interactor: ImageCollectionDetailInteractorBehaviorProtocol? { get set }
    var wireFrame: ImageCollectionDetailWireFrameBehaviorProtocol? { get set }
    var imageCollectionDetailModel: ImageCollectionCellModel? { get set }
}

protocol ImageCollectionDetailWireFrameBehaviorProtocol {
    static func setupModule(detailModel: ImageCollectionCellModel) -> UIViewController?
}
