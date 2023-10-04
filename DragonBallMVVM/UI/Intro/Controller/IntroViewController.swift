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
    func mySession()
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
        viewModel?.viewIsLoaded()
        
    }
}

//MARK: - Extension -
extension IntroViewController: IntroViewControllerProtocol {
    func mySession() {
        session.login(user: "markedevelop@gmail.com", password: "abcd1234") { result in
            switch result {
                case .success(_):
                    print("Acceso ok!")
                case .failure(let error):
                    print(error)
            }
        }
    }
    
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
        DispatchQueue.main.asyncAfter(deadline: .now()  ) {
            self.introLabel.isHidden = false
            self.introLabel.text = "Bienvenido!! un segundo que estamos cargando los heroes..."
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
                self.navigateToHomeHeroes()
            }
        }
    }
    
    func navigateToHomeHeroes() {
        let home = HomeViewController()
        home.viewModel = HomeViewModel(viewDelegate: home)
        self.navigationController?.setViewControllers([home],
                                                      animated: true)
    }
    
}
