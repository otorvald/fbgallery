//
//  PhotoViewerViewController.swift
//  FBPhotoBrowser
//
//  Created by Max Bystryk on 05.09.17.
//  Copyright © 2017 max.bystryk.dev. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class PhotoViewerViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var photoView: UIImageView!
    
    var pictureIndex = 0
    var photos = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        let swipeGestureRecognizerRight = UISwipeGestureRecognizer(target: self, action: #selector(showPreviousImage))
        swipeGestureRecognizerRight.direction = .right
        swipeGestureRecognizerRight.delegate = self
        self.view.addGestureRecognizer(swipeGestureRecognizerRight)
        
        let swipeGestureRecognizerLeft = UISwipeGestureRecognizer(target: self, action: #selector(showNextImage))
        swipeGestureRecognizerLeft.direction = .left
        swipeGestureRecognizerLeft.delegate = self
        self.view.addGestureRecognizer(swipeGestureRecognizerLeft)
    
        self.title = "Photo Viewer"
        
        photoView.image = self.photos[pictureIndex].image
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation == .portrait {
            self.navigationController?.isNavigationBarHidden = false
        }
        else {
            self.navigationController?.isNavigationBarHidden = true
        }
    }
    
    @objc func showPreviousImage() {
        if pictureIndex > 0 {
            self.pictureIndex -= 1
            self.photoView.transitionAnimation(trancitionSubtype: kCATransitionFromLeft)
            self.photoView.image = self.photos[self.pictureIndex].image
        }
    }
    
    @objc func showNextImage() {
        if pictureIndex < self.photos.count-1 {
            self.pictureIndex += 1
            self.photoView.transitionAnimation(trancitionSubtype: kCATransitionFromRight)
            if self.photos[self.pictureIndex].image == nil {
                PhotoManager.loadPhotoFromUrl(url: self.photos[self.pictureIndex].source!, completion: { (image) in
                    DispatchQueue.main.async {
                        self.photos[self.pictureIndex].image = image
                        self.photoView.image = self.photos[self.pictureIndex].image
                    }
                })
            }
            else {
                self.photoView.image = self.photos[self.pictureIndex].image
            }
        }
    }
    

    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIView {
    func transitionAnimation(duration: TimeInterval = 0.5, completionDelegate: AnyObject? = nil, trancitionSubtype: String) {
        // Create a CATransition object
        let transition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided
        if let delegate: CAAnimationDelegate = completionDelegate as? CAAnimationDelegate {
            transition.delegate = delegate
        }
        
        transition.type = kCATransitionPush
        transition.subtype = trancitionSubtype
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.fillMode = kCAFillModeRemoved
        
        // Add the animation to the View's layer
        self.layer.add(transition, forKey: "transition")
    }
}
