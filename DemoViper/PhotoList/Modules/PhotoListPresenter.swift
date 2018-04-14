//
//  PhotoListPresenter.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

class PhotoListPresenter: PhotoListPresenterInput {
    
    weak var view: PhotoListVCInput!
    var interactor: PhotoListInteractorInput!
    
    func fetchPhotos(_ searchTags: String, page: NSInteger) {
        interactor.fetchAllPhotosFromDataManager(searchTags, page: page)
    }
    
    func providePhotos(_ photos: [FlickrPhoto], total: NSInteger) {
        self.view.displayFetchedPhotos(photos, totalPhotos: total)
    }
    
    func serviceError(_ error: NSError) {
        self.view.displayErrorView(errorMessageService)
    }
}
