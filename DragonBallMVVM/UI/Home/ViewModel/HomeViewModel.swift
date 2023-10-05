//
//  HomeViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol HomeViewProtocol {
    func viewIsLoaded()
    func myHeroes()
    func heroData(at index: Int) -> HeroesAndTransformations?
    var heroCount: Int {get}
}

var session = NetworkModel()

//MARK: - Clase -
final class HomeViewModel {
    
    private weak var viewDelegate: HomeViewControllerProtocol?
    private var viewData: [HeroesAndTransformations] = []
    
    init(viewDelegate: HomeViewControllerProtocol? = nil ) {
        self.viewDelegate = viewDelegate
    }
    
     private func loadData() {
         self.myHeroes()
    }
}

//MARK: - Extension -
extension HomeViewModel: HomeViewProtocol {
    func viewIsLoaded() {
        loadData()
    }
    
    func myHeroes()  {
        let networkModel = NetworkModel()
        networkModel.getHeroes { [weak self] result in
            guard case let .success(heroes) = result else {
                return
            }
            self?.viewData = heroes
            DispatchQueue.main.async {
                self?.viewDelegate?.printData()
            }
        }
    }
    
    var heroCount: Int {
        viewData.count
    }
    
    func heroData(at index: Int) -> HeroesAndTransformations? {
        return viewData[index]
    }
}
