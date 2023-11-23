//
//  IntroViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit

//MARK: - Protocolo -
protocol IntroViewProtocol: AnyObject {
    func navigationToHeroes()
    func stateChargingOne()
    func stateChargingtwo()
}

//MARK: - Clase -
class IntroViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    @IBOutlet weak var label1: UILabel!

    var viewModel: IntroViewModelProtocol?
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        startedView()
        
    }
}

//MARK: - Extension -
extension IntroViewController: IntroViewProtocol{
    func startedView() {
        viewModel?.viewLoading()
    }
    
    func navigationToHeroes() {
        let home = HomeViewController()
        home.viewModel = HomeViewModel(viewDelegate: home)
        self.navigationController?.setViewControllers([home],
                                                animated: true)
    }
    
    func stateChargingOne(){
        self.label1.text = "Honda Vital"
    }
    
    func stateChargingtwo(){
        self.backgroundImage.image = UIImage(named: "fondo1")
    }
}
