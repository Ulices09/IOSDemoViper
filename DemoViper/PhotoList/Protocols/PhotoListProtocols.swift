//
//  PhotoListProtocols.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 14/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

protocol PhotoListVCOutput: class {
    func fetchPhotos(_ searchTags: String, page: NSInteger)
}

protocol PhotoListVCInput: class {
    func displayFetchedPhotos(_ photos: [FlickrPhoto], totalPhotos: NSInteger)
    func displayErrorView(_ errorMessage: String)
}

protocol PhotoListPresenterInput: PhotoListVCOutput, PhotoListInteractorOutput {
    
}

protocol PhotoListInteractorInput: class {
    func fetchAllPhotosFromDataManager(_ searchTags: String, page: NSInteger)
}

protocol PhotoListInteractorOutput: class {
    func providePhotos(_ photos: [FlickrPhoto], total: NSInteger)
    func serviceError(_ error: NSError)
}
