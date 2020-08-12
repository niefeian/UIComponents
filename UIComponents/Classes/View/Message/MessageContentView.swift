//
//  MessageContentView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/17.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit
public class MessageContentView: BaseView {

    override public func initializePage() {
        addAutoView([(.imageView, 2),(.label, 3)])
        super.initializePage()
    }
    
    override public func initLayoutSubviews() {
        
        getSubImageView(index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalTo(15.pd6sW)
            make.left.equalTo(10.pd6sW)
            make.height.equalTo(40.pd6sW)
            make.width.equalTo(40.pd6sW)
        })
        
        getSubImageView(index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(15.pd6sW)
            make.right.equalTo(-14.pd6sW)
            make.height.equalTo(60.pd6sW)
            make.width.equalTo(60.pd6sW)
        })
        getSubImageView(index: 1)?.setCornerRadius(20.pd6sW)
        
        getSubLabelView(index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalTo(15.pd6sW)
            make.left.equalTo(getSubImageView(index: 1)!.snp_right).offset(10.pd6sW)
            make.right.equalTo(getSubImageView(index: 2)!.snp_left).offset(-10.pd6sW)
        })
        
        getSubLabelView(index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(getSubLabelView(index: 1)!.snp_bottom).offset(9.pd6sW)
            make.left.equalTo(getSubImageView(index: 1)!.snp_right).offset(10.pd6sW)
            make.right.equalTo(getSubImageView(index: 2)!.snp_left).offset(-10.pd6sW)
        })
        
        getSubLabelView(index: 3)?.snp.makeConstraints({ (make) in
           make.top.equalTo(getSubLabelView(index: 2)!.snp_bottom).offset(9.pd6sW)
              make.left.equalTo(getSubImageView(index: 1)!.snp_right).offset(10.pd6sW)
              make.right.equalTo(getSubImageView(index: 2)!.snp_left).offset(-10.pd6sW)
//              make.height.equalTo(15.pd6sW)
            make.bottom.equalTo(-10.pd6sW)
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
