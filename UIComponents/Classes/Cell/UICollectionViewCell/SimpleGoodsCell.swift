//
//  SimpleGoodsCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/4/28.
//

import UIKit
import SwiftProjects
import SnapKit

public class SimpleGoodsCell: CusCollectionViewCell {
    
    public let simpleGoodsView = SimpleGoodsView()
    override public func initializePage() {
        self.addSubview(simpleGoodsView)
    }
    
    override public func initLayoutSubviews() {
        simpleGoodsView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
    }

}
