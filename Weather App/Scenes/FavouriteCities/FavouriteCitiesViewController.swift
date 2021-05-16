//
//  FavouriteCitiesViewController.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import UIKit

class FavouriteCitiesViewController: UIViewController {

    //MARK: Properties
    //IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!

    //Others
    var viewModel: FavouriteCitiesViewModel!
    var delegate : SelectCityDelegate?
    
    //MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInterface()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil, completion: { [weak self]
            _ in
            guard let self = self else { return }
            self.collectionView.collectionViewLayout.invalidateLayout()
            
        })
    }
    
    //MARK: Initial setup
    private func setupInterface() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: CityCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CityCell.id)
    }
    
    
}

//MARK: UICollectionViewDataSource
extension FavouriteCitiesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.id, for: indexPath) as? CityCell else {
            fatalError()
        }
        let city = viewModel.cities[indexPath.row]
        cell.set(city: city)
        return cell
    }
}

//MARK: UICollectionViewDelegate
extension FavouriteCitiesViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        return CGSize(width: totalWidth, height: CityCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let city = viewModel.cities[indexPath.row]
        delegate?.citySelected(name: city.name!)
        self.navigationController?.popViewController(animated: true)
    }
}
