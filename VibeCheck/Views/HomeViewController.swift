//
//  HomeView.swift
//  VibeCheck
//
//  Created by MacBook Pro on 19.02.2026.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.documentID.text = ""
        cell.postImage.image = UIImage(systemName: "photo.fill")
        cell.usernameLabel.text = "ahmetaksoy_10"
        cell.caption.text = "harika"
        return cell
    }

}
