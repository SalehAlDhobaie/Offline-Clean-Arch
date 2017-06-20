//
//  ViewController.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {

    
    @IBOutlet var tableView : UITableView!
    
    lazy var presenter: PostPresenter = {
        
        let repo = NetworkPostRepositoryImp()
        let offline = RealmPostRepositoryImp()
        let service = PostServiceOperations(repo: repo, offline: offline)
        
        return PostPresenter(service: service, delegate:self)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(PostViewController.fetchPost))
        setupTableView(tableView: tableView)
        
    }
    
    fileprivate func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 64.0
        tableView.rowHeight = UITableViewAutomaticDimension
        let nib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "PostTableViewCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func fetchPost() {    
        presenter.fetchPost()
    }
}
extension PostViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItmes(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        let item = presenter.postItem(indexPath: indexPath)
        
        cell.titleLable.text = item.title
        cell.bodyLable.text = item.body
        
        return cell 
    }
}

extension PostViewController : PostPresenterDelegate {
  
    func fetchPostFailure(error: Error) {
        print(error)
    }
    
    
    func fetchPostSuccessfully(result: [Post], cache: Bool) {
        
        if cache == true {
            tableView.reloadData()
        }else {
            let set = IndexSet(0..<1)
            tableView.reloadSections(set, with: UITableViewRowAnimation.bottom)
        }
    }
}

