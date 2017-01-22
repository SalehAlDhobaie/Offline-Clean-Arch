//
//  RealmWrapper.swift
//  Offline Clean Architecture
//
//  Created by Abdullah Alhazmy on 1/22/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmParser {
    
    
    public func writeObject<T: Object>(realmObject: T) throws -> T {
        let realm = try! Realm()
        try realm.write {
            realm.add(realmObject, update: true)
        }
        
        return realmObject
    }
    
    
    
    public func  writeObject<T: Object>(realmObject: [T]) throws -> [T] {
        let realm = try! Realm()
        try realm.write {
            realm.add(realmObject, update: true)
        }
        
        
        return realmObject
    }
    
}
