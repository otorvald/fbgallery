//
//  PhotoManager.swift
//  FBPhotoBrowser
//
//  Created by Maksym Bystryk on 3/14/18.
//  Copyright © 2018 max.bystryk.dev. All rights reserved.
//

import UIKit

class PhotoManager {
    
    static func getAlbums(viewController: UIViewController, completion: @escaping (_ albums: [AlbumProperties]) -> Void) {
        
        FBManager.getAlbums(viewController: viewController) { (result) in
            if let json = result as? NSDictionary {
                
                let albumsList = (AlbumData(JSONString: json.convertToString())?.data)!
                
                print("Albums list received")
                
                completion(albumsList)
            }
        }
        
    }
    
    
    static func getPhotosFromAlbum(viewController: UIViewController, albumId: String, completion: @escaping (_ photos: [Photo]) -> Void) {
        
        FBManager.getPhotosFromAlbum(viewController: viewController, albumId: albumId) { (result) in
            if let json = result as? NSDictionary {
                
                let photos = (PhotoData(JSONString: json.convertToString())?.data)!
                
                completion(photos)
            }
            
        }
    }
    
    
    static func loadPhoto(from url: String, forItemAt indexPath: IndexPath, completion: @escaping (_ image: UIImage?, _ indexPath: IndexPath) -> Void) {
        
        loadPhotoFromUrl(url: url) { (image) in
            
            completion(image, indexPath)
        }
        
    }
    
    static func loadPhotoFromUrl(url: String, completion: @escaping (_ image: UIImage?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            if let data = url.getPhotoFromURL() {
                completion(UIImage(data: data))
            }
        }
    }
    
}


// Convert dictionary to String
extension NSDictionary {
    
    func convertToString() -> String {
        do {
            if (JSONSerialization.isValidJSONObject(self)) {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                
                let theJSONText = String(data: jsonData,
                                         encoding: .utf8)
                return theJSONText!
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return String()
    }
    
}

//Get photo data from URL
extension String {
    
    func getPhotoFromURL() -> Data? {
        do {
            if let url = URL(string: self) {
                return try Data(contentsOf: url)
            }
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}


