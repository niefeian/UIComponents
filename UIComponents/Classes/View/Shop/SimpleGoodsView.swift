//
//  SimpleGoodsView.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/4/28.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit
import ProThirdpart

public enum GoodsStatus {
    case 中文原价 , ￥原价 , 无价格
}

open class SimpleGoodsView: CustomView {

    public let image = UIImageView()
    public let goodsName = UILabel()
    public let priceLabel = UILabel()
    
    public var nameFont : CGFloat = 15
    public var priceFont : CGFloat = 14
    public var oldPriceFont : CGFloat = 10
    public var spacing : CGFloat = 2
    
    public var nameColor : UIColor = UIColor.black
    public var priceColort : UIColor = UIColor.red
    public var oldPriceColor : UIColor = UIColor.initString("666666")
    public var strikethroughColor : UIColor = UIColor.initString("666666")
    private var btn : UIButton!
   
    override public func initializePage() {
        goodsName.numberOfLines = 1
        priceLabel.numberOfLines = 1
        self.addSubview(image)
        self.addSubview(goodsName)
        self.addSubview(priceLabel)
          
    }
    
    override public func initLayoutSubviews() {
        
        priceLabel.snp.makeConstraints{ (make) in
           make.left.equalTo(10)
           make.right.equalTo(-10)
           make.bottom.equalTo(-5)
        }
        
        goodsName.snp.makeConstraints{ (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(priceLabel.snp.top).offset(-spacing)
        }
        
        image.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.top.equalTo(10)
            make.bottom.equalTo(goodsName.snp.top).offset(-spacing*2)
        }
        
    }
    
    public var touchUpInsideBlock : CB!{
        didSet{
            if btn == nil {
            btn = UIButton()
            self.addSubview(btn)
            btn.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
                make.center.equalToSuperview()
            }

            btn.addTarget(self, action: Selector(("touchUpInside")), for: UIControl.Event.touchUpInside)

            }
        }
    }
    @objc func touchUpInside(){
        touchUpInsideBlock?()
    }
    
    public func setTxtfont(){
        goodsName.numberOfLines = 2
        goodsName.font = UIFont.systemFont(ofSize: nameFont)
        priceLabel.font = UIFont.systemFont(ofSize: priceFont)
//        priceLabel.font = UIFont.systemFont(ofSize: <#T##CGFloat#>)
    }
    
    public func setGoods(_ imageUrl : String , name : String , price : String , oldPrice : String = "" , type : GoodsStatus){
        image.setImageFromURL(imageUrl)
//        goodsName.text = name
        goodsName.setAttrString(string: name,lineSpacing: spacing, array: [])
        priceLabel.text = price
        goodsName.textColor = nameColor
        var rep = ""
        switch type {
        case .中文原价:
            rep = " 原价:"
        case .￥原价:
            rep = "￥"
            case .无价格:
            rep = ""
        }
        if type != .无价格 {
            let str = "￥\(price) \(rep)\(oldPrice)".replacingOccurrences(of: ".00", with: "元")
            priceLabel.setAttrStringBy(string: str,lineSpacing: spacing , arrayFont : [("￥",priceColort,UIFont.boldSystemFont(ofSize: priceFont)),(price.replacingOccurrences(of: ".00", with: "元"),priceColort,UIFont.boldSystemFont(ofSize: priceFont))],arrays:[("\(rep)\(oldPrice)".replacingOccurrences(of: ".00", with: "元"), UIFont.getStrikethroughFont(oldPriceFont, foregroundColor: oldPriceColor, strikethroughColor: strikethroughColor))])
        }
      
    }

    
}
