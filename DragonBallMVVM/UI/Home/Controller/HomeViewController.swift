//
//  HomeViewController.swift
//  DragonBallMVVM
//
//  Created by Pablo Márquez Marín on 4/10/23.
//

import UIKit
//MARK: - Protocolo -
protocol HomeViewControllerProtocol: AnyObject {
    func showHeroDetail(hero: HeroesAndTransformations)
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
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let hero = viewModel?.heroData(at: indexPath.row) else { return }
        showHeroDetail(hero: hero )
    }
}


//MARK: - Extension -
extension HomeViewController: HomeViewControllerProtocol {
    func printData() {
        heroesCollection.reloadData()
    }
    
    func showHeroDetail(hero: HeroesAndTransformations) {
        let detail = DetailViewController()
        detail.detailViewModel = DetailViewModel(detailDelegate: detail, 
                                                 detailData: hero)
        self.navigationController?.pushViewController(detail,
                                                      animated: true)
    }
}
