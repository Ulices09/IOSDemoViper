//
//  PhotoDetailInteractor.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

class PhotoDetailInteractor: PhotoDetailInteractorInput {
    
    weak var presenter: PhotoDetailInteractorOutput!
    var flickerPhoto: FlickrPhoto?
    var flickerImageDataManager: FlickrPhotoLoadImageProtocol!
    
    func configureFlickrPhoto(_ flickerPhoto: FlickrPhoto) {
        self.flickerPhoto = flickerPhoto
    }
    
    func loadUIImageFromURL() {
        flickerImageDataManager.loadImageFromURL((self.flickerPhoto?.largePhotoURL)!) { (image, error) in
            if let image = image {
                self.presenter.sendLoadedPhotoImage(image)
            }
        }
    }
    
    func getPhotoImageTitle() -> String {
        if let title = self.flickerPhoto?.title {
            return title
        }
        
        return ""
    }
    
}
