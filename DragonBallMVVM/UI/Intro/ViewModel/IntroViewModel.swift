//
//  IntroViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation
import UIKit

//MARK: - Protocolo -
protocol IntroViewModelProtocol {
    func viewLoading()
    func viewIsLoaded()
}

//MARK: - Clase -
final class IntroViewModel {
    
    private weak var viewDelegate: IntroViewProtocol?
    
    init(viewDelegate: IntroViewProtocol? ) {
        self.viewDelegate = viewDelegate
    }
    
    func myLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ) {
            self.viewDelegate?.stateChargingOne()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) ) {
                self.viewDelegate?.stateChargingtwo()
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2) ) {
                    self.viewIsLoaded()
                }
            }
        }
    }
}
//MARK: - Extension -
extension IntroViewModel: IntroViewModelProtocol {
    func viewLoading() {
        mySession()
        myLoading()
    }
    
    func viewIsLoaded() {
        self.viewDelegate?.navigationToHeroes()
    }
    
    func mySession() {
        session.login(user: "markedevelop@gmail.com",
                      password: "abcd1234") { result in
            switch result {
                case .success(_):
                    print("Acceso ok!")
                case .failure(let error):
                    print(error)
            }
        }
    }
}
