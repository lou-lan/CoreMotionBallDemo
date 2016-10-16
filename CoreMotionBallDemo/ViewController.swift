//
//  ViewController.swift
//  CoreMotionBallDemo
//
//  Created by 翟怀楼 on 2016/10/16.
//  Copyright © 2016年 loulan. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var ball:UIImageView!
    var speedX:UIAccelerationValue=0
    var speedY:UIAccelerationValue=0
    
    let motionManager = CMMotionManager()
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 加载一个小球
        ball=UIImageView(image:UIImage(named:"ball"))
        ball.frame=CGRect(x: 0, y: 0, width: 50, height: 50)
        ball.center=self.view.center
        self.view.addSubview(ball)
        
        motionManager.accelerometerUpdateInterval = 1/60
        
        if(motionManager.isAccelerometerAvailable)
        {
            let queue = OperationQueue.current
            motionManager.startAccelerometerUpdates(to: queue!, withHandler: { (accelerometerData, error) in
                
                //动态设置小球位置
                self.speedX += accelerometerData!.acceleration.x
                self.speedY +=  accelerometerData!.acceleration.y
                var posX=self.ball.center.x + CGFloat(self.speedX)
                var posY=self.ball.center.y - CGFloat(self.speedY)
                //碰到边框后的反弹处理
                if posX<0 {
                    posX=0;
                    //碰到左边的边框后以0.4倍的速度反弹
                    //self.speedX *= -0.4
                    self.speedY=0
                    
                }else if posX > self.view.bounds.size.width {
                    posX=self.view.bounds.size.width
                    //碰到右边的边框后以0.4倍的速度反弹
                    //self.speedX *= -0.4
                    self.speedX=0
                }
                if posY<0 {
                    posY=0
                    //碰到上面的边框不反弹
                    self.speedY=0
                } else if posY>self.view.bounds.size.height{
                    posY=self.view.bounds.size.height
                    //碰到下面的边框以1.5倍的速度反弹
                    //self.speedY *= -1.5
                    self.speedY=0
                }
                self.ball.center=CGPoint(x: posX, y: posY)
                
                
            })
        }
        
        // motionManager.startAccelerometerUpdates()
        // motionManager.startGyroUpdates()
        // motionManager.startMagnetometerUpdates()
        // motionManager.startDeviceMotionUpdates()
        
        // timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    func update() {
        if let 加速度 = motionManager.accelerometerData {
            print("加速度")
            print(加速度)
        }
        if let 陀螺仪 = motionManager.gyroData {
            print("陀螺仪")
            print(陀螺仪)
        }
        if let 磁力仪 = motionManager.magnetometerData {
            print(磁力仪)
        }
        if let deviceMotion = motionManager.deviceMotion {
            print(deviceMotion)
        }
    }
    
}
