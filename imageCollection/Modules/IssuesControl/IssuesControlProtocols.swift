//
//  IssuesControlProtocols.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

protocol IssuesControlViewBehaviorProtocol {
    var presenter: IssuesControlViewProtocol? { get set }
    
    func viewDidReceiveUpdates(model: IssuesControlModel)
    func dismissViewController(actionBlock: (() -> Void)?)
}

protocol IssuesControlViewProtocol {
    func updateView()
    func controlButtonDidTap()
}

protocol IssuesControlPresenterBehaviorProtocol {
    var view: IssuesControlViewBehaviorProtocol? { get set }
    var wireFrame: IssuesControlWireFrameBehaviorProtocol? { get set }
    var issuesControlModel: IssuesControlModel? { get set }
}

protocol IssuesControlWireFrameBehaviorProtocol {
    static func setupModule(issuesControlModel: IssuesControlModel) -> UIViewController?
}
