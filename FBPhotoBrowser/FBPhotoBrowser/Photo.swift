//
//  Data.swift
//
//  Created by Max Bystryk on 07.09.17
//  Copyright (c) . All rights reserved.
//

import ObjectMapper

public class Photo: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let picture = "picture"
        static let source = "source"
    }
    
    // MARK: Properties
    public var id: String?
    public var picture: String?
    public var source: String?
    public var image: UIImage?
    
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
        id <- map[SerializationKeys.id]
        picture <- map[SerializationKeys.picture]
        source <- map[SerializationKeys.source]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = picture { dictionary[SerializationKeys.picture] = value }
        if let value = source { dictionary[SerializationKeys.source] = value }
        return dictionary
    }
    
}
