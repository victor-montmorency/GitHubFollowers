//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 05/01/25.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAligment: .center)
    var itemViews: [UIView] = []
    
    var username: String!
    weak var delegate: followerListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        configureViewController()
        getUserInfo()

    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username){ [weak self] result in
            guard let self = self else {return}
            
            switch result{
                case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                print(user)
            case .failure(let error):
                self.presentGFAlerOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    

    func formatDate(from oldFormat: String) -> String? {
        let isoDateFormatter = DateFormatter()
        isoDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = isoDateFormatter.date(from: oldFormat) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd, yyyy"
            
            return "created at " + outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func configureUIElements(with user: User){
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: GFUserInfoVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.dateLabel.text = self.formatDate(from: user.createdAt)
    }
    
    func layoutUI(){
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
        }
        

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    
@objc func dismissVC() {
        dismiss(animated: true)
    }

}

extension UserInfoVC: UserInfoVCDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlerOnMainThread(title: "invalid URL", message: "the URL attached to this user is invalid", buttonTitle: "OK")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemRed
        present(safariVC, animated: true)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlerOnMainThread(title: "No Followers", message: "This user has no followers", buttonTitle: "OK")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
}
