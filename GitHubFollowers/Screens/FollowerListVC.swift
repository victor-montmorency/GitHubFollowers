//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 21/09/24.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }

}
