//
//  detailWeatherTableViewCell.swift
//  weather
//
//  Created by Liu bo on 30/09/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class HourlyWeatherTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var hourlyWeatherData: [HourlyWeatherDataDetails] = []
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyDetailCollectionViewCell", for: indexPath) as? HourlyDetailCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of TodayDetailCollectionViewCell.")
        }
        cell.temperature.text = hourlyWeatherData[indexPath.row].temperature.toString() + "°"
//        print(Calendar.current.component(.hour, from: hourlyWeatherData[indexPath.row].localTime))
        cell.hour.text = String(Calendar.current.component(.hour, from: hourlyWeatherData[indexPath.row].localTime))
        return cell
    }
    

    @IBOutlet weak var hourlyWeatherCollectionView: UICollectionView!{
        didSet{
            hourlyWeatherCollectionView.dataSource = self
            hourlyWeatherCollectionView.delegate = self
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
