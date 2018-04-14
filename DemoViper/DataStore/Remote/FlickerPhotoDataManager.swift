//
//  FlickerPhotoDataManager.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import Foundation
import SDWebImage

class FlickrPhotoDataManager: FlickrPhotoListProtocol, FlickrPhotoLoadImageProtocol {
    
    static let sharedInstance = FlickrPhotoDataManager()
    
    struct Errors {
        static let invalidAccessErrorCode = 100
    }
    
    struct FlickerAPI {
        static let APIKey = "4e6b2af1e6ac8b70e5ed4e5087d6928a"
        static let tagsSearchFormat = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=20&page=%i&format=json&nojsoncallback=1"
    }
    
    struct FlickerAPIMetaDataKeys {
        static let failureStatusCode = "code"
    }
    
    func fetchFlickerPhotos(searchText: String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhoto]?) -> Void) -> Void {
        let scapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let format = FlickerAPI.tagsSearchFormat
        let arguments: [CVarArg] = [
            FlickerAPI.APIKey,
            scapedSearchText!,
            page
        ]
        
        let photosURL = String(format: format, arguments: arguments)
        let url = NSURL(string: photosURL)
        
        let request = URLRequest(url: url! as URL)
        
        let searchTask = URLSession.shared.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print("Error on fetching photos -> \(error)")
                closure(error as NSError?, 0, nil)
            }
            
            do {
                
                let resultDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                guard let result = resultDictionary else { return }
                
                if let statusCode = result[FlickerAPIMetaDataKeys.failureStatusCode] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "FlickerAPIDomain", code: statusCode, userInfo: nil)
                        closure(invalidAccessError, 0, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultDictionary!["photos"] as? NSDictionary else { return }
                guard let totalPageCountString = photosContainer["total"] as? String else { return }
                guard let totalPageCount = NSInteger(totalPageCountString as String) else { return }
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                let flickerPhotos: [FlickrPhoto] = photosArray.map({(photoDictionary) -> FlickrPhoto in
                    
                    let id = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickerPhoto = FlickrPhoto(id: id, farm: farm, secret: secret, server: server, title: title)
                    
                    return flickerPhoto
                })
                
                closure(nil, totalPageCount, flickerPhotos)
                
                
            } catch let error as NSError {
                print("Error on parsing JSON -> \(error)")
                closure(error, 0, nil)
            }
        }
        searchTask.resume()
    }
    
    // Memory Cache Photo Services
    func loadImageFromURL(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void) {
        SDWebImageManager.shared().imageDownloader?.downloadImage(with: url as URL, options: .useNSURLCache, progress: nil) { (image, data, error, finished) in
            if(image != nil && finished) {
                closure(image, error! as NSError)
            }
        }
    }
    
}



























