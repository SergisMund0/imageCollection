//
//  IssuesControlWireFrame.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

final class IssuesControlWireFrame: IssuesControlWireFrameBehaviorProtocol {
    static func setupModule(issuesControlModel: IssuesControlModel) -> UIViewController? {
        guard let view = mainStoryboard.instantiateViewController(withIdentifier: "IssuesControlViewController") as? IssuesControlViewController else { return nil }
        
        var presenter: IssuesControlPresenterBehaviorProtocol & IssuesControlViewProtocol = IssuesControlPresenter()
        let wireFrame: IssuesControlWireFrameBehaviorProtocol = IssuesControlWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.issuesControlModel = issuesControlModel
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
