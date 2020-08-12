//
//  BaseView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/11.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import NFAToolkit
import SwiftProjects

open class BaseView: UIView {

    public var subViewsData : [(AutoViewClass , Int)]! = [(AutoViewClass , Int)]()

    public func addAutoView(_ subs :[(AutoViewClass , Int)]){
        subViewsData = subs
    }

    override public init(frame: CGRect) {
       super.init(frame: frame)
       self.initializeView()
    }

    required public init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
       self.initializeView()
    }
   

    open func initializeView(){
        initializePage()
        initLayoutSubviews()
        initializeDelegate()
        initializeDraw()
        initializeData()
    }

    open func initializePage(){
        if subViewsData.count == 0 {
          return
        }
        for viewsData in subViewsData{
            let viewClass = viewsData.0
              for index in 0 ..< viewsData.1 {
                 addSubview(autoViewClass: viewClass, index: index + 1)
              }
        }
    }

    open  func initLayoutSubviews(){


    }

    open  func initializeDelegate(){

    }

    open  func initializeDraw(){

    }

    open  func initializeData(){

    }
      


}
