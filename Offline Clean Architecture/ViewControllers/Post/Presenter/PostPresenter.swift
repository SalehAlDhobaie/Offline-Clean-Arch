//
//  PostPresenter.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 6/16/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostPresenterDelegate : class {
    
    func fetchPostSuccessfully(result: [Post], cach: Bool)
    func fetchPostFailure(error: Error)
    
}

public class PostPresenter {
    
    fileprivate var delegate : PostPresenterDelegate?
    fileprivate let service: PostServiceOperations
    fileprivate let dispose = DisposeBag()
    
    fileprivate var posts : [Post] = []
    
    init(service: PostServiceOperations, delegate: PostPresenterDelegate) {
        
        self.service = service
        self.delegate = delegate
    }
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfItmes(in section: Int) -> Int {
        return posts.count
    }
    
    func postItem(indexPath: IndexPath) -> Post {
        return posts[indexPath.row]
    }
    
    
    func fetchPost() {
        
        service.offlineAllPost().subscribe(onNext: { [weak self]  result in
            
            self?.posts = result
            self?.delegate?.fetchPostSuccessfully(result: result, cach: true)
            self?.fetchNetwork()
            
        }, onError: { [weak self] error in
            
            self?.delegate?.fetchPostFailure(error: error)
            
        }, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
        
    }
    
    fileprivate func fetchNetwork() {
        
        service.netWorkAllPost().subscribe(onNext: { [weak self]  result in
            
            self?.posts = result
            self?.delegate?.fetchPostSuccessfully(result: result, cach: false)

            
            }, onError: { [weak self] error in
                
                self?.delegate?.fetchPostFailure(error: error)
                
            }, onCompleted: nil, onDisposed: nil).addDisposableTo(dispose)
    }
    
    
}
