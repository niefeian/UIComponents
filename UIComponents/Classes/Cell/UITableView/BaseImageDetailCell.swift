//
//  BaseImageDetailCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/5/22.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit
public class BaseImageDetailCell: CusTableViewCell {

    public var centerImage = UIImageView()
    public override func initializePage() {
        self.addSubview(centerImage)
    }
    
    public override func initLayoutSubviews() {
        centerImage.contentMode = .scaleAspectFill
        centerImage.clipsToBounds = true
        centerImage.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.bottom.equalTo(0)
                make.top.equalTo(0)
                make.height.equalTo(0)
        }
    }

    public func updateLayoutSubviews(_ edgeInsets : UIEdgeInsets , _ height : CGFloat) {
            centerImage.snp.updateConstraints { (make) in
                make.left.equalTo(edgeInsets.left)
                make.right.equalTo(edgeInsets.right)
                make.bottom.equalTo(edgeInsets.bottom)
                make.top.equalTo(edgeInsets.top)
                make.height.equalTo(height)
        }
    }
    
    public func updateLayoutSubviews(_ edgeInsets : UIEdgeInsets , size : CGSize) {
            centerImage.snp.updateConstraints { (make) in
                make.centerX.equalToSuperview()
                make.bottom.equalTo(edgeInsets.bottom)
                make.top.equalTo(edgeInsets.top)
                make.size.equalTo(size)
        }
    }
    
   public  func setAutoImage(_ name : String , imagewidth : CGFloat , top : CGFloat , bottom : CGFloat ){
        if let image = UIImage.init(named: name){
            centerImage.image = image
            centerImage.snp.updateConstraints { (make) in
                make.left.equalTo((AppWidth-imagewidth)/2)
                make.right.equalTo(-(AppWidth-imagewidth)/2)
                make.bottom.equalTo(bottom)
                make.top.equalTo(top)
                make.height.equalTo(imagewidth * image.size.height / image.size.width)
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



}
