//
//  DetailViewModel.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import Foundation

//MARK: - Protocolo -
protocol DetailViewModelProtocol {
    func viewLoading()
    func viewLoaded()
    var transformationCount: Int {get}
    func navigateToTransformations()
}
//MARK: - Clase -
final class DetailViewModel {
    
    private weak var detailDelegate: DetailViewControllerProtocol?
    private var detailData: HeroesAndTransformations?
    private var modelTransformations: [Transformation?] = []
    
    init(detailDelegate: DetailViewControllerProtocol? = nil,
         detailData: HeroesAndTransformations?, modelTransformations: [Transformation?] = [] ) {
        self.detailDelegate = detailDelegate
        self.detailData = detailData
        self.modelTransformations = modelTransformations
    }
    
    func viewLoading() {
        getTransformation(heroe: detailData)
        
    }
    
    func viewLoaded() {
        detailDelegate?.updateView(data: detailData)
    }
    
    func navigateToTransformations(){
        detailDelegate?.navigateToHomeTransformations(data: detailData,
                                                      transformations: modelTransformations)
    }
}

//MARK: - Extension -
extension DetailViewModel: DetailViewModelProtocol {
    var transformationCount: Int {
        modelTransformations.count 
    }
    
    func getTransformation(heroe: HeroesAndTransformations?) {
        session.getTransformations(
            for: heroe!
        ) {  result in
            switch result {
                case let .success(transformations):
                    DispatchQueue.main.async {
                        self.modelTransformations.append(contentsOf: transformations)
                        self.viewLoaded()
                    }
                case let .failure(error):
                    print("\(error)")
            }
        }
    }
}
