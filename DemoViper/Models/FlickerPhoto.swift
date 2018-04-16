//
//  FlickrPhoto.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation

struct FlickrPhoto {
    var id: String
    var farm: Int
    var secret: String
    var server: String
    var title: String
    
    var photoURL: NSURL {
        return flickerPhotoImageURL()
    }
    
    var largePhotoURL: NSURL {
        return flickerPhotoImageURL(size: "b")
    }
    
    private func flickerPhotoImageURL(size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(self.farm).staticflickr.com/\(self.server)/\(self.id)_\(self.secret)_\(size).jpg")!
    }
}
