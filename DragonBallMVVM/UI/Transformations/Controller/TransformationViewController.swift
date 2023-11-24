//
//  TransformationViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 5/10/23.
//

import UIKit

//MARK: - Protocolo -
protocol  TransformationsViewControllerProtocol: AnyObject {
    func transPrintData()
}

//MARK: - Clase -
class TransformationViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var transformationCollection: UICollectionView!
    
    var transViewModel: TransformationViewModel?
    
    //MARK: - Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        transformationCollection.dataSource = self
        transformationCollection.register(UINib(nibName: "HeroCollectionViewCell",
                                            bundle: nil),
                                      forCellWithReuseIdentifier: "HeroCell")
        transViewModel?.viewIsLoading()
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

//MARK: - Extension -
extension TransformationViewController: TransformationsViewControllerProtocol {
    func transPrintData() {
        self.transformationCollection.reloadData()
    }
}
