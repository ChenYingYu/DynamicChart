//
//  ViewController.swift
//  DynamicChart
//
//  Created by ChenAlan on 2018/12/6.
//  Copyright © 2018年 ChenAlan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chartView: ChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.drawChart()
    }


}

