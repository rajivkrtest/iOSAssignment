//
//  HomeController.swift
//  iOSAssignment
//
//  Created by Rajiv Kumar on 03/10/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Kingfisher

class HomeController: RootViewController {
    
    var homeItems = [Row]()
    
    var homeTableView: UITableView!
    
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.homeTableView = UITableView()
        
        self.homeTableView?.dataSource = self
        self.homeTableView?.delegate = self
        self.homeTableView?.rowHeight = UITableView.automaticDimension
        self.homeTableView?.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.homeTableView?.estimatedRowHeight = 100
        self.homeTableView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.homeTableView!)
        self.homeTableView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.homeTableView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.homeTableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.homeTableView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        self.homeTableView?.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        self.fetchFacts(string: "Loading...")
    
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.homeTableView?.addSubview(self.refreshControl) // not required when using UITableViewController
    }

    @objc func refresh(_ sender: AnyObject) {
       self.fetchFacts(string: "Refreshing...")
    }
    
    func fetchFacts(string: String) {
        self.title = string
        APIClient.shared.getFacts(parameters: [:], completion: { (results) in
            if let results = results {
                if results.title != nil {
                    self.title = results.title
                }
                if results.rows != nil {
                    self.homeItems = results.rows
                }
                self.homeTableView?.reloadData()
                self.refreshControl.endRefreshing()
            }
        }) { (error) in
            if let error:APIError = error {
                self.title = ""
                let dialogMessage = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    self.homeTableView?.reloadData()
                    self.refreshControl.endRefreshing()
                 })
                dialogMessage.addAction(ok)
                self.present(dialogMessage, animated: true, completion: nil)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.homeTableView?.reloadData()
    }
    
    override func viewDidLayoutSubviews(){
        self.homeTableView?.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}

extension HomeController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.homeTableView?.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell?

        let item = self.homeItems[indexPath.row]
        
        if let imageHref = item.imageHref as? String {
            cell?.imageViewFeed.setImage(with: imageHref)
        }
        
        if let title = item.title {
            cell?.labelText.text = title
        }
        
        if let descriptionField = item.descriptionField {
            cell?.labelDescription.text = descriptionField
        }
        
        return cell!
    }
}

extension HomeController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
