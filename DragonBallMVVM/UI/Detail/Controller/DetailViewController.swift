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
    func getTransformation(heroe: HeroesAndTransformations?)
}

//MARK: - Clase -

class DetailViewController: UIViewController {
    
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var transformationButton: UIButton!
    @IBOutlet weak var transformationView: UIView!
    
    var detailViewModel: DetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        transformationButton.isHidden = true
        transformationView.isHidden = true
        detailViewModel?.viewLoaded()
    }
    
    @IBAction func transformationAction(_ sender: Any) {
        self.navigateToHomeTransformations(data: detailViewModel?.myHeroFor())
    }
}
    
//MARK: - Extension -
extension DetailViewController: DetailViewControllerProtocol {
    func getTransformation(heroe: HeroesAndTransformations?) {
        var modelTransformations: [Transformation?] = []
        session.getTransformations(
            for: heroe!
        ) {  result in
            switch result {
                case let .success(transformations):
                    DispatchQueue.main.async {
                        modelTransformations.append(contentsOf: transformations)
                       
                        if modelTransformations.count > 0 {
                            self.transformationButton.isHidden = false
                            self.transformationView.isHidden = false
                        }
                    }
                case let .failure(error):
                    print("\(error)")
            }
        }
    }
    
    func updateView(data: HeroesAndTransformations?) {
        guard let data = data else {return}
        heroImage.setImage(for: data.photo)
        heroNameLabel.text = data.name 
        heroDescription.text = data.description
    }
    
    func navigateToHomeTransformations(data: HeroesAndTransformations?) {
        guard let data = data else {return}
        let transformationView = TransformationViewController()
        transformationView.transViewModel = TransformationViewModel(transViewDelegate: transformationView, 
                                                                    hero: data as! Hero )
        self.navigationController?.pushViewController(transformationView,
                                                      animated: true)
    }
}
