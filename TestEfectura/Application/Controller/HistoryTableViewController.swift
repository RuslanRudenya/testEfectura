//
//  HistoryTableViewController.swift
//  TestEfectura
//
//  Created by Руслан on 06.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import UIKit
import CoreData

class HistoryTableViewController: UITableViewController {

    var weatherArray = [WeatherData]()
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let reqquestFetch: NSFetchRequest<WeatherData> = WeatherData.fetchRequest()
        
        do {
            weatherArray = try context.fetch(reqquestFetch)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellHistory", for: indexPath)
            cell.textLabel?.text = self.weatherArray[indexPath.row].timeWeather
        return cell
    }
    
    func saveData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "WeatherData", in: context)
        let objectWeather = NSManagedObject(entity: entity!, insertInto: context) as! WeatherData
        
            NetworkService.shared.getData { (response) in
                objectWeather.timeWeather = response.location.localtime
                objectWeather.temperatura = Int16(response.current.temp_c)
                DispatchQueue.global(qos: .background).async {
                    do {
                        try context.save()
                        self.weatherArray.append(objectWeather)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                self.tableView.reloadData()
            }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let historyDataVC = storyBoard.instantiateViewController(withIdentifier: "HistoryDataViewController") as! HistoryDataViewController

        historyDataVC.timeStr = weatherArray[indexPath.row].timeWeather ?? ""
        historyDataVC.temperatureStr = String(weatherArray[indexPath.row].temperatura)
        self.navigationController?.pushViewController(historyDataVC, animated: true)
    }
    


}
