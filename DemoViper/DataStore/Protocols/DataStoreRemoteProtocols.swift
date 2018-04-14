//
//  DataStoreRemoteProtocols.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 14/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation
import SDWebImage


protocol FlickrPhotoListProtocol: class {
    func fetchFlickerPhotos(searchText: String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhoto]?) -> Void) -> Void
    func loadImageFromURL(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void)
}
