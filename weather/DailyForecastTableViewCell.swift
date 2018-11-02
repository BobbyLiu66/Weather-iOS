//
//  CurrentWeatherTableViewCell.swift
//  weather
//
//  Created by Liu bo on 30/09/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var today: UILabel!
    
    @IBOutlet weak var highestTemp: UILabel!
    
    @IBOutlet weak var lowestTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
