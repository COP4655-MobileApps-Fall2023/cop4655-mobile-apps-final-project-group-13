//
//  UserRecipe.swift
//  FP_mobileapps
//
//  Created by Christian on 12/5/23.
//

import Foundation

import ParseSwift


struct Post: ParseObject {
    var objectId: String?
    var createdAt: Date?
    var updatedAt: Date?
    var ACL: ParseACL?
    var originalData: Data?

    
    var title: String?
    var ingredients: String?
    var preparation: String?
    var user: User?
    var imageFile: ParseFile?
}
