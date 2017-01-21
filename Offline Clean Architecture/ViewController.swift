//
//  ViewController.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var posts : PostServiceOperations!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let repo = NetworkPostRepositoryImp()
        let offline = RealmPostRepositoryImp()
        posts = PostServiceOperations(repo: repo, offline: offline)
//        fetchPost()
        
    }
    @IBAction func testFetchPost(_ sender: Any) {
        
        fetchPost()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fetchPost() {
        
        _ = self.posts.allPost().subscribe(onNext: { (posts) in
            print("\n\n\n\n\n\n\n\n\n \(#function), \(#line) value: \(posts)")
        }, onError: { (error) in
            print("\n\n\n\n\n\n\n\n\n \(#function), \(#line) value: \(error)")
        }, onCompleted: nil, onDisposed: nil)
    }

}

