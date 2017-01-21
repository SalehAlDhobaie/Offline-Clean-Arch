//
//  PostRepositoryImp.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import Moya_ModelMapper
import Moya
import ReachabilitySwift



struct NetworkPostRepositoryImp : PostRepositrory {
    
    
    
    
    
    func allPosts() -> Observable<[Post]> {
        
        let p = provider
        return p.request(.posts).map({ (response) -> [Post] in
            
            do {
                let result = try response.filterSuccessfulStatusCodes()
                let mappingResult = try result.mapArray() as [Post]
                let realmObjects = Post.realmObjects(items: mappingResult)
                
                let realm = try! Realm()
                try realm.write {
                    realm.add(realmObjects, update: true)
                }
                return mappingResult
                
            }catch (let error) {
                
                if case MoyaError.underlying(let error) = error {
                    print(error)
                }else if case MoyaError.jsonMapping(let e) = error {
                    print("ERROR : \(error), jsonMapping: \(e)")
                }else if case MoyaError.statusCode(let status) = error {
                    print("ERROR : \(error), Status: \(status)")
                }else if case MoyaError.requestMapping(let value) = error {
                    print("ERROR : \(error), requestMapping: \(value)")
                }
                throw error
            }
        })
    }
    
    
}



struct RealmPostRepositoryImp : PostRepositrory {
    
    func allPosts() -> Observable<[Post]> {
        
        return Observable.create({ (observer) -> Disposable in
            
            do {
                
                let realm = try Realm()
                let items = realm.objects(PostRealmObject.self)
                

                let posts : [Post] = items.map({ (item) -> Post in
                    let post = Post(userId: item.userId, id: item.id, title: item.title, body: item.body)
                    return post
                })
                
              
                observer.onNext(posts)
                observer.on(.completed)
            }catch (let error) {
                observer.onError(error)
                observer.on(.completed)
                
                
            }
            return Disposables.create()
        })
        
        
        
    }
    
}
