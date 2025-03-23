//
//  HeroCell.swift
//  DesignPatternsDragonBall
//
//  Created by Ana on 23/3/25.
//

import UIKit

final class HeroCell: UITableViewCell {
    static let reuseIdentifier = "HeroCell"
    static let height: CGFloat = 90
    
    // MARK: - Outlets
    
    @IBOutlet private weak var avatarView: AsyncImage!
    
    @IBOutlet private var nameLabel: UILabel!
    
    
    
    
    func setData(name: String, photo: String) {
        nameLabel.text = name
        avatarView.setImage(photo)
    }
}
