//
//  HomeViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit
//MARK: - Protocolo -
protocol HomeViewControllerProtocol {
    func showHeroDetail()
    
}

//MARK: - Clase -
class HomeViewController: UIViewController {

    @IBOutlet weak var heroesCollection: UICollectionView!
    
    var viewModel: HomeViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heroesCollection.dataSource = self
        heroesCollection.delegate = self
        heroesCollection.register(UINib(nibName: "HeroCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeroCell")

    }
}
//MARK: - Extension Collection View -
extension HomeViewController: UICollectionViewDelegate, 
                                UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = heroesCollection.dequeueReusableCell(
            withReuseIdentifier: "HeroCell",
            for: indexPath
        ) as? HeroCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
 
}


//MARK: - Extension Protocol-
extension HomeViewController: HomeViewControllerProtocol {
    func showHeroDetail() {
        
    }
}
