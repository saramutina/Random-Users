//
//  User.swift
//  Random Users
//
//  Created by Katie Saramutina on 13.06.2022.
//

import Foundation

struct Response: Decodable {
    let users: [User]
    
    enum CodingKeys: String, CodingKey {
        case users = "results"
    }
}

struct User: Decodable, Identifiable {
    let id: String
    let name: Name
    let picture: Picture
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(Name.self, forKey: .name)
        picture = try values.decode(Picture.self, forKey: .picture)
        let loginInfo = try values.nestedContainer(keyedBy: LoginInfoCodingKeys.self, forKey: .login)
        id = try loginInfo.decode(String.self, forKey: .uuid)
    }
    
    enum CodingKeys: String, CodingKey {
        case login
        case name
        case picture
    }
    enum LoginInfoCodingKeys: String, CodingKey {
        case uuid
    }
    
    var fullName: String {
        if name.title == "Mr" || name.title == "Mrs" || name.title == "Ms" {
            return name.title + ". " + name.first + " " + name.last
        } else {
            return name.title + " " + name.first + " " + name.last
        }
    }
}

struct Name: Decodable {
    let title: String
    let first: String
    let last: String
}

struct Picture: Decodable {
    let large: String
    let medium: String
    let thumbnail: String
}
