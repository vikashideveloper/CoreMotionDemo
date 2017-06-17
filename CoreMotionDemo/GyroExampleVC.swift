//
//  GyroExampleVC.swift
//  CoreMotionDemo
//
//  Created by Vikash Kumar on 17/06/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit

class GyroExampleVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Global.motionManager.gyroUpdateInterval = 1.0/30.0
        self.startGyroUpdates()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Global.motionManager.stopGyroUpdates()
    }

    func startGyroUpdates()  {
        Global.motionManager.startGyroUpdates(to: OperationQueue.main) { (data, error) in
            if let rotate = data?.rotationRate {
                let dx = rotate.x
                let dy = rotate.y
                let dz = rotate.z
                print("Gyro Rotation Info:")
                print("dx: \(dx)")
                print("dy: \(dy)")
                print("dz: \(dz)")

            }
        }
    }
    
}

