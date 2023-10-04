//
//  HeroCollectionViewCell.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit

class HeroCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var nameHero: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.backgroundColor = .green
        nameHero.text = "Goku"
    }

}
