//
//  IntroViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol IntroViewModelProtocol {
    func viewIsLoaded()
}

//MARK: - Clase -
final class IntroViewModel {
    
    private weak var viewDelegate: IntroViewControllerProtocol?
    
    init(viewDelegate: IntroViewControllerProtocol? ) {
        self.viewDelegate = viewDelegate
    }
    
    private func getAndChargeHeroes() {
        viewDelegate?.mySession()
    }
}

//MARK: - Extension -
extension IntroViewModel: IntroViewModelProtocol {
    func viewIsLoaded() {
        getAndChargeHeroes()
    }
}
