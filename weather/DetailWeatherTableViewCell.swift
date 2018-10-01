//
//  detailWeatherTableViewCell.swift
//  weather
//
//  Created by Liu bo on 30/09/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class DetailWeatherTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TodayDetailCollectionViewCell", for: indexPath) as? TodayDetailCollectionViewCell else {
            fatalError("The dequeued cell is not an instance of TodayDetailCollectionViewCell.")
        }
        cell.temperature.text = "12"
        cell.hour.text = "Now"
        return cell
    }
    

    @IBOutlet weak var detailWeatherCollectionView: UICollectionView!{
        didSet{
            detailWeatherCollectionView.dataSource = self
            detailWeatherCollectionView.delegate = self
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
