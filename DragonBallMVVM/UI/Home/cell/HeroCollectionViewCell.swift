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
        cellStyle()
    }
    
    override func prepareForReuse() {
        imageHero.image = nil
        nameHero.text = nil
    }
    
    func cellStyle() {
        cellView.backgroundColor = .systemOrange
    }
    
    func updateViews(data: Hero?){
        guard let data = data else {return}
        update(name: data.name)
        imageHero.setImage(for: data.photo)
    }
    
    func update(name: String?) {
        nameHero.text = name ?? ""
    }
}
