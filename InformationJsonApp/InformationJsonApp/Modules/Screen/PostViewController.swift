//
//  MainViewController.swift
//  InformationJsonApp
//
//  Copyright © 2018  Łukasz Wojtarowicz. All rights reserved.
//

import UIKit

final class PostViewController: UIViewController {
    
    var postsArray: [Post] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPosts()
        setup()
    }
}

// UITableViewDataSource
extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath  ) -> UITableViewCell {
        let post = postsArray[indexPath.row]
       
        // Creating custom cell for concrete indexPath
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as? PostsTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLabel.text = "\(post.id): " + post.title
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returning number of rows in table view which are connected to postsArray
        return postsArray.count
    }
}

// UITableViewDelegate
extension PostViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Cell select detection
        guard let cell = tableView.cellForRow(at: indexPath) as? PostsTableViewCell else {
            return
        }
        print(cell.nameLabel.text ?? "Empty")
    }

}

extension PostViewController {
    
    private func setup() {
        // Registering custom cell clss for our tableView
        tableView.register(UINib(nibName: "PostsTableViewCell", bundle: nil), forCellReuseIdentifier: PostsTableViewCell.identifier)
    }
    
    private func fetchPosts() {
        NetworkRequest.fetchPost { (succes, posts) in
            guard succes, let posts = posts else {
                return
            }
            DispatchQueue.main.async {
                self.postsArray = posts
            }
        }
    }
}

