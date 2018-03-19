//
//  Data.swift
//
//  Created by Max Bystryk on 07.09.17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public class PictureData: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let isSilhouette = "is_silhouette"
        static let url = "url"
    }
    
    // MARK: Properties
    public var isSilhouette: Int?
    public var url: String?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public required init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        isSilhouette <- map[SerializationKeys.isSilhouette]
        url <- map[SerializationKeys.url]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = isSilhouette { dictionary[SerializationKeys.isSilhouette] = value }
        if let value = url { dictionary[SerializationKeys.url] = value }
        return dictionary
    }
    
}
