//
//  ViewController.swift
//  CoreMotionDemo
//
//  Created by Vikash Kumar on 17/06/17.
//  Copyright © 2017 Vikash Kumar. All rights reserved.
//

import UIKit
import CoreMotion

class Global {
    static let motionManager = CMMotionManager()
}

class AccelerometerExampleVC: UIViewController {

    @IBOutlet var dropView: UIView!
    
    lazy var dynamicAnimator: UIDynamicAnimator = {
        let da = UIDynamicAnimator(referenceView: self.view)
        return da
    }()
    
    var gravity = UIGravityBehavior()
    var collideBehaviour = UICollisionBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startAccelerometerUpdates()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collideBehaviour.translatesReferenceBoundsIntoBoundary = true

        gravity.addItem(dropView)
        collideBehaviour.addItem(dropView)
        
        dynamicAnimator.addBehavior(collideBehaviour)
        dynamicAnimator.addBehavior(gravity)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Global.motionManager.stopAccelerometerUpdates()
    }
    
    func startAccelerometerUpdates() {
        Global.motionManager.accelerometerUpdateInterval = 1.0/60.0
        
       Global.motionManager.startAccelerometerUpdates(to: OperationQueue.main) { (data, error) in
            if let acceleration = data?.acceleration {
                let dx: CGFloat = CGFloat(acceleration.x)
                var dy: CGFloat = CGFloat(acceleration.y)
                let dz: CGFloat = CGFloat(acceleration.z)
                
                switch UIDevice.current.orientation {
                case .portraitUpsideDown, .portrait:  dy = -dy
                default: break
                }
                self.gravity.gravityDirection = CGVector(dx: dx*2, dy: dy*2)
            }
        }
    }
    
    
}

