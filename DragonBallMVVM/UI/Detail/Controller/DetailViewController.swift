//
//  DetailViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit

//MARK: - Protocolo -
protocol DetailViewControllerProtocol: AnyObject {
    func updateView(data: HeroesAndTransformations?)
}

//MARK: - Clase -

class DetailViewController: UIViewController {
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var transformationButton: UIButton!
    
    var detailViewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailViewModel?.viewLoaded()
        
    }
}
    
//MARK: - Extension -
extension DetailViewController: DetailViewControllerProtocol {
    func updateView(data: HeroesAndTransformations?) {
        guard let data = data else {return}
        heroImage.setImage(for: data.photo)
        heroNameLabel.text = data.name 
        heroDescription.text = data.description
    }
}
