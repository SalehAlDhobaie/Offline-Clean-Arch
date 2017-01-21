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

public struct AllPostService : UseCase {
    
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
    fileprivate var allOffline : AllPostService
    let reachability : Reachability
    init(repo: PostRepositrory, offline: PostRepositrory) {
        
        self.all = AllPostService(repo: repo)
        self.allOffline = AllPostService(repo: offline)
        
        self.reachability = Reachability(hostname: "http://jsonplaceholder.typicode.com")!
    }
    
    
    func allPost() -> Observable<[Post]> {
        
        let empty = EmptyUseCaseRequest()
        if self.reachability.isReachable == true {
            return self.all.execute(request: empty)
        }else {
            return allOffline.execute(request: empty)
        }
        
    }
    
}
