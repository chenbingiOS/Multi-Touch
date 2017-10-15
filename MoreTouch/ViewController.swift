//
//  ViewController.swift
//  MoreTouch
//
//  Created by 陈冰 on 2017/10/13.
//  Copyright © 2017年 GLAC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    var lastDistance = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 需要开启支持多点触控
        self.view.isMultipleTouchEnabled = true
    }

    // 1.touchesBegin 触摸开始，一根或者多根手指点到屏幕
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("触摸开始 手指根数\(touches.count)")
    }
    
    // 2.touchesMoved 触摸移动，一根或者多根手指在屏幕上移动
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        /** 
        // 显示一些触摸信息
         
        print("触摸移动 手指根数\(touches.count)")

        let p2 = touches.first!.location(in: self.view)
        print("第一个手指触摸点\(p2)");
        
        // 显示所有触摸点坐标
        for touch: UITouch in touches {
            print(touch.location(in: self.view))
        }
         **/
        
        // 图片缩放功能, 当两根手指头，捏合或放大的时候
        if touches.count == 2 {
            
            let touchesAry = Array(touches) // 将集合转数组
            let p1 = touchesAry.first!.location(in: self.view)
            let p2 = touchesAry.last!.location(in: self.view)
            let xx = p1.x - p2.x
            let yy = p1.y - p2.y
            let currentDistance = Double(sqrt(xx*xx + yy*yy)) // 勾股定理,
            
            if lastDistance == 0.0 {
                lastDistance = currentDistance   // 记录原始手指触摸位置
            } else {
                if lastDistance - currentDistance > 5 {
                    print("缩小")
                    lastDistance = currentDistance  // 每变化5个点，改变一下原始手指触摸位置，计算保证
                    imgView.transform = imgView.transform.scaledBy(x: 0.9, y: 0.9) // 缩小
                } else if lastDistance - currentDistance < -5 {
                    print("放大")
                    lastDistance = currentDistance  // 每变化5个点，改变一下原始手指触摸位置，计算保证
                    imgView.transform = imgView.transform.scaledBy(x: 1.1, y: 1.1) // 放大
                }
            }
        }
    }
    
    // 3.touchesEnded 触摸结束，一根手指离开屏幕或多根手指同时离开
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("触摸结束 手指根数\(touches.count)")
    }
    
    // 4.touchesCancelled 被系统事件取消（low-memory）
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("触摸被取消了")
    }
    
    /// 5.touchesEstimatedPropertiesUpdated iOS 9.1 新增API
    ///
    /// 3D Touch相关方法,当前触摸对象触摸时力量改变所触发的事件
    ///
    /// - Parameter touches: 触摸对象集合
    override func touchesEstimatedPropertiesUpdated(_ touches: Set<UITouch>) {
        
    }
}

