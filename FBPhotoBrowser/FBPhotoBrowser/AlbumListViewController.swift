//
//  AlbumListViewController.swift
//  FBPhotoBrowser
//
//  Created by Max Bystryk on 05.09.17.
//  Copyright © 2017 max.bystryk.dev. All rights reserved.
//

import UIKit

class AlbumListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var albums = [AlbumProperties]()
    var selectedAlbum : AlbumProperties?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.barTintColor = UIColor(red:67/255.0, green:104/255.0, blue:173/255.0, alpha: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        self.title = "Albums List"
        
        self.getUserAlbums()
    }
    
    
    func getUserAlbums() {
        
        PhotoManager.getAlbums(viewController: self) { (result) in
            self.albums = result
            self.activityIndicator.isHidden = true
            self.tableView.reloadData()
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toPhotos") {
            let vc = (segue.destination as! PhotosListViewController)
            vc.album = selectedAlbum
        }
    }
    
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        
        FBManager.logOut()
        performSegue(withIdentifier: "toLogin", sender: self)
    }
    
}

//MARK:====================UITableViewDelegate, UITableViewDataSource====================
extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! AlbumListCell
        
        let album = self.albums[indexPath.row]
        
        cell.albumName.text = album.name
        cell.albumDescription.text = album.description
        
        let userPhotoUrlString = (album.picture?.data?.url)!
        let imageData = userPhotoUrlString.getPhotoFromURL()
        
        cell.albumCover.image = UIImage(data: imageData!)
        cell.albumCover.layer.cornerRadius = 15
        cell.albumCover.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedAlbum = self.albums[indexPath.row]
        performSegue(withIdentifier: "toPhotos", sender: self)
        
    }
    
}


