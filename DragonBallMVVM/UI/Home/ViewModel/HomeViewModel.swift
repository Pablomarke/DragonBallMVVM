//
//  HomeViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol HomeViewProtocol {
    func viewIsLoading()
    func myHeroes()
    func data(at index: Int) -> HeroesAndTransformations?
    func heroData(at index: Int)
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
    
    func viewIsLoading() {
        self.myHeroes()
    }
    
    func viewIsLoaded() {
        viewDelegate?.printData()
    }
}

//MARK: - Extension -
extension HomeViewModel: HomeViewProtocol {
    func myHeroes()  {
        let networkModel = NetworkModel()
        networkModel.getHeroes { [weak self] result in
            guard case let .success(heroes) = result else {
                return
            }
            self?.viewData = heroes
            DispatchQueue.main.async {
                self?.viewIsLoaded()
            }
        }
    }
    
    var heroCount: Int {
        viewData.count
    }

    func heroData(at index: Int) {
        guard let data = data(at: index) else { return }
        viewDelegate?.showHeroDetail(hero: data)
    }
    
    func data(at index: Int) -> HeroesAndTransformations?{
        guard index < heroCount else { return nil }
        return viewData[index]
    }
}
