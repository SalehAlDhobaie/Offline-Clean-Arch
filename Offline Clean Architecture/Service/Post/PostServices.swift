//
//  PostServices.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift

fileprivate struct AllPostService : UseCase {
    
    let repo : PostRepositrory
    init(repo: PostRepositrory) {
        self.repo = repo
    }
    
    
    public func execute(request: UseCaseRequest) -> Observable<[Post]> {
        return repo.allPosts()
    }
}


public struct PostServiceOperations {
    
    fileprivate var all : AllPostService
    fileprivate var allOffline : AllPostService? = nil
    init(repo: PostRepositrory, offline: PostRepositrory?) {
        
        self.all = AllPostService(repo: repo)
        if let offlineValue = offline {
            self.allOffline = AllPostService(repo: offlineValue)
        }
    }
    
    func netWorkAllPost() -> Observable<[Post]> {
        let empty = EmptyUseCaseRequest()
        return self.all.execute(request: empty)
    }
    
    func offlineAllPost() -> Observable<[Post]> {
        
        let empty = EmptyUseCaseRequest()
        if let offlineService = allOffline {
            return offlineService.execute(request: empty)
        }else {
            return self.all.execute(request: empty)
        }
        
    }
    
}
