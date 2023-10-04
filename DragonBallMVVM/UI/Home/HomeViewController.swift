//
//  HomeViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit
//MARK: - Protocolo -
protocol HomeViewControllerProtocol: AnyObject {
    func showHeroDetail()
    func printData()
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
        
        viewModel?.viewIsLoaded()
        
    }
}
//MARK: - Extension Collection View -
extension HomeViewController: UICollectionViewDelegate, 
                                UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        
        return viewModel?.heroCount ?? 0
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
        
        if let data = viewModel?.heroData(at: indexPath.row) {
            cell.updateViews(data: data)
        }
        return cell
    }
}

//MARK: - Extension Protocol-
extension HomeViewController: HomeViewControllerProtocol {
    
    func printData() {
        heroesCollection.reloadData()
    }
    
    func showHeroDetail() {
        //TODO: navegacion al detalle
    }
}
