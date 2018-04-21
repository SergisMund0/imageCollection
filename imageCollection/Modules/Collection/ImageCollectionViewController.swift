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
    fileprivate var imageCollectionCellModel: [ImageCollectionCellModel]?
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    fileprivate var filteredPhotos = [ImageCollectionCellModel]()
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        presenter?.updateTableViewFor(tag: "thelordoftherings")
    }
    
    /// Setups the UISearchBar within UINavigationItem in current view controller.
    private func setupSearchBar() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Search images by tag"
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
}

// MARK: - ImageCollectionViewBehaviorProtocol
extension ImageCollectionViewController: ImageCollectionViewBehaviorProtocol {
    /// Presenter has updates to be loaded.
    ///
    /// - Parameter model: A model to populate the current table view.
    func viewDidReceiveUpdates(model: [ImageCollectionCellModel]) {
        imageCollectionCellModel = model
        tableView.reloadData()
    }
}

// MARK: - UISearchController
extension ImageCollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text)
    }
    
    private func filterContentForSearchText(_ searchText: String?) {
        guard let imageCollectionCellModel = imageCollectionCellModel, let searchText = searchText else { return }
        
        filteredPhotos = imageCollectionCellModel.filter({ (imageCollectionCellModel: ImageCollectionCellModel ) -> Bool in
            return imageCollectionCellModel.tag.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    private func searchBarIsEmpty() -> Bool {
        // Returns true if there are no content in the search bar
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    fileprivate func searchBarIsFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

// MARK: - UISearchBarDelegate
extension ImageCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard var searchText = searchBar.text else { return }
        searchText = parse(searchText: searchText)
        // Hides the keyboard.
        searchBar.resignFirstResponder()
        // Reset the search bar input text
        searchBar.text = nil
        // Request a new search by tag to the Tumblr API.
        presenter?.updateTableViewFor(tag: searchText)
    }
    
    /// Concatenates the strings before doing the request.
    ///
    /// - Parameter searchText: The text input from user interface.
    /// - Returns: String readable for the API request.
    private func parse(searchText: String) -> String {
        return searchText.replacingOccurrences(of: " ", with: "")
    }
}

// MARK: - UITableViewDataSource
extension ImageCollectionViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchBarIsFiltering() {
            return filteredPhotos.count
        }
        
        return imageCollectionCellModel?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCollectionCell", for: indexPath) as? ImageCollectionCell else { return UITableViewCell() }
        
        // If user is writing the search bar, the content will be filtered else the content shows
        // the total list of items requested to the service previously.
        var imageCollectionCellModelTreated = imageCollectionCellModel
        if searchBarIsFiltering() {
            imageCollectionCellModelTreated = filteredPhotos
        }
        
        // Setup ImageCollectionCell with data received from the presenter.
        if let urlString = imageCollectionCellModelTreated?[indexPath.row].photoURLString {
            if let url = URL(string: urlString) {
                // Create an animation for current cell while service layer is downloading the image.
                cell.imageActivityIndicatorView.startAnimating()
                cell.avatarImageView.af_setImage(withURL: url) { response in
                    cell.imageActivityIndicatorView.stopAnimating()
                }
                cell.tagLabelView.text = imageCollectionCellModelTreated?[indexPath.row].tag
                cell.dateLabelView.text = imageCollectionCellModelTreated?[indexPath.row].dateString
            }
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension ImageCollectionViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchBarIsFiltering() {
            presenter?.imageCollectionDidSelect(model: filteredPhotos[indexPath.row])
        } else {
            guard let imageCollectionCellModel = imageCollectionCellModel else { return }
            presenter?.imageCollectionDidSelect(model: imageCollectionCellModel[indexPath.row])
        }
    }
}
