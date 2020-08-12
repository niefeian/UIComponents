//
//  UserHeadView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/11.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit
import NFAToolkit

public class UserHeadView: BaseView {

    public var topOffsize : CGFloat = NavigationH-64
    
    override public func initializePage() {
        addAutoView([(.imageView, 2),(.label, 2),(.button, 2)])
        super.initializePage()
    }
    

    override public func initLayoutSubviews() {
        
        getSubview(autoViewClass: .imageView, index: 1)?.snp.makeConstraints({ (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        })
        
        getSubview(autoViewClass: .imageView, index: 2)?.snp.makeConstraints({ (make) in
            make.top.equalTo(topOffsize + 56.pd6sW)
            make.left.equalTo(15.pd6sW)
            make.size.equalTo(62.pd6sW)
        })
        
        getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalTo( getSubview(autoViewClass: .imageView, index: 2)!.snp_top).offset(5.pd6sW)
            make.left.equalTo(getSubview(autoViewClass: .imageView, index: 2)!.snp_right).offset(18.pd6sW)
        })
        
        getSubview(autoViewClass: .label, index: 2)?.snp.makeConstraints({ (make) in
           make.bottom.equalTo( getSubview(autoViewClass: .imageView, index: 2)!).offset(-5.pd6sW)
           make.left.equalTo(getSubview(autoViewClass: .imageView, index: 2)!.snp_right).offset(18.pd6sW)
        })
        
        getSubview(autoViewClass: .button, index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalTo(30.pd6sW)
            make.right.equalTo(-15.pd6sW)
            make.size.equalTo(50.pd6sW)
        })
        
        getSubview(autoViewClass: .button, index: 2)?.snp.makeConstraints({ (make) in
            make.centerY.equalTo(getSubview(autoViewClass: .label, index: 2)!)
            make.left.equalTo(getSubview(autoViewClass: .label, index: 2)!.snp_right).offset(10.pd6sW)
            make.size.equalTo(CGSize(width: 34.pd6sW, height: 18.pd6sW))
        })
    }
    
   
    
}
