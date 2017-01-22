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

public class Post : Object, Mappable {
    
    dynamic var id = 0
    dynamic var userId = 0
    dynamic var title : String? = nil
    dynamic var body: String? = nil
    
    override public class func primaryKey() -> String? {
        return "id"
    }
    
    public convenience required init(map: Mapper) throws {
        self.init()
        userId               = map.optionalFrom("userId")!
        id                   = map.optionalFrom("id")!
        title                = map.optionalFrom("title")
        body                 = map.optionalFrom("body")
    }

}

