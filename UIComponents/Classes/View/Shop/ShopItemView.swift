//
//  ShopItemView.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/6/8.
//

import UIKit
import NFAToolkit
import SwiftProjects
import ProThirdpart
import SnapKit

public class ShopItemView: UIView {
    
    var mpic = UIImageView()
    var mname = UILabel()
    var mprice = UILabel()
    var buy_price = UILabel()
    
    var commission = UILabel()
    var commissionBg = UIImageView()
    
    var coupon_dec = UILabel()
    var coupon_decBg = UIImageView()
    var msvolume = UILabel()
    
    public var cb : CB!
    
    var btn = UIButton()
    // rect.width + 95
    public func buildUI(_ rect : CGRect)
    {
        mpic.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.width)
        self.addSubview(mpic)
        
        mname.frame = CGRect(x: 10.pd6sW, y: rect.width + 12.pd6sW, width: rect.width - 20.pd6sW, height: 34.pd6sW)
        self.addSubview(mname)
        
        
        mprice.frame = CGRect(x: 10.pd6sW, y: rect.width + 60.pd6sW, width: 80.pd6sW, height: 15.pd6sW)
        self.addSubview(mprice)
        
        buy_price.frame = CGRect(x: 10.pd6sW, y: rect.width + 85.pd6sW, width: 100.pd6sW, height: 15.pd6sW)
        self.addSubview(buy_price)
        
        mpic.contentMode = .scaleAspectFill
        mname.numberOfLines = 2
        
        
        
        self.addSubview(commissionBg)
        self.addSubview(commission)
        
        
        commissionBg.image = UIImage.init(named: "1_top_bg")
        commission.snp.makeConstraints { (make) in
            make.centerY.equalTo(mprice)
            make.right.equalToSuperview().offset(-10.pd6sW)
            make.size.equalTo(CGSize(width: 40.pd6sW, height: 17.pd6sW))
        }
        
        commissionBg.snp.makeConstraints { (make) in
            make.center.equalTo(commission)
            make.size.equalTo(commission)
        }
        
        
       
        
        self.addSubview(coupon_decBg)
        self.addSubview(coupon_dec)
        
        
        coupon_decBg.snp.makeConstraints { (make) in
          make.center.equalTo(coupon_dec)
          make.size.equalTo(coupon_dec)
        }
        coupon_decBg.image = UIImage.init(named: "1_youhuiquan")
        coupon_dec.snp.makeConstraints { (make) in
          make.centerY.equalTo(mprice)
            make.right.equalTo(commission.snp_left).offset(-3)
              make.size.equalTo(CGSize(width: 40.pd6sW, height: 17.pd6sW))
        }
        
        self.addSubview(msvolume)
        msvolume.snp.makeConstraints { (make) in
            make.centerY.equalTo(buy_price)
            make.right.equalToSuperview().offset(-10.pd6sW)
        }
        
        coupon_dec.textColor = .white
        commission.textColor = .white
        
        commission.setFont(11)
        coupon_dec.setFont(11)
        
        coupon_dec.textAlignment = .center
        commission.textAlignment = .center
        commission.minimumScaleFactor = 0.5
        commission.adjustsFontSizeToFitWidth = true
        coupon_dec.minimumScaleFactor = 0.5
        coupon_dec.adjustsFontSizeToFitWidth = true
               
        
        self.msvolume.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6,alpha:1)
        msvolume.setFont(11)
        
         commissionBg.contentMode = .redraw
         coupon_decBg.contentMode = .redraw
        
        self.addSubview(btn)
        btn.snp.makeConstraints { (make) in
           make.center.equalToSuperview()
           make.size.equalToSuperview()
        }
        btn.addTarget(self, action: Selector(("toD")), for: .touchUpInside)
        mpic.clipsToBounds = true
    }
    
    @objc func toD(){
       cb?()
    }
    
    public func setMpicUrl(_ url : String , defaultIcon : String){
        mpic.setImageFromURL(url , defaultIcon : defaultIcon)
    }
    
    public func setMname(_ text : String , ofSize : CGFloat = 13.pd6sW ){
        mname.text = text
        mname.font = UIFont.systemFont(ofSize: ofSize)
//        mname.textColor = UIColor.string
    }
    
     public func setMprice(_ text : String  ){
          mprice.setAttrStringBy(string: text , arrayFont : [],arrays:[(text, UIFont.getStrikethroughFont(11.pd6sW, foregroundColor: UIColor(red: 0.6, green: 0.6, blue: 0.6,alpha:1), strikethroughColor: UIColor(red: 0.6, green: 0.6, blue: 0.6,alpha:1)))])
    }
    
    public func setBuy_price(_ text : String  ){
        buy_price.font = UIFont.systemFont(ofSize: 11.pd6sW)
        buy_price.textColor = UIColor(red: 1, green: 0.07, blue: 0.34,alpha:1)
        buy_price.setAttrStringBy(string: "到手价¥" + text , arrayFont : [(text,UIColor(red: 1, green: 0.07, blue: 0.34,alpha:1),UIFont.boldSystemFont(ofSize: 15.pd6sW))],arrays:[])
       }
    
    
    public func setCoupon_dec(_ coupon_dec : String  ,  commission : String , msvolume : String){
        self.coupon_dec.text = coupon_dec
        self.commission.text = commission
        self.msvolume.text = msvolume
        self.msvolume.isHidden = msvolume.count == 0
        coupon_decBg.isHidden = coupon_dec.count == 0
        commissionBg.isHidden = commission.count == 0
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
