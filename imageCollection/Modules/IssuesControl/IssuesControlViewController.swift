//
//  IssuesControlViewController.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

final class IssuesControlViewController: UIViewController {
    var presenter: IssuesControlViewProtocol?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var titleLabelView: UILabel!
    @IBOutlet weak var controlButtonView: UIButton!
    @IBOutlet weak var controlButtonTitleLabelView: UILabel!
    @IBOutlet weak var controlButtonSubtitleLabelView: UILabel!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.updateView()
    }
    
    @IBAction func controlButtonDidTap(_ sender: Any) {
        presenter?.controlButtonDidTap()
    }
}

extension IssuesControlViewController: IssuesControlViewBehaviorProtocol {
    func viewDidReceiveUpdates(model: IssuesControlModel) {
        titleLabelView.text = model.title
        controlButtonView.isHidden = model.buttonHidden
        controlButtonTitleLabelView.text = model.buttonTitle
        controlButtonSubtitleLabelView.text = model.subtitle
    }
    
    /// The view is dismissed. May take actions if actionBlock is provided.
    ///
    /// - Parameter actionBlock: An action block to execute when view disappear.
    func dismissViewController(actionBlock: (() -> Void)?) {
        dismiss(animated: true) {
            actionBlock?()
        }
    }
}
