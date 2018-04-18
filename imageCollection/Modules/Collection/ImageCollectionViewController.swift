//
//  ImageCollectionViewController.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit

final class ImageCollectionViewController: UICollectionViewController {
    var presenter: ImageCollectionViewProtocol?
}

extension ImageCollectionViewController: ImageCollectionViewBehaviorProtocol {
}
