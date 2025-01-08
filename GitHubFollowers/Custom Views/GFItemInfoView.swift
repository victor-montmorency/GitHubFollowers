//
//  GFItemInfoView.swift
//  GitHubFollowers
//
//  Created by victor mont-morency on 07/01/25.
//

import UIKit

enum itemInfoType {
case repos, gist, followers, following
}


class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAligment: .left, fontSize: 14)
    let countLabel = GFTitleLabel(textAligment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    func set(itemInfoType: itemInfoType, withCount count: Int){
        switch itemInfoType {
        case .followers:
            symbolImageView.image = UIImage(systemName: "person.3")
            titleLabel.text = "Followers"
            break
            
        case .following:
            symbolImageView.image = UIImage(systemName: "heart")
            titleLabel.text = "Following"
            break
            
        case .gist:
            symbolImageView.image = UIImage(systemName: "text.alignleft")
            titleLabel.text = "Public Gists"
            break
            
        case .repos:
            symbolImageView.image = UIImage(systemName: "folder")
            titleLabel.text = "Public Repositories"
            break
        }
        countLabel.text = String(count)
    }
}
