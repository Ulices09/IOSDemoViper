//
//  PhotoListInteractor.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

class PhotoListInteractor: PhotoListInteractorInput {
    
    weak var presenter: PhotoListInteractorOutput!
    var APIDataManager: FlickrPhotoListProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTags: String, page: NSInteger) {
        APIDataManager.fetchFlickerPhotos(searchText: searchTags, page: page) {(error, total, flickerPhotos) in
            if let photos = flickerPhotos {
                self.presenter.providePhotos(photos, total: total)
            } else if let error = error {
                self.presenter.serviceError(error)
            }
        }
    }
}
