//
//  PhotoDetailAssembly.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 15/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailVC) {
        let ImageDataManager: FlickrPhotoLoadImageProtocol = FlickrPhotoDataManager()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        
        viewController.presenter = presenter
        
        presenter.view = viewController
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.flickerImageDataManager = ImageDataManager
    }
}
