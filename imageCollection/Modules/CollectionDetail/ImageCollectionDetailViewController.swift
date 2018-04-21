//
//  ImageCollectionDetailViewController.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

final class ImageCollectionDetailViewController: UIViewController {
    var presenter: ImageCollectionDetailViewProtocol?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak fileprivate var titleLabelView: UILabel!
    @IBOutlet weak fileprivate var imageView: UIImageView!
    @IBOutlet weak var subtitleLabelView: UILabel!
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.updateView()
    }
}

extension ImageCollectionDetailViewController: ImageCollectionDetailViewBehaviorProtocol {
    func viewDidReceiveUpdates(model: ImageCollectionCellModel) {
        // Setup de title with the blog name of the selected cell.
        titleLabelView.text = model.blogName
        // Setup the subtitle view with tags of selected cell.
        subtitleLabelView.text = model.tag
    
        // Setup image content with the image of selected cell.
        if let url = URL(string: model.photoURLString) {
            // The image was stored in the cache so this method does not consume any service.
            imageView.af_setImage(withURL: url)
        }
    }
    
}
