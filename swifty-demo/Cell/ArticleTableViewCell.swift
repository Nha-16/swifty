//
//  ArticleTableViewCell.swift
//  swifty-demo
//
//  Created by Mavin on 10/11/21.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(article: Article){
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
        self.dateLabel.text = article.createdAt.ReadableDate()
        
        let url = URL(string: article.imageUrl)
        
        let defaultImage = UIImage(systemName: "camera.fill")
        
        self.articleImageView.kf.setImage(with: url,placeholder: defaultImage, options: [.transition(.fade(0.25))])
        
    }

   

}
