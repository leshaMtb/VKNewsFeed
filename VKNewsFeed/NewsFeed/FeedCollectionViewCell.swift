//
//  FeedCollectionViewCell.swift
//  VKNewsFeed
//
//  Created by Apple on 05.10.2021.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    
    
}
