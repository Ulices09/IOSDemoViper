//
//  PhotoDetailProtocol.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 16/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

protocol PhotoDetailVCOutput: class {
    func saveSelectedFlickerPhoto(_ flickerPhoto: FlickrPhoto)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}

protocol PhotoDetailVCInput: class {
    func addLargeLadedPhoto(_ largePhoto: UIImage)
    func AddPhotoImageTitle(_ title: String)
}

protocol PhotoDetailPresenterInput: PhotoDetailVCOutput, PhotoDetailInteractorOutput {
    
}

protocol PhotoDetailInteractorOutput: class {
    func sendLoadedPhotoImage(_ image: UIImage)
}

protocol PhotoDetailInteractorInput: class {
    func configureFlickrPhoto(_ flickerPhoto: FlickrPhoto)
    func loadUIImageFromURL()
    func getPhotoImageTitle() -> String
}
