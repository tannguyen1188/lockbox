//
//  ViewModel.swift
//  LockBox701
//
//  Created by mac on 7/31/19.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation

let viewModel = ViewModel.shared
class ViewModel {
   
    
    static let shared = ViewModel()
    private init () {}
    
   let coreManager = CoreManager()
    
        var content = [Content]() {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("Save"), object: nil)
        }
    }
    
    func loadImage() {
        content = coreManager.load()
    }
    var currentPath: Content!
    
}
