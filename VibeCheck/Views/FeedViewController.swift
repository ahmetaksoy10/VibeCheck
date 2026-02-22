//
//  HomeView.swift
//  VibeCheck
//
//  Created by MacBook Pro on 19.02.2026.
//

import UIKit
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var feedViewModel = FeedViewViewModel()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupBindings()
        feedViewModel.fetchPosts()
    }
    
    func showAlert(errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func setupBindings() {
        feedViewModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        feedViewModel.error = {[weak self] errorMessage in
            DispatchQueue.main.async {
                self?.showAlert(errorMessage: errorMessage)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.postArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.documentID.text = feedViewModel.postArrays[indexPath.row].postID
        cell.postImage.sd_setImage(with: URL(string: feedViewModel.postArrays[indexPath.row].imageUrl))
        cell.usernameLabel.text = feedViewModel.postArrays[indexPath.row].authorEmail
        cell.caption.text = feedViewModel.postArrays[indexPath.row].caption
        return cell
    }

}
