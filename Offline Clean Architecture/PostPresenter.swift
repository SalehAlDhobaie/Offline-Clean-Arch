//
//  PostPresenter.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 2/9/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import RxSwift


public protocol PostPresenterDelegate : class {
    
    func onSuccess(result: [Post])
    func onFailure(result: Error)
    
}

public class PostPresenter {
    
    
    public weak var delegate: PostPresenterDelegate?
    fileprivate let disposableBag = DisposeBag()
    private let post : PostServiceOperations
    
    init(post: PostServiceOperations, delegate: PostPresenterDelegate) {
        self.post = post
        self.delegate = delegate
    }
    
    
    private func fetchPost() {
        
        
        _ = self.post.allPost().subscribe(onNext: { (posts) in
            print("\n\n\n\n\n\n\n\n\n \(#function), \(#line) value: \(posts.count)")

            self.delegate?.onSuccess(result: posts)
        }, onError: { error in
            // stop loading
            // stop operation
            self.delegate?.onFailure(result: error)
            
        }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposableBag)
        
    }

    func offlinePost() {
        
        
        _ = self.post.offlineAllPost().subscribe(onNext: { (posts) in
            
            print("\n\n\n\n\n\n\n\n\n \(#function), \(#line) value: \(posts.count)")

            self.delegate?.onSuccess(result: posts)
            self.fetchPost()
            
        }, onError: { (error) in
            
            self.fetchPost()
            
        }, onCompleted: nil, onDisposed: nil).addDisposableTo(disposableBag)
        
    }
    
}
