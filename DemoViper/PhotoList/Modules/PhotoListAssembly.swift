//
//  PhotoListAssembly.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

class PhotoListAssembly {
    
    static let sharedInstance = PhotoListAssembly()
    
    func configure(_ viewController: PhotoListVC) {
        let APIDataManager = FlickrPhotoDataManager()
        let interactor = PhotoListInteractor()
        let presenter = PhotoListPresenter()
        let router = PhotoListRouter()
        
        viewController.presenter = presenter
        
        router.viewController = viewController
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        
        
    }
}
