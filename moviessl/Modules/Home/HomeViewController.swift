//
//  HomeViewController.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//
//

import Foundation
import UIKit
import MaterialComponents

class HomeViewController: BaseViewController {
    
    // MARK: Properties
    var presenter: HomePresenterProtocol?
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvLabelSection: UILabel!
    @IBOutlet weak var tvImageSection: UIImageView!
    @IBOutlet weak var favoritesLabelSection: UILabel!
    @IBOutlet weak var favoritesImageSection: UIImageView!
    @IBOutlet weak var mainStack: UIStackView!
    
    var isFavoriteActive: Bool = false
    
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
        isFavoriteActive = false
        tableView.reloadData()
    }
    
    @IBAction func onFavoritesSectionAction(_ sender: Any) {
        setActiveStatusSection(label: tvLabelSection, image: tvImageSection, isActive: false)
        setActiveStatusSection(label: favoritesLabelSection, image: favoritesImageSection, isActive: true)
        isFavoriteActive = true
        tableView.reloadData()
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
        
        let number = isFavoriteActive ? presenter?.favoriteShows?.count : presenter?.shows?.count
        
        return number ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameCell = "ShowTableViewCell"
        let shows = isFavoriteActive ? presenter?.favoriteShows : presenter?.shows
        let position = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nameCell, for: indexPath) as? ShowTableViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        
        cell.initView(title: shows?[position].name, image: shows?[position].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let shows = isFavoriteActive ? presenter?.favoriteShows : presenter?.shows
        let position = indexPath.row
        let generalAction: UIContextualAction?
        
        if shows?[position].isFavorite ?? false {
            generalAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
                
                let alertController = MDCAlertController(title: "Eliminar favoritos", message: Utils.shared.confirmation)
                
                
                let confirmAction = MDCAlertAction(title: "Confirmar") { (action) in
                    self.presenter?.updateFavorite(position: position, value: false)
                    self.presenter?.removeFavorite(id: shows?[position].id)
                    tableView.reloadData()
                }
                alertController.addAction(confirmAction)
                
                
                let cancelAction = MDCAlertAction(title: "Cancelar", emphasis: .low) { (action) in
                }
                
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
                
                completionHandler(true)
            }
            
            generalAction?.backgroundColor = .red
        } else {
            generalAction = UIContextualAction(style: .normal, title: "Favorite") { (action, view, completionHandler) in
                self.presenter?.updateFavorite(position: position, value: true)
                self.presenter?.addFavorite(favorite: shows?[position])
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shows = presenter?.shows
        var selectedItem = shows?[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: false)
        
        if let selectedItem = shows?[indexPath.row] {
            self.presenter?.goToDetailView(show: selectedItem)
        } else {
            self.presenter?.goToDetailView(show: nil)
        }
        
    }
}
