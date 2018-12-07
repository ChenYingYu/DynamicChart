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
    @IBOutlet weak var buttonUp: UIButton!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var buttonDown: UIButton!
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case buttonUp:
            chartView.yRatio += 0.1
            break
        case buttonDown:
            chartView.yRatio -= 0.1
            break
        case buttonLeft:
            chartView.xRatio -= 0.1
            break
        case buttonRight:
            chartView.xRatio += 0.1
            break
        default:
            break
        }
        chartView.drawChart()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        chartView.drawChart()
    }
}

