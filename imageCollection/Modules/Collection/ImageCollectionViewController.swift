//
//  ImageCollectionViewController.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 19/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage

final class ImageCollectionViewController: UITableViewController {
    var presenter: ImageCollectionViewProtocol?
    fileprivate var imageCollectionCellModel: ImageCollectionCellModel?
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        presenter?.updateTableView(initialTag: "thelordoftherings")
    }
    
    /// Setups the UISearchBar within UINavigationItem in current view controller.
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search images by tag"
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
    }
}

// MARK: - ImageCollectionViewBehaviorProtocol
extension ImageCollectionViewController: ImageCollectionViewBehaviorProtocol {
    /// Presenter has updates to be loaded.
    ///
    /// - Parameter model: A model to populate the current table view.
    func viewDidReceiveUpdates(model: ImageCollectionCellModel) {
        imageCollectionCellModel = model
        tableView.reloadData()
    }
}

// MARK: - UISearchBar
extension ImageCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// MARK: - UITableView
extension ImageCollectionViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageCollectionCellModel?.photoURLString.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCollectionCell", for: indexPath) as? ImageCollectionCell else { return UITableViewCell() }
        // Setup ImageCollectionCell with data received from the presenter.
        if let urlString = imageCollectionCellModel?.photoURLString[indexPath.row] {
            if let url = URL(string: urlString) {
                // Create an animation for current cell while service layer is downloading the image.
                cell.imageActivityIndicatorView.startAnimating()
                cell.avatarImageView.af_setImage(withURL: url) { response in
                    cell.imageActivityIndicatorView.stopAnimating()
                }
                cell.tagLabelView.text = imageCollectionCellModel?.tag[indexPath.row]
            }
        }
        return cell
    }
}
