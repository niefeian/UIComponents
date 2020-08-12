//
//  GoodsItemView.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/6/17.
//

import UIKit
import SnapKit
import NFAToolkit

public class GoodsItemView: BaseView {
    
    public var spacing : CGFloat = 0
    public var cb : CB!
    
    open var scrollDirection: UICollectionView.ScrollDirection!{
        didSet{
            if scrollDirection != nil
            {
                updateDirection()
            }
        }
    } // default is
    
    override public func initializePage() {
        addAutoView([(.imageView, 1),(.label, 3),(.button, 1)])
        super.initializePage()
    }
    
    func updateDirection(){
        switch scrollDirection
        {
        case .horizontal:
            updateHorizontal()
        case .vertical:
            updateVertical()
        default:
            break
        }
        
    }
    
    //竖
    func updateVertical() {
       
        getSubImageView(index: 1)?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(0)
        })
        
        
        getSubLabelView(index: 1)?.snp.makeConstraints({ (make) in
            make.left.equalTo(10.pd6sW)
            make.centerX.equalToSuperview()
            make.top.equalTo(getSubImageView(index: 1)!.snp_bottom).offset(spacing)
        })
        
        
        getSubLabelView(index: 2)?.snp.makeConstraints({ (make) in
            make.left.equalTo(10.pd6sW)
            make.centerX.equalToSuperview()
            make.top.equalTo(getSubLabelView(index: 1)!.snp_bottom).offset(spacing)
        })
        
        getSubLabelView(index: 3)?.snp.makeConstraints({ (make) in
            make.left.equalTo(10.pd6sW)
            make.centerX.equalToSuperview()
            make.top.equalTo(getSubLabelView(index: 2)!.snp_bottom).offset(spacing)
            make.bottom.equalTo(-10.pd6sW)
        })
        
        getSubview(autoViewClass: .button, index: 1)?.snp.makeConstraints({ (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        })
        
        
    }
    
    public override func initializeDraw() {
        if let button =  getSubview(autoViewClass: .button, index: 1) as? UIButton {
            button.addTarget(self, action: Selector(("toD")), for: .touchUpInside)
        }
        getSubImageView(index: 1)?.clipsToBounds = true
        getSubImageView(index: 1)?.contentMode = .scaleAspectFill
    }
    
    @objc func toD(){
        cb?()
    }
    
    //横
    func updateHorizontal() {
           
    }
    
    public func setMpicUrl(_ url : String , defaultIcon : String){
        getSubImageView(index: 1)?.setImageFromURL(url , defaultIcon : defaultIcon)
    }

    public func setMname(_ text : String , ofSize : CGFloat = 13.pd6sW ){
        getSubLabelView(index: 1)?.text = text
        getSubLabelView(index: 1)?.font = UIFont.systemFont(ofSize: ofSize)
        getSubLabelView(index: 1)?.numberOfLines = 2
    }

    public func setMprice(_ text : String  ){
       getSubLabelView(index: 2)?.setAttrStringBy(string: text , arrayFont : [],arrays:[(text, UIFont.getStrikethroughFont(11.pd6sW, foregroundColor: UIColor(red: 0.6, green: 0.6, blue: 0.6,alpha:1), strikethroughColor: UIColor(red: 0.6, green: 0.6, blue: 0.6,alpha:1)))])
    }

    public func setBuy_price(_ text : String  ){
        getSubLabelView(index: 3)?.font = UIFont.systemFont(ofSize: 10.pd6sW)
        getSubLabelView(index: 3)?.textColor = UIColor(red: 1, green: 0.07, blue: 0.34,alpha:1)
        getSubLabelView(index: 3)?.setAttrStringBy(string: "到手价¥" + text , arrayFont : [(text,UIColor(red: 1, green: 0.07, blue: 0.34,alpha:1),UIFont.boldSystemFont(ofSize: 14.pd6sW))],arrays:[])
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
