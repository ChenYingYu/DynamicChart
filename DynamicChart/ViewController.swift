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
    @IBOutlet weak var blueButtonUp: UIButton!
    @IBOutlet weak var blueButtonLeft: UIButton!
    @IBOutlet weak var blueButtonRight: UIButton!
    @IBOutlet weak var blueButtonDown: UIButton!
    @IBOutlet weak var yellowButtonUp: UIButton!
    @IBOutlet weak var yellowButtonLeft: UIButton!
    @IBOutlet weak var yellowButtonRight: UIButton!
    @IBOutlet weak var yellowButtonDown: UIButton!
    @IBOutlet weak var colorControl: UISegmentedControl!
    @IBAction func colorChanged(_ sender: UISegmentedControl) {
        switch colorControl.selectedSegmentIndex {
        case 0:
            colorControl.tintColor = UIColor.blue
            chartView.controlBlue = true
            chartView.controlYellow = false
            break
        case 1:
            colorControl.tintColor = UIColor.yellow
            chartView.controlBlue = false
            chartView.controlYellow = true
            break
        default:
            break
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender {
        case blueButtonUp:
            chartView.blueYRatio += 0.1
            break
        case blueButtonDown:
            chartView.blueYRatio -= 0.1
            break
        case blueButtonLeft:
            chartView.blueXRatio -= 0.1
            break
        case blueButtonRight:
            chartView.blueXRatio += 0.1
            break
        case yellowButtonUp:
            chartView.yellowYRatio += 0.1
            break
        case yellowButtonDown:
            chartView.yellowYRatio -= 0.1
            break
        case yellowButtonLeft:
            chartView.yellowXRatio -= 0.1
            break
        case yellowButtonRight:
            chartView.yellowXRatio += 0.1
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
        
        chartView.setUp()
        chartView.initGestureRecognizers()
        chartView.drawChart()
    }
}

