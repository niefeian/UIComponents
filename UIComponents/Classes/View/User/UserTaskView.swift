//
//  UserTaskView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/11.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit
import NFAToolkit

public class UserTaskView: BaseView {

    
    override public func initializePage() {
        addAutoView([(.label, 3),(.view, 2),(.button, 3)])
        super.initializePage()
    }
    
    override public func initLayoutSubviews() {
        getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        })
        
        getSubview(autoViewClass: .label, index: 2)?.snp.makeConstraints({ (make) in
            make.left.equalTo(getSubview(autoViewClass: .label, index: 1)!.snp_right)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(getSubview(autoViewClass: .label, index: 1)!)
        })
        
        getSubview(autoViewClass: .label, index: 3)?.snp.makeConstraints({ (make) in
            make.left.equalTo(getSubview(autoViewClass: .label, index: 2)!.snp_right)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(getSubview(autoViewClass: .label, index: 1)!)
            make.right.equalToSuperview()
        })
        
        getSubview(autoViewClass: .view, index: 1)?.snp.makeConstraints({ (make) in
            make.left.equalTo(getSubview(autoViewClass: .label, index: 1)!.snp_right)
            make.top.equalTo(25.pd6sW)
            make.bottom.equalTo(-25.pd6sW)
            make.width.equalTo(1)
        })
        
        getSubview(autoViewClass: .view, index: 2)?.snp.makeConstraints({ (make) in
          make.left.equalTo(getSubview(autoViewClass: .label, index: 2)!.snp_right)
          make.top.equalTo(25.pd6sW)
          make.bottom.equalTo(-25.pd6sW)
          make.width.equalTo(1)
        })
        
        for i in 1...3{
            getSubview(autoViewClass: .button, index: i)?.snp.makeConstraints({ (make) in make.center.equalTo(getSubview(autoViewClass: .label, index: i)!)
                make.size.equalTo(getSubview(autoViewClass: .label, index: i)!)
            })
        }
    }
    
    override public func initializeDraw() {
        getSubview(autoViewClass: .view, index: 1)?.backgroundColor = .initString("#EEEEEE")
         getSubview(autoViewClass: .view, index: 2)?.backgroundColor = .initString("#EEEEEE")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
