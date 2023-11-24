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
    func navigateToHomeTransformations(data: HeroesAndTransformations?)
    
}

//MARK: - Clase -
class DetailViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroDescription: UITextView!
    @IBOutlet weak var transformationButton: UIButton!
    @IBOutlet weak var transformationView: UIView!
    
    var detailViewModel: DetailViewModelProtocol?
    
    //MARK: - Ciclo de vida -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        transformationButton.isHidden = true
        transformationView.isHidden = true
        detailViewModel?.viewLoading()
    }
    
    //MARK: - Acción de Botón -
    @IBAction func transformationAction(_ sender: Any) {
        detailViewModel?.navigateToTransformations()
    }
}
    
//MARK: - Extension -
extension DetailViewController: DetailViewControllerProtocol {

    func updateView(data: HeroesAndTransformations?) {
        guard let data = data else {return}
        heroImage.setImage(for: data.photo)
        heroNameLabel.text = data.name 
        heroDescription.text = data.description
        buttonHidden()
    }
    
    func buttonHidden(){
        if detailViewModel?.transformationCount ?? 0 > 0 {
            self.transformationButton.isHidden = false
            self.transformationView.isHidden = false
        }
    }
    
    func navigateToHomeTransformations(data: HeroesAndTransformations?) {
        let transformationView = TransformationViewController()
        transformationView.transViewModel = TransformationViewModel(transViewDelegate: transformationView,
                                                                    hero: data as? Hero )
        self.navigationController?.pushViewController(transformationView,
                                                      animated: true)
    }
}
