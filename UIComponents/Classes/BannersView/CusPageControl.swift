//
//  CusPageControl.swift
//  zibai
//
//  Created by 聂飞安 on 2020/2/20.
//  Copyright © 2020 li. All rights reserved.
//

import UIKit
import NFAToolkit

public class CusPageControl: UIView {

    public var currentPage: Int = 0 {
           didSet {
               if oldValue != currentPage {
                   updateSubViewFrame()
               }
           }
       }
       
       /// 总页数
    public var totalCount: Int = 3 {
           didSet {
               _ = subviews.map { view  in
                   view.removeFromSuperview()
               }
               for _ in 0..<totalCount {
                   let view = UIView()
                   addSubview(view)
               }
               updateSubViewFrame()
           }
       }
       
       /// 普通样式圆角
       public var itemNormalCornerRadius: CGFloat = 0 {
           didSet {
               if oldValue != itemNormalCornerRadius {
                   for (index, view) in subviews.enumerated() {
                       if index != currentPage {
                           view.layer.cornerRadius = itemNormalCornerRadius
                       }
                   }
               }
           }
       }
       
       /// 选中样式圆角
       public var itemCurrentCornerRadius: CGFloat = 0 {
           didSet {
               if oldValue != itemCurrentCornerRadius && currentPage >= 0 && currentPage < subviews.count {
                   subviews[currentPage].layer.cornerRadius = itemCurrentCornerRadius
               }
           }
       }
       
       /// 选中的颜色
      public var itemNormalColor: UIColor = UIColor.initString("c7bdb2") {
           didSet {
               if oldValue != itemNormalColor {
                   for (index, view) in subviews.enumerated() {
                       if index != currentPage {
                           view.backgroundColor = itemNormalColor
                       }
                   }
               }
           }
       }
       
       /// 普通的颜色
       public var itemCurrentColor: UIColor = UIColor.white {
           didSet {
               if oldValue != itemNormalColor && currentPage >= 0 && currentPage < subviews.count {
                   subviews[currentPage].backgroundColor = itemCurrentColor
               }
           }
       }
       
       /// 每个点之间的间隔距离
      public var itemSpace: CGFloat = 10 {  //最小的间距是按照普通u原点和选中原点的大小来比较的取 最大的那个值
           didSet {
               if oldValue != itemSpace {
                   updateSubViewFrame()
               }
           }
       }
       
       /// 普通点的大小
      public var itemNormalSize: CGSize = CGSize(width: 5, height: 5) {
           didSet {
               if oldValue != itemNormalSize {
                   updateSubViewFrame()
               }
           }
       }
       
       /// 选中点的大小
       public var itemCurrentSize: CGSize = CGSize(width: 15, height: 5) {
           didSet {
               if oldValue != itemCurrentSize {
                   updateSubViewFrame()
               }
           }
       }
       
       override public init(frame: CGRect) {
           super.init(frame: frame)
       }
       
       required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
       }
       
       private func updateSubViewFrame() {
           
           let itemWidth = itemNormalSize.width
           
           let floatTotalCount = CGFloat(totalCount)
           
           let oriX = (frame.width - (floatTotalCount * itemWidth + (floatTotalCount - 1) * itemSpace)) / 2
           
           let oriYnormal = (frame.height - itemNormalSize.height) / 2
           
           for (index, view) in subviews.enumerated() {
               view.frame = CGRect(x: oriX + CGFloat(index) * (itemWidth + itemSpace), y: oriYnormal, width: itemNormalSize.width, height: itemNormalSize.height)
               view.backgroundColor = itemNormalColor
                Tools.setCornerRadius(view, rate: view.height/2)
           }
           
           if currentPage >= 0 && currentPage < subviews.count {
               let currentView = subviews[currentPage]
               let currentCenter = currentView.center
               currentView.frame = CGRect(x: 0, y: 0, width: itemCurrentSize.width, height: itemCurrentSize.height)
               currentView.center = currentCenter
               currentView.backgroundColor = itemCurrentColor
                Tools.setCornerRadius(currentView, rate: currentView.height/2)
           }
       }
    
}
