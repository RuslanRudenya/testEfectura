//
//  HistoryDataViewController.swift
//  TestEfectura
//
//  Created by Руслан on 06.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import UIKit

class HistoryDataViewController: UIViewController {

    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    var timeStr: String = ""
    var temperatureStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLbl.text = timeStr
        temperatureLbl.text = temperatureStr

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
