//
//  PhotoListPresenter.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

protocol PhotoListPresenterInput: PhotoListVCOutput {
    
}

class PhotoListPresenter: PhotoListPresenterInput {
    
    var interactor: PhotoListInteractorInput!
    
    func fetchPhotos(_ searchTags: String, page: NSInteger) {
        interactor.fetchAllPhotosFromDataManager(searchTags, page: page)
    }
}
