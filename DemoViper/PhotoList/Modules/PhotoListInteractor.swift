//
//  PhotoListInteractor.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

protocol PhotoListInteractorInput: class {
    func fetchAllPhotosFromDataManager(_ searchTags: String, page: NSInteger)
}

class PhotoListInteractor: PhotoListInteractorInput {
    
    var APIDataManager: FlickrPhotoListProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTags: String, page: NSInteger) {
        APIDataManager.fetchFlickerPhotos(searchText: searchTags, page: page) {(error, total, flickerPhotos) in
            if let photos = flickerPhotos {
                print(photos)
            } else if let error = error {
                print(error)
            }
        }
    }
}
