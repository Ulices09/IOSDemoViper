//
//  PhotoDetailPresenter.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

class PhotoDetailPresenter: PhotoDetailPresenterInput {
    
    weak var view: PhotoDetailVCInput!
    var interactor: PhotoDetailInteractorInput!
    
    // Passing data from PhotoList Router
    func saveSelectedFlickerPhoto(_ flickerPhoto: FlickrPhoto) {
        self.interactor.configureFlickrPhoto(flickerPhoto)
    }
    
    func loadLargePhotoImage() {
        interactor.loadUIImageFromURL()
    }
    
    func getPhotoImageTitle() {
        let imageTitle = self.interactor.getPhotoImageTitle()
        self.view.AddPhotoImageTitle(imageTitle)
    }
    
    // Result from Interactor
    func sendLoadedPhotoImage(_ image: UIImage) {
        self.view.addLargeLadedPhoto(image)
    }
    
    
    
}
