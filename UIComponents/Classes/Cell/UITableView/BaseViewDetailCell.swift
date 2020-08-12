//
//  BaseViewDetailCell.swift
//  AutoModel
//
//  Created by 聂飞安 on 2020/5/9.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit

public class BaseViewDetailCell: CusTableViewCell {

    public var leftLabel = UILabel()
    var leftImage = UIImageView()
    public var rightLabel = UILabel()
    var rightImage = UIImageView()
    public var centerLabel = UILabel()
    public var richLabel = UITextView()
    public var bgView = UIView()
    public var line = UIView()
    var switchBtn = UISwitch()
    
    var leftImageConstraint : Constraint!
    var rightImageConstraint : Constraint!
    
    
    private var leftMargin : Constraint!
    private var rightMargin : Constraint!
    private var topMargin : Constraint!
    private var bottomMargin : Constraint!
    private var heightMargin : Constraint!
    
//      Tools.serCorner(cell.bgView, byRoundingCorners: corners, radii: 3) 会导致视图消失 配合SnapKit的时候，所以自定义一下先
    
    public var  switchBlock : ((Bool) -> Void)!
    
     private var topView : UIView = UIView()
    private var bttomView : UIView = UIView()
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override public func initializePage() {
         addSubview(topView)
         addSubview(bttomView)
        addSubview(bgView)
        setbgViewMargin(edgeInsets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), height: 45.pd6sW)
        bgView.addSubview(leftLabel)
        bgView.addSubview(leftImage)
        bgView.addSubview(rightLabel)
        bgView.addSubview(rightImage)
        bgView.addSubview(centerLabel)
        bgView.addSubview(switchBtn)
        bgView.addSubview(richLabel)
        richLabel.isEditable = false
        richLabel.isHidden = true
        addSubview(line)
        
           
        
    }
    
    override public func initializeDraw(){
        switchBtn.isHidden = true
        switchBtn.addTarget(self, action: Selector(("switchAction:")), for: .touchUpInside)
        rightImage.contentMode = .scaleAspectFit
    }
    
    public func setbgViewMargin(edgeInsets:UIEdgeInsets , height : CGFloat , topColor : UIColor  = UIColor.clear,  bttomColor : UIColor = UIColor.clear){
        leftMargin?.uninstall()
        rightMargin?.uninstall()
        topMargin?.uninstall()
        bottomMargin?.uninstall()
        heightMargin?.uninstall()
        bgView.snp.makeConstraints { (make) in
            leftMargin = make.left.equalTo(edgeInsets.left).constraint
            rightMargin = make.right.equalTo(edgeInsets.right).constraint
            topMargin = make.top.equalTo(edgeInsets.top).constraint
            bottomMargin = make.bottom.equalTo(edgeInsets.bottom).constraint
            heightMargin = make.height.greaterThanOrEqualTo(height).constraint
        }
        topView.backgroundColor = topColor
        bttomView.backgroundColor = bttomColor
    }
    
    public func setHeightMargin( height : CGFloat ){
       heightMargin?.uninstall()
       bgView.snp.makeConstraints { (make) in
           heightMargin = make.height.greaterThanOrEqualTo(height).constraint
       }
    }

    public func seLinetMargin( height : CGFloat  , left  : CGFloat = 0 , bottom  : CGFloat = 0){
       
        line.snp.updateConstraints { (make) in
            make.left.equalTo(left)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(bottom)
            make.height.equalTo(height)
        }
    }
    
    override public func initLayoutSubviews() {
        self.leftImage.snp.makeConstraints { (make) in
            make.left.equalTo(10.pd6sW)
            make.centerY.equalToSuperview()
            leftImageConstraint = make.size.equalTo(0).constraint
        }
        
        leftLabel.snp.makeConstraints { (make) in
            make.left.equalTo(leftImage.snp_right).offset(5)
            make.centerY.equalTo(leftImage.snp_centerY)
            make.centerX.lessThanOrEqualToSuperview()
            make.top.greaterThanOrEqualTo(10)
        }
        
        rightImage.snp.makeConstraints { (make) in
            make.right.equalTo(-10.pd6sW)
            make.centerY.equalToSuperview()
            rightImageConstraint = make.size.equalTo(0).constraint
        }
        
         switchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-10.pd6sW)
            make.centerY.equalToSuperview()
            make.height.equalTo(25.pd6sW)
            make.width.equalTo(50.pd6sW)
        }
        
        
        rightLabel.snp.makeConstraints { (make) in
            make.right.equalTo(rightImage.snp_left).offset(-5)
            make.centerY.equalTo(rightImage.snp_centerY)
        }
        
        centerLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
            make.height.greaterThanOrEqualTo(0.pd6sW)
        }
        
        richLabel.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
//            make.top.equalToSuperview()
//            make.left.greaterThanOrEqualTo(0)
            make.height.greaterThanOrEqualTo(0.pd6sW)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalTo(15.pd6sW)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1.pd6sW)
        }
        
        topView.snp.makeConstraints { (make) in
            make.top.equalTo(bgView)
            make.height.equalTo(20)
            make.left.equalTo(bgView)
            make.right.equalTo(bgView)
        }
        
        bttomView.snp.makeConstraints { (make) in
            make.bottom.equalTo(bgView)
            make.height.equalTo(20)
            make.left.equalTo(bgView)
            make.right.equalTo(bgView)
        }
    }
    public func setRightImageUI( rightImage : String = "" , rightImageWidth : CGFloat = 15.pd6sW)
    {
        if rightImage.count > 0
        {
            self.rightImage.image = UIImage.init(named: rightImage)
            rightImageConstraint.uninstall()
            self.rightImage.snp.makeConstraints { (make) in
                rightImageConstraint = make.size.equalTo(rightImage.count > 0 ? rightImageWidth.pd6sW : 0 ).constraint
            }
        }
    }
  
    public func setUI(leftLabel : String , leftImage : String = "" , rightLabel : String  , rightImage : String = "" , leftImageWidth : CGFloat = 15.pd6sW, rightImageWidth : CGFloat = 15.pd6sW){
        
        leftImageConstraint.uninstall()
        self.leftImage.snp.makeConstraints { (make) in
            leftImageConstraint = make.size.equalTo(leftImage.count > 0 ? leftImageWidth : 0 ).constraint
        }
        rightImageConstraint.uninstall()
        self.rightImage.snp.makeConstraints { (make) in
            rightImageConstraint = make.size.equalTo(rightImage.count > 0 ? rightImageWidth.pd6sW : 0 ).constraint
        }
        
       
        self.leftLabel.text = leftLabel
        self.rightLabel.text = rightLabel
        self.leftLabel.setFont(15)
        self.rightLabel.setFont(15)
        self.leftLabel.isHidden =  false
        self.rightLabel.isHidden =  false
        self.centerLabel.isHidden = true
        if leftImage.count > 0 {
           self.leftImage.image = UIImage.init(named: leftImage)
        }
        self.leftImage.isHidden = leftImage.count == 0
        if rightImage.count > 0 {
          self.rightImage.image = UIImage.init(named: rightImage)
        }
        self.rightImage.isHidden = rightImage.count == 0
        
    }
    
    public func setColor(leftColor : UIColor  = .black , rightColor : UIColor  = .black, leftFont : UIFont = UIFont.systemFont(ofSize: 17), rightFont : UIFont  = UIFont.systemFont(ofSize: 17) , leftBackgroundColor : UIColor  = .clear , rightBackgroundColor : UIColor  = .clear){
        leftLabel.font = leftFont
        rightLabel.font = rightFont
        leftLabel.textColor = leftColor
        rightLabel.textColor = rightColor
        leftLabel.backgroundColor = leftBackgroundColor
        rightLabel.backgroundColor = rightBackgroundColor
    }
    
    
    
    public func setCenterLabel(textColor : UIColor , text : String , font : UIFont , attributedText : NSAttributedString? = nil){
        centerLabel.textColor = textColor
        centerLabel.text = text
        centerLabel.font = font
        if attributedText != nil {
            centerLabel.attributedText = attributedText
        }
        centerLabel.textAlignment = .center
        leftLabel.isHidden =  true
        rightImage.isHidden =  true
        rightLabel.isHidden =  true
        leftImage.isHidden =  true
        centerLabel.isHidden = false
    }
    
    public func setRichInfo(_ attributedText : NSAttributedString , textColor : UIColor = .initString("##909398") , font : UIFont =  UIFont.systemFont(ofSize: 14.pd6sW)){
        centerLabel.font = font
        richLabel.font = font
        richLabel.textColor = textColor
        richLabel.attributedText = attributedText
        centerLabel.numberOfLines = 0
        centerLabel.attributedText = attributedText
        leftLabel.isHidden =  true
        rightImage.isHidden =  true
        rightLabel.isHidden =  true
        leftImage.isHidden =  true
        centerLabel.isHidden = true
        richLabel.isHidden = false
    }
    
    
    
    
    @objc func switchAction(_ action: UISwitch){
        switchBlock?(action.isOn)
    }
    
    public func showSwitchBtn(_ isHidden : Bool = false){
        switchBtn.isHidden = isHidden
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

