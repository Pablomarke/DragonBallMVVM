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
}
//MARK: - Clase -
final class DetailViewModel {
    
    private weak var detailDelegate: DetailViewControllerProtocol?
    private var detailData: Hero?
    
    init(detailDelegate: DetailViewControllerProtocol? = nil, detailData: Hero?) {
        self.detailDelegate = detailDelegate
        self.detailData = detailData
    }
    
    
    
    private func loadData(){
        detailDelegate?.updateView(data: detailData)
        
    }
}

//MARK: - Extension -

extension DetailViewModel: DetailViewModelProtocol {
    func viewLoaded() {
        loadData()
    }
}
