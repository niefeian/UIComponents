//
//  MessageView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/16.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit

public class MessageView: BaseView {

    override public func initializePage() {
        addAutoView([(.imageView, 1),(.label, 3)])
        super.initializePage()

    }
    
    override public func initLayoutSubviews() {
        
        getSubImageView(index: 1)?.snp.makeConstraints({ (make) in
            make.size.equalTo(45.pd6sW)
            make.top.equalTo(16.pd6sW)
            make.left.equalTo(15.pd6sW)
            make.bottom.equalTo(-15.pd6sW)
        })
        
        getSubLabelView(index: 1)?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(getSubImageView(index: 1)!)
            make.left.equalTo(getSubImageView(index: 1)!.snp_right).offset(16.pd6sW)
            make.right.equalTo(-80.pd6sW)
        })
        
        getSubLabelView(index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubLabelView(index: 1)!)
            make.right.equalTo(-5.pd6sW)
        })
        
        getSubLabelView(index: 3)?.snp.makeConstraints({ (make) in
           make.bottom.equalTo(getSubLabelView(index: 1)!)
           make.right.equalTo(-5.pd6sW)
            make.height.equalTo(16.pd6sW)
//            make.width.equalTo(30.pd6sW)
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
