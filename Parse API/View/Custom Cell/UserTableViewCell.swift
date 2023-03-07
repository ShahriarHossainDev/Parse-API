//
//  UserTableViewCell.swift
//  Parse API
//
//  Created by Shishir_Mac on 7/3/23.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userPicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentsView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        nameLabel.text = nil
        emailLabel.text = nil
        
        contentsView.layer.cornerRadius = 5
        contentsView.dropShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with model: UserViewModel) {
        guard let url = URL(string: model.avatarURL) else { return }
        userPicImageView.sd_setImage(with: url, completed: nil)
        nameLabel.text = "\(model.firstName) \(model.lastName)"
        emailLabel.text = model.email
    }
}
