//
//  HomeViewController.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvLabelSection: UILabel!
    @IBOutlet weak var tvImageSection: UIImageView!
    @IBOutlet weak var favoritesLabelSection: UILabel!
    @IBOutlet weak var favoritesImageSection: UIImageView!
    @IBOutlet weak var mainStack: UIStackView!
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }
    
    // MARK: Custom functions
    func setActiveStatusSection(label: UILabel, image: UIImageView, isActive: Bool) {
        if isActive {
            label.textColor = UIColor(.blue)
            image.tintColor = .blue
        } else {
            label.textColor = .lightGray
            image.tintColor = .lightGray
        }
    }
    
    
    @IBAction func onTvSectionAction(_ sender: Any) {
        setActiveStatusSection(label: tvLabelSection, image: tvImageSection, isActive: true)
        setActiveStatusSection(label: favoritesLabelSection, image: favoritesImageSection, isActive: false)
    }
    
    @IBAction func onFavoritesSectionAction(_ sender: Any) {
        setActiveStatusSection(label: tvLabelSection, image: tvImageSection, isActive: false)
        setActiveStatusSection(label: favoritesLabelSection, image: favoritesImageSection, isActive: true)
    }
    
}


extension HomeViewController : HomeViewProtocol{
    // TODO: implement view output methods
    
    func setHeader() {
        let header = HeaderView()
        header.setTitle(title: "TV Shows")
        
        mainStack.insertArrangedSubview(header, at: 0)
        mainStack.layoutIfNeeded()
    }
    
    func registerCells() {
        let nameCell = "ShowTableViewCell"
        let nib = UINib(nibName: nameCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: nameCell)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initView() {
        setActiveStatusSection(label: tvLabelSection, image: tvImageSection, isActive: true)
        footerView.backgroundColor = UIColor(hex: "F9F9F9")
    }
}


extension HomeViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.shows?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameCell = "ShowTableViewCell"
        let shows = presenter?.shows
        let position = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath) as? ShowTableViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        
        cell.initView(title: shows?[position].name, image: shows?[position].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shows = presenter?.shows
        let position = indexPath.row
        let generalAction: UIContextualAction?
        
        if shows?[position].isFavorite ?? false {
            generalAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
                // Perform delete action
                self.presenter?.updateFavorite(position: position, value: false)
                print("Delete Action Tapped")
                completionHandler(true)
            }
            
            generalAction?.backgroundColor = .red
        } else {
            generalAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completionHandler) in
               // Perform delete action
                self.presenter?.updateFavorite(position: position, value: true)
               print("Delete Action Tapped")
               completionHandler(true)
           }
            
            generalAction?.backgroundColor = .green
        }

        return UISwipeActionsConfiguration(actions: [generalAction!])
    }
    
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74.0
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 40, height: 50)
    }
}
