//
//  DetailViewController.swift
//  LockBox701
//
//  Created by Consultant on 8/1/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDetail()
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        
        
        
        let alert = UIAlertController(title: "Are you sure?", message: "The photo will be deleted from your device", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { [unowned self] _ in
            viewModel.coreManager.remove(content: viewModel.currentPath)
            self.goToMedia()
        }
        
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        
        alert.addAction(yesAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
        
    
    
    
    private func setupDetail() {
        
        guard let content = viewModel.currentPath else {return}
        
        guard let url = FileService().load(from: content.path!) else { return }
        
        detailView.image = UIImage(contentsOfFile: url.path)
    }

}
    

