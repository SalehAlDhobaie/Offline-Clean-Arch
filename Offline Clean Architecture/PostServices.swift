//
//  PostServices.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift
import ReachabilitySwift

fileprivate struct AllPostService : UseCase {
    
    fileprivate let repo : PostRepositrory
    init(repo: PostRepositrory) {
        self.repo = repo
    }
    
    
    public func execute(request: UseCaseRequest) -> Observable<[Post]> {
        return repo.allPosts()
    }
}


public struct PostServiceOperations {
    
    fileprivate let all : AllPostService
    fileprivate var allOffline : AllPostService?
    
    init (repo: PostRepositrory) {
        self.all = AllPostService(repo: repo)
        self.allOffline = nil
    }
    
    init(repo: PostRepositrory, offline: PostRepositrory) {
        
        self.all = AllPostService(repo: repo)
        self.allOffline = AllPostService(repo: offline)
    }
    
    func allPost() -> Observable<[Post]> {
        let empty = EmptyUseCaseRequest()
        return all.execute(request: empty)
    }
    
    func offlineAllPost() -> Observable<[Post]> {
        
        let empty = EmptyUseCaseRequest()
        if let offline = allOffline {
            // not null
            return offline.execute(request: empty)
            
        }else {
            // offline is null 
            return all.execute(request: empty)
        }
        
    }
    
}
