//
//  PostRepositrory.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift


public protocol PostRepositrory {
    
    
    // GET /posts
    func allPosts() -> Observable<[Post]>
    
}


protocol CommentRepositrory {
    
    
    // GET /posts
    func allComments() -> Observable<[Comment]>
    
    
}

