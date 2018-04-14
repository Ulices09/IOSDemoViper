//
//  PhotoListVC.swift
//  DemoViper
//
//  Created by Ulices Meléndez on 13/04/18.
//  Copyright © 2018 Ulices Meléndez Acosta. All rights reserved.
//

import UIKit

class PhotoListVC: UIViewController, PhotoListVCInput {
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    
    var presenter: PhotoListVCOutput!
    var photos: [FlickrPhoto] = []
    var currentPage = 1
    var totalPhotos = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoListAssembly.sharedInstance.configure(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = photoSearchKey.capitalized
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        performSearchWith(photoSearchKey)
    }

    func performSearchWith(_ searchTags: String) {
        presenter.fetchPhotos(searchTags, page: currentPage)
    }
    
    func displayFetchedPhotos(_ photos: [FlickrPhoto], totalPhotos: NSInteger) {
        
        self.photos.append(contentsOf: photos)
        self.totalPhotos = totalPhotos
        
        DispatchQueue.main.async {
            self.photoCollectionView.reloadData()
            //self.photoCollectionView.reloadSections(IndexSet())
        }
    }
    
    func displayErrorView(_ errorMessage: String) {
        let errorAlert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            errorAlert.dismiss(animated: true, completion: nil)
        })
        errorAlert.addAction(okAction)
        
        present(errorAlert, animated: true, completion: nil)
    }
    
    //MARK:- ActivityView
    func showLoadingView() {
        let alert = UIAlertController(title: nil, message: loadingKey, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 60))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func hideLoadingView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getPhotosCount() -> NSInteger {
        return self.photos.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.passDataToNextScene(segue)
    }

}

// MARK:- UICollectionViewDataSource
extension PhotoListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if currentPage < totalPhotos {
            return photos.count + 1
        }
        
        return photos.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < photos.count {
            return photoItemCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        } else {
            currentPage += 1
            performSearchWith(photoSearchKey)
            return photoLoadingItemCell(collectionView, cellForItemAt: indexPath as NSIndexPath)
        }
    }
    
    func photoItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoItemCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! PhotoItemCell
        
        let flickerPhoto = self.photos[indexPath.row]
        
        //cell.photoImageView.alpha = 0
        cell.photoImageView.sd_setImage(with: flickerPhoto.photoURL as URL) { (image, error, cacheType, url) in
            cell.photoImageView.image = image
//            UIView.animate(withDuration: 0.2, animations: {
//                cell.photoImageView.alpha = 1.0
//            })
        }
        
        return cell
    }
    
    func photoLoadingItemCell(_ collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoLoadingCell.defaultReuseIdentifier, for: indexPath as IndexPath) as! PhotoLoadingCell
        return cell
    }
}

// MARK:- UICollectionViewDelegate
extension PhotoListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.navigateToPhotoDetailScreen()
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension PhotoListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var itemSize: CGSize
        let lenght = UIScreen.main.bounds.width/3 - 1
        
        if indexPath.row < photos.count {
            itemSize = CGSize(width: lenght, height: lenght)
        } else {
            itemSize = CGSize(width: photoCollectionView.bounds.width, height: 50.0)
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.5
    }
    
}
































