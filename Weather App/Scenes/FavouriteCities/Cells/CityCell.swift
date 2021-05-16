//
//  CityCell.swift
//  KeepTruckin
//
//  Created by V L S RAVI on 15/04/21.
//

import UIKit

class CityCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
   
    static let cellHeight: CGFloat = 70 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(city: City) {
        nameLabel.text = city.name
        temperatureLabel.text = "\(city.temperature) ℃"
        weatherImage.image = UIImage(named: Utilities.getWeatherIcon(condition: Int(city.condition)))

    }
}
