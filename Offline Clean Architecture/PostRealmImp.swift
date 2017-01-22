//
//  PostRealmImpl.swift
//  Offline Clean Architecture
//
//  Created by Abdullah Alhazmy on 1/22/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

struct RealmPostRepositoryImp : PostRepositrory {
    
    func allPosts() -> Observable<[Post]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            do {
                
                let realm = try Realm()
                let items = realm.objects(Post.self)
                
                let posts : [Post] = items.map({ (item) -> Post in
                    return item
                })
                
                observer.onNext(posts)
            }catch (let error) {
                observer.onError(error)
                
            }
            observer.on(.completed)
            return Disposables.create()
        })
        
        
        
    }
    
}
