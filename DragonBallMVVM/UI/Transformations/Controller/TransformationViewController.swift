//
//  TransformationViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 5/10/23.
//

import UIKit

//MARK: - Protocolo -
protocol  TransformationsViewControllerProtocol: AnyObject {
    func showHeroDetail(hero: HeroesAndTransformations)
    func transPrintData()
}

//MARK: - Clase -
class TransformationViewController: UIViewController {

    @IBOutlet weak var transformationCollection: UICollectionView!
    
    var transViewModel: TransformationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transformationCollection.dataSource = self
        transformationCollection.delegate = self

        transformationCollection.register(UINib(nibName: "HeroCollectionViewCell",
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "HeroCell")
        transViewModel?.viewIsLoaded()
    }
}
// MARK: UICollectionViewDataSource
extension TransformationViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return transViewModel?.transformationCount ?? 0
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = transformationCollection.dequeueReusableCell(
            withReuseIdentifier: "HeroCell",
            for: indexPath
        ) as? HeroCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if let data = transViewModel?.transformationData(at: indexPath.row) {
            cell.updateViews(data: data)
        }
            return cell
        
    }
}
// MARK: UICollectionViewDelegate

extension TransformationViewController: UICollectionViewDelegate {
    //TODO: Navegación a detalle transformation
}

//MARK: - Extension -
extension TransformationViewController: TransformationsViewControllerProtocol {
  
    func transPrintData() {
        self.transformationCollection.reloadData()
    }
    
    func showHeroDetail(hero: HeroesAndTransformations) {
        let detail = DetailViewController()
        detail.detailViewModel = DetailViewModel(detailDelegate: detail,
                                                 detailData: hero)
        self.navigationController?.pushViewController(detail,
                                                      animated: true)
    }
}
