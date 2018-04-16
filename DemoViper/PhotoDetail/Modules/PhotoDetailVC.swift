//
//  PhotoDetailVC.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

class PhotoDetailVC: UIViewController, PhotoDetailVCInput {
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var largePhotoImageView: UIImageView!
    
    var presenter: PhotoDetailVCOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoDetailAssembly.sharedInstance.configure(self)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.getPhotoImageTitle()
        self.presenter.loadLargePhotoImage()
    }
    
    //Result from presenter
    func addLargeLadedPhoto(_ largePhoto: UIImage) {
        self.largePhotoImageView.image = largePhoto
    }
    
    func AddPhotoImageTitle(_ title: String) {
        self.photoTitleLabel.text = title
    }

}
