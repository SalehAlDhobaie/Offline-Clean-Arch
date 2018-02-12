//
//  ViewController.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var tableViewData : [Post] = []
    
    var posts : PostPresenter!
    lazy var presenter : PostPresenter = {
        
        let repo = NetworkPostRepositoryImp()
        let offline = RealmPostRepositoryImp()
        let posts = PostServiceOperations(repo: repo, offline: offline)
        
        return PostPresenter(post: posts, delegate: self)
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 64.0
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(ViewController.testFetchPost(_:)))
    }
    @IBAction func testFetchPost(_ sender: Any) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        presenter.offlinePost()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let post = tableViewData[indexPath.row]
        if let body = post.body {
            cell.textLabel?.text = body
        }else {
            cell.textLabel?.text = ""
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ViewController : PostPresenterDelegate {
    
    func onSuccess(result: [Post]) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        tableViewData = result
        let indexSet = IndexSet(0...0)
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    func onFailure(result: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print("\n\n\n\n\n\n\n\n\n \(#function), \(#line) value: \(result)")
        

    }
}
