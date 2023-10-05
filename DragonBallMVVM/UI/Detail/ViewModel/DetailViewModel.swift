//
//  DetailViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol DetailViewModelProtocol {
    func viewLoaded()
    func myHeroFor() -> Hero?
}
//MARK: - Clase -
final class DetailViewModel {
    
    private weak var detailDelegate: DetailViewControllerProtocol?
    private var detailData: HeroesAndTransformations?
    
    init(detailDelegate: DetailViewControllerProtocol? = nil, 
         detailData: HeroesAndTransformations?) {
        self.detailDelegate = detailDelegate
        self.detailData = detailData
    }
    
    private func loadData(){
        detailDelegate?.updateView(data: detailData)
        detailDelegate?.getTransformation(heroe: detailData)
    }
}

//MARK: - Extension -
extension DetailViewModel: DetailViewModelProtocol {
    func myHeroFor() -> Hero? {
        return detailData as? Hero
    }
    
    func viewLoaded() {
        loadData()
    }
}
