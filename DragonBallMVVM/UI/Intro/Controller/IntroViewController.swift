//
//  IntroViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit


//MARK: - Protocolo -
protocol IntroViewControllerProtocol: AnyObject {
    func navigationToHeroes()
    func myLoading()
}

//MARK: - Clase -
class IntroViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var introLabel: UILabel!
    
    var viewModel: IntroViewModelProtocol?
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        startedView()
    }
}

//MARK: - Extension -
extension IntroViewController: IntroViewControllerProtocol {
    func startedView() {
        self.view.backgroundColor = .red
        introLabel.isHidden = true
        myLoading()
    }
    
    func navigationToHeroes() {
        let Home = HomeViewController()
        self.navigationController?.setViewControllers([Home],
                                                      animated: true)
    }
    
    func myLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
            self.introLabel.isHidden = false
            self.introLabel.text = "Bienvenido!! un segundo que estamos cargando los heroes..."
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
                self.navigateToHomeHeroes()
            }
        }
    }
    
    func navigateToHomeHeroes() {
        let home = HomeViewController()
        self.navigationController?.setViewControllers([home],
                                                      animated: true)
    }
    
}
