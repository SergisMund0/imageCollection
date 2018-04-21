//
//  IssuesControlPresenter.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

final class IssuesControlPresenter: IssuesControlPresenterBehaviorProtocol {
    var view: IssuesControlViewBehaviorProtocol?
    var wireFrame: IssuesControlWireFrameBehaviorProtocol?
    
    var issuesControlModel: IssuesControlModel?
    // This action block may contains actions to do when retry button is tapped.
    var actionBlock: (() -> Void)?
}

extension IssuesControlPresenter: IssuesControlViewProtocol {
    func updateView() {
        guard let issuesControlModel = issuesControlModel else { return }
        
        view?.viewDidReceiveUpdates(model: issuesControlModel)
    }
    
    func controlButtonDidTap() {
        view?.dismissViewController(actionBlock: actionBlock)
    }
}
