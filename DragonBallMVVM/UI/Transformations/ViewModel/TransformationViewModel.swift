//
//  TransformationViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 5/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol TransformationViewModelProtocol {
    func viewIsLoading()
    var transformationCount: Int {get}
}

//MARK: - Clase -
final class TransformationViewModel {
    private weak var transViewDelegate: TransformationsViewControllerProtocol?
    private var hero: Hero?
    private var transViewData: [Transformation?] = []
    
    init(transViewDelegate: TransformationsViewControllerProtocol? = nil, hero: Hero?, transViewData: [Transformation?]) {
        self.transViewDelegate = transViewDelegate
        self.hero = hero
        self.transViewData = transViewData
    }
    
    func viewIsLoading() {
        transViewDelegate?.transPrintData()
    }
    
    func viewIsLoaded() {
        
    }
}

//MARK: - Extension -
extension TransformationViewModel: TransformationViewModelProtocol {
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
                        self.viewIsLoaded()
                    }
                case let .failure(error):
                    print("\(error)")
            }
        }
    }
    
    func transformationData(at index: Int) -> HeroesAndTransformations? {
        return transViewData[index]
    }
}
