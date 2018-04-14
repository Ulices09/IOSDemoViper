//
//  PhotoListProtocols.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 14/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

protocol PhotoListRouterInput: class {
    func navigateToPhotoDetail()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}

protocol PhotoListVCOutput: class {
    func fetchPhotos(_ searchTags: String, page: NSInteger)
    func navigateToPhotoDetailScreen()
    func passDataToNextScene(_ segue: UIStoryboardSegue)
}

protocol PhotoListVCInput: class {
    func displayFetchedPhotos(_ photos: [FlickrPhoto], totalPhotos: NSInteger)
    func displayErrorView(_ errorMessage: String)
    func showLoadingView()
    func hideLoadingView()
    func getPhotosCount() -> NSInteger
    
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
