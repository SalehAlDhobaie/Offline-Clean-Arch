//
//  PostRepositoryImp.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift
import Moya

struct NetworkPostRepositoryImp : PostRepositrory {
    
    func allPosts() -> Observable<[Post]> {
        
        let p = provider
        return p.request(.posts).map({ (response) -> [Post] in
            
            do {
                let mappingResult = try response.filterSuccessfulStatusCodes().mapArray() as [Post]
                return try RealmParser().writeObject(realmObject: mappingResult)
                
            }catch (let error) {
                throw ErrorHandler.handleError(error: error)
            }
        })
    }
    
    
    
    
}

