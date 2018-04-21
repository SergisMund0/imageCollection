//
//  IssuesControlModel.swift
//  imageCollection
//
//  Created by Sergio Garre Ramon on 21/04/2018.
//  Copyright © 2018 IndividualUser. All rights reserved.
//

import Foundation

/// Defines the content of IssuesControl UI.
/// The button will be enabled if there are some error produced.
struct IssuesControlModel {
    let title: String
    let buttonHidden: Bool
    let buttonTitle: String?
    let subtitle: String?
}
