//
//  detailWeatherTableViewCell.swift
//  weather
//
//  Created by Liu bo on 30/09/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class HourlyForecastTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var hourlyWeatherData: [HourlyWeatherDataDetails] = []
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hourlyWeatherData.count
    }
    
    
    //MARK :- collection cell display hourly forecast information
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HourlyDetailCollectionViewCell", for: indexPath) as! HourlyDetailCollectionViewCell
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.temperature.text = hourlyWeatherData[indexPath.row].temperature.toString() + "°"
        
        cell.hour.text = String(Calendar.current.component(.hour, from: hourlyWeatherData[indexPath.row].localTime))
        cell.weatherIcon.image = UIImage(named: hourlyWeatherData[indexPath.row].weatherIcon)
        return cell
    }
    
    @IBOutlet weak var hourlyWeatherCollectionView: UICollectionView!
}
