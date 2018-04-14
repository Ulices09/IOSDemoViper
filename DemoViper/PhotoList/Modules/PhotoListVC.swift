//
//  PhotoListVC.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

protocol PhotoListVCOutput {
    func fetchPhotos(_ searchTags: String, page: NSInteger)
}

class PhotoListVC: UIViewController {
    
    var presenter: PhotoListVCOutput!
    var photos: [FlickrPhoto] = []
    var currentPage = 1
    var totalPhotos = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoListAssembly.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        performSearchWith(photoSearchKey)
    }

    func performSearchWith(_ searchTags: String) {
        presenter.fetchPhotos(searchTags, page: currentPage)
    }

}
