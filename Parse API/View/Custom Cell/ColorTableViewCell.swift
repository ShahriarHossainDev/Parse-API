//
//  ColorTableViewCell.swift
//  Parse API
//
//  Created by Shishir_Mac on 10/3/23.
//

import UIKit

class ColorTableViewCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var pantoneValueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        colorNameLabel.text = nil
        pantoneValueLabel.text = nil
        
        colorView.layer.cornerRadius = 5
        colorView.dropShadow()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    public func configure(with model: ColorViewModel) {
        colorView.backgroundColor = UIColor(hex: model.color)
        colorNameLabel.text = "Color Name: \(model.name.capitalized)"
        pantoneValueLabel.text = "Pantone Value: \(model.pantoneValue)"
    }
    
}
