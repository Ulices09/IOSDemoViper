//
//  PhotoListRouter.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

class PhotoListRouter: PhotoListRouterInput {

    weak var viewController: PhotoListVC!
    
    //MARK:- Navigation
    func navigateToPhotoDetail() {
        viewController.performSegue(withIdentifier: "ShowPhotoDetailVC", sender: nil)
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        if segue.identifier == "ShowPhotoDetailVC" {
            passDataToPhotoDetailVC(segue)
        }
    }
    
    func passDataToPhotoDetailVC(_ segue: UIStoryboardSegue) {
        if let selectedIndexPath = viewController.photoCollectionView.indexPathsForSelectedItems?.first {
            let flickerPhoto = viewController.photos[selectedIndexPath.row]
            let destination = segue.destination as! PhotoDetailVC
            destination.presenter.saveSelectedFlickerPhoto(flickerPhoto)
            
        }
    }
    
}

