////
////  PhotosListViewController.swift
////  FBPhotoBrowser
////
////  Created by Max Bystryk on 05.09.17.
////  Copyright © 2017 max.bystryk.dev. All rights reserved.
////
//
import UIKit

class PhotosListViewController: UICollectionViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var selectedPictureIndex = 0
    var album : AlbumProperties?
    var photos = [Photo]()
    
    //MARK:====================UICollectionViewLayoutOptions====================
    let insetTop : CGFloat = 1.0
    let insetBottom : CGFloat = 1.0
    let insetLeft : CGFloat = 1.0
    let insetRight : CGFloat = 1.0
    let spacing : CGFloat = 1.0
    
    var columnCount : CGFloat = 3
    
    
    //MARK:====================METHODS====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        if self.album != nil {
            self.getPhotosFromAlbum(albumId: (self.album?.id!)!)
        }
        
        self.title = self.album?.name!
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        self.collectionView?.collectionViewLayout.invalidateLayout()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toPhoto") {
            let vc = (segue.destination as! PhotoViewerViewController)
            vc.pictureIndex = self.selectedPictureIndex
            vc.photos = self.photos
        }
    }
    
    func getPhotosFromAlbum(albumId: String) {
        
        PhotoManager.getPhotosFromAlbum(viewController: self, albumId: albumId) { (photos) in
            
            self.photos = photos
            
            self.collectionView?.reloadData()
            self.activityIndicator.isHidden = true
        }
    }
    
    @IBAction func backBarButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}


//MARK:====================UICollectionViewDataSource, UICollectionViewDelegate====================
extension PhotosListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoCell
        
        if (self.photos[indexPath.item].image == nil) {
            
            cell.imageView.image = #imageLiteral(resourceName: "empty")
            
            PhotoManager.loadPhoto(from: self.photos[indexPath.item].source!, forItemAt: indexPath) { (image, pathIndex) in
                
                self.photos[pathIndex.item].image = image
                
                DispatchQueue.main.async {
                        collectionView.reloadItems(at: [pathIndex])
                }
            }
        }
        else {
            UIView.animate(withDuration: 0.35, delay: 0, options: .transitionCrossDissolve, animations: {
                cell.imageView.image = self.photos[indexPath.item].image
            }, completion: nil)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.selectedPictureIndex = indexPath.item
        
        performSegue(withIdentifier: "toPhoto", sender: self)
        
    }
}

//MARK:====================UICollectionViewDelegateFlowLayout====================
extension PhotosListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width - insetRight - insetLeft - spacing * (columnCount - 1)) / columnCount
        let height = width
        
        let size = CGSize(width: width, height: height)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: insetTop, left: insetLeft, bottom: insetBottom, right: insetRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
}

