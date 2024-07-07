//
//  ShowViewCell.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import UIKit

class ShowViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func initView(title: String?, image: String?){
        self.showTitle.text = title
    }

}
