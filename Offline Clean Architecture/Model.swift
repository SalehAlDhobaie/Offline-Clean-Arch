//
//  Model.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import Mapper
import RealmSwift

public class PostRealmObject : Object {
    
    dynamic var id : Int = 0
    dynamic var userId : Int = 0
    dynamic var title: String = ""
    dynamic var body: String = ""
    
    override public class func primaryKey() -> String? {
        return "id"
    }
    
}



public struct Post {
    
    
    public var userId : Int?
    public var id : Int?
    public var title: String?
    public var body: String?
    
    
}

extension Post: Mappable {
    
    public init(map: Mapper) throws {
        userId               = map.optionalFrom("userId")
        id                   = map.optionalFrom("id")
        title                = map.optionalFrom("title")
        body                 = map.optionalFrom("body")
    }
}


extension Post {
    
    static func realmObject(post: Post) -> PostRealmObject {
        
        let realmObject = PostRealmObject()
        realmObject.id = post.id!
        realmObject.userId = post.userId!
        realmObject.title = post.title!
        realmObject.body = post.body!
        
        return realmObject
    }
    
    static func realmObjects(items: [Post]) -> [PostRealmObject] {
        return items.map { (item) -> PostRealmObject in
            return Post.realmObject(post: item)
        }
    }
    
}


public struct Comment  {
    
    public var postId : Int?
    public var id: Int?
    public var name: String?
    public var email: String?
    public var body: String?
    
    
}

extension Comment: Mappable {

	public init(map: Mapper) throws {
		postId               = map.optionalFrom("postId")
		id                   = map.optionalFrom("id")
		name                 = map.optionalFrom("name")
		email                = map.optionalFrom("email")
		body                 = map.optionalFrom("body")
	}
}
