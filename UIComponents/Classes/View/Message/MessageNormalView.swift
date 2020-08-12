//
//  MessageNormalView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/17.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit
public class MessageNormalView: BaseView {

    override public func initializePage() {
        addAutoView([(.label, 3)])
        super.initializePage()
    }
        
    override public func initLayoutSubviews() {
        
        getSubLabelView(index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalTo(15.pd6sW)
            make.left.equalTo(10.pd6sW)
            make.right.equalTo(-120.pd6sW)
        })
        
        getSubLabelView(index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubLabelView(index: 1)!.snp_bottom).offset(9.pd6sW)
               make.left.equalTo(getSubLabelView(index: 1)!)
               make.right.equalTo(-10)
             make.bottom.equalTo(-10.pd6sW)
        })
        
        getSubLabelView(index: 3)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubLabelView(index: 1)!)
            make.right.equalTo(-10.pd6sW)
        })
    }
        
        

}
