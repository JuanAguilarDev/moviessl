//
//  ShowTableViewCell.swift
//  moviessl
//
//  Created by Juan Aguilar on 06/07/24.
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    @IBOutlet weak var showTitle: UILabel!
    @IBOutlet weak var showImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(title: String?, image: ImageSource?){
        self.showTitle.text = title
        
        let imageAppereance = UIImageView.Appeareance(imageSource: image)
        
        self.showImage.setup(appearance: imageAppereance)
    }

    
}
