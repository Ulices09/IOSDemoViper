//
//  PhotoListPresenter.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation
import UIKit

class PhotoListPresenter: PhotoListPresenterInput {
    
    weak var view: PhotoListVCInput!
    var interactor: PhotoListInteractorInput!
    var router: PhotoListRouterInput!
    
    func fetchPhotos(_ searchTags: String, page: NSInteger) {
        
        if view.getPhotosCount() == 0 {
            view.showLoadingView()
        }
        
        interactor.fetchAllPhotosFromDataManager(searchTags, page: page)
    }
    
    func providePhotos(_ photos: [FlickrPhoto], total: NSInteger) {
        view.hideLoadingView()
        self.view.displayFetchedPhotos(photos, totalPhotos: total)
    }
    
    func serviceError(_ error: NSError) {
        self.view.displayErrorView(errorMessageService)
    }
    
    func navigateToPhotoDetailScreen() {
        self.router.navigateToPhotoDetail()
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        self.router.passDataToNextScene(segue)
    }
}
