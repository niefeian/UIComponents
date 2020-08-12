//
//  LoadingView.swift
//  cloudclass
//
//  Created by 聂飞安 on 2018/9/20.
//  Copyright © 2018年 accfun. All rights reserved.
//

import UIKit
import NFAToolkit

public class LoadingView: UIImageView {

    static public let sharedInstance = LoadingView()
    public var images = [UIImage]()
    
    
    public func initAnimationImages(){
        if images.count == 0 {
            var images = [UIImage]()
            for i in 0...29 {
                if i < 10 {
                    images.append(UIImage(named: "loading0\(i)")!)
                }else{
                     images.append(UIImage(named: "loading\(i)")!)
                }
            }
            self.animationImages = images
            self.animationDuration = 1
            self.animationRepeatCount = 0
        }
    }
    
  
   public class func showView(_ supView : UIView, centView : UIView?){
        
        sharedInstance.frame = CGRect(x: supView.width/2 - 27, y: AppHeight/2 - 10, width: 54, height: 20)
        if centView != nil {
//            sharedInstance.center = centView!.center
        }
        sharedInstance.removeFromSuperview()
        sharedInstance.initAnimationImages()
        supView.addSubview(sharedInstance)
        sharedInstance.startAnimating()
    }
    
   public class func hideView(){
        if sharedInstance.isAnimating{
            sharedInstance.removeFromSuperview()
            sharedInstance.stopAnimating()
        }
    }
   
    //
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
