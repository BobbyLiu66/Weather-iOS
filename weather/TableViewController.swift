//
//  TableViewController.swift
//  weather
//
//  Created by Liu bo on 28/09/18.
//  Copyright © 2018 Liu bo. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentWeather : [WeatherData] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let queryData = QueryData()
        
        queryData.executeMultiTask(completion: { hourly, currently, daily in
            hourly?.forEach({ print($0.weatherDetails) })
            
            currently?.forEach({ print($0.weatherDetails) })
        })
        
//        queryData.getWeatherData(queryInfo: queryType.hourly) { results in
//            if let results as? [CurrentWeather] = results {
//
//                self.currentWeather = results
//
//                self.weatherCondition.text = results.first?.weatherDescription
//
//                self.degree.text = results.first?.weatherTemp.toString()
//
//                self.weatherCondition.text = results.first?.weatherDescription
//
//                self.weatherTableView.reloadData()
//            }
//
//        }
    }
    
    
    @IBOutlet weak var weatherTableView: UITableView!{
        didSet{
            weatherTableView.dataSource = self
            weatherTableView.delegate = self
        }
    }
    
    @IBOutlet weak var cityName: UILabel!{
        didSet{
            self.title = "--"
        }
    }
    
    @IBOutlet weak var weatherCondition: UILabel!{
        didSet{
            self.title = "----"
        }
    }
    
    @IBOutlet weak var degree: UILabel!{
        didSet{
            self.title = "--°C"
        }
    }


    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentWeatherTableViewCell", for: indexPath) as? CurrentWeatherTableViewCell else {
                fatalError("The dequeued cell is not an instance of CurrentWeatherTableViewCell.")
            }
            
            cell.today.text = Date().dayOfWeek()!
//            cell.highestTemp.text = currentWeather.first?.tempHighest.toString()
//            cell.lowestTemp.text = currentWeather.first?.tempLowest.toString()
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailWeatherTableViewCell", for: indexPath) as? DetailWeatherTableViewCell else {
                fatalError("The dequeued cell is not an instance of DetailWeatherTableViewCell.")
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat
        if indexPath.row == 1 {
            height = 120.0
        } else{
            height = 50.0
        }
        return height
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Double {
    func toString() -> String {
        return String(format: "%.0f",self)
    }
}

extension Int {
    func toString() -> String {
        return String(format: "%.0f", self)
    }
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}
