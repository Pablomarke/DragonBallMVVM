//
//  TransformationViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 5/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol TransformationViewModelProtocol {
    func viewIsLoaded()
    func myTransformations()
    func transformationData(at index: Int) -> HeroesAndTransformations?
    var transformationCount: Int {get}
}

//MARK: - Clase -
final class TransformationViewModel {
    
    private weak var transViewDelegate: TransformationsViewControllerProtocol?
    private var hero: Hero?
    private var transViewData: [HeroesAndTransformations] = []
    
    init(transViewDelegate: TransformationsViewControllerProtocol? = nil, hero: Hero? ) {
        self.transViewDelegate = transViewDelegate
        self.hero = hero
    }
    
     private func loadData() {
            myTransformations()
    }
}

//MARK: - Extension -
extension TransformationViewModel: TransformationViewModelProtocol {
    func viewIsLoaded() {
        loadData()
    }
    
    func transformationData(at index: Int) -> HeroesAndTransformations? {
        return transViewData[index]
    }
    
    var transformationCount: Int {
        transViewData.count
    }
    
    func myTransformations() {
        session.getTransformations(
            for: hero!
        ) {  result in
            switch result {
                case let .success(transformations):
                    self.transViewData = transformations
                    DispatchQueue.main.async {
                        self.transViewDelegate?.transPrintData()
                    }
                case let .failure(error):
                    print("\(error)")
            }
        }
    }
}
