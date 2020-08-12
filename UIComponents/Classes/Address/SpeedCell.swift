//
//  SpeedCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/5/3.
//

import UIKit
import SwiftProjects
import NFAToolkit
import SnapKit

public class SpeedCell: CusAutoTableViewCell {

    public var speeds : [String] = [String](){
        didSet{
            reloadUI()
        }
    }
    
    
    var lastLableBttom : Constraint!
    func reloadUI(){
        initializePage()
    }
    
    override public func initializePage() {
        if speeds.count > 0 {
            addAutoView([(.view, speeds.count * 2 - 1),(.label ,  speeds.count)])
            super.initializePage()
            initLayoutSubviews()
        }
    }
    
    override public func initLayoutSubviews() {
        if speeds.count == 0 {
            return
        }
        for i in 0 ... speeds.count{
            if let label = getSubview(autoViewClass: .label, index: i + 1) as? UILabel{
                label.text = speeds[i]
                label.numberOfLines = 0
                if i == 0 {
                    label.snp.makeConstraints({ (make) in
                        make.top.equalTo(20)
                        make.left.equalTo(40)
                        make.right.equalTo(-20)
//                        make.height.equalTo(20)
                    })
                }else if i == speeds.count - 1 {
                    lastLableBttom?.uninstall()
                    label.snp.makeConstraints({ (make) in
                        make.top.equalTo(getSubview(autoViewClass: .label, index: i)?.snp.bottom ?? 0).offset(20)
                        make.left.equalTo(40)
                         make.right.equalTo(-20)
//                        make.height.equalTo(20)
                        lastLableBttom = make.bottom.equalTo(-20).constraint
                    })
                }
                
                if  let subView = getSubview(autoViewClass: .view, index: (i+1)*2 - 1){
                    subView.snp.makeConstraints({ (make) in
                           make.centerY.equalTo(label)
                           make.left.equalTo(15)
                           make.size.equalTo(10)
                    })
                   let subView2 = getSubview(autoViewClass: .view, index: (i+1)*2)
                   subView2?.snp.makeConstraints({ (make) in
                        make.top.equalTo(subView.snp.bottom)
                        make.centerX.equalTo(subView)
                        make.width.equalTo(3)
                        make.height.equalTo(label.snp.height).offset(15)
                   })
                    subView.backgroundColor = .initString("FF7F00")
                    subView2?.backgroundColor = .initString("FF7F00")
                    Tools.setCornerRadius(subView, rate: 5)
                }
               
            }
//            if let subView = getSubview(autoViewClass: .view, index: (i+1)*2 - 1) , let subView2 = getSubview(autoViewClass: .view, index: (i+1)*2){
//                 subView.backgroundColor = .initString("FF7F00")
//                 subView2.backgroundColor = .initString("FF7F00")
//                 if i == 0 {
//                     subView.snp.makeConstraints({ (make) in
//                         make.top.equalTo(15)
//                         make.left.equalTo(15)
//                         make.size.equalTo(10)
//                     })
//                 }else if let topView = getSubview(autoViewClass: .view, index: (i)*2){
//                     subView.snp.makeConstraints({ (make) in
//                        make.top.equalTo(topView.snp.bottom)
//                         make.left.equalTo(15)
//                         make.size.equalTo(10)
//                     })
//                 }
//
//
//                 subView2.snp.makeConstraints({ (make) in
//                     make.top.equalTo(subView.snp.bottom)
//                     make.left.equalTo(15)
//                     make.width.equalTo(2)
//                        make.height.equalTo(20)
//                 })
//                 Tools.setCornerRadius(subView, rate: 5)
//            }else if  let subView = getSubview(autoViewClass: .view, index: i+1) ,  let topView = getSubview(autoViewClass: .view, index: (i)*2 + 1){
//                    subView.snp.makeConstraints({ (make) in
//                        make.top.equalTo(topView.snp.bottom)
//                        make.left.equalTo(15)
//                        make.size.equalTo(10)
//                    })
//            }
        }
    }

}
