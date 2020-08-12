//
//  InputBoxView.swift
//  ZhouyiNamed
//
//  Created by 聂飞安 on 2020/7/7.
//  Copyright © 2020 nie. All rights reserved.
//

import UIKit
import SwiftProjects
import NFAToolkit

public class InputBox : NSObject
{
    public var title : String! = ""
    public var buttonTitles : [String] = [String]()
    public var placeholder : String! = ""
    public var block : ((Int) -> Void?)? = nil
    public var image : String! = ""
    
    public class func getInputBox(_ title : String , buttonTitles : [String] = [String]() , placeholder  : String = "" , image  : String = "" , block : @escaping (Int) -> Void ) -> InputBox
    {
        let model = InputBox()
        model.title = title
        model.buttonTitles = buttonTitles
        model.placeholder = placeholder
        model.block = block
        model.image = image
        return model
    }
}


public class InputBoxView: BaseView {
   
    public var inputBoxType : InputBoxType!
    public var seletColor : UIColor! = .initString("#FF9714")
    public var seletIndex : Int! = 1
    public var inputBox : InputBox!
    
    public func setInputBoxType(_ type : InputBoxType , model : InputBox)
    {
        inputBoxType = type
        inputBox = model
        initializeView()
    }
    
    public override func initializePage() {
        if inputBoxType == nil
        {
            return
        }
        switch inputBoxType {
        case .文字_输入框:
            addAutoView([(.label, 1),(.textField, 1)])
        case .文字_输入框_按钮:
           addAutoView([(.label, 1),(.textField, 1),(.button, 1)])
        case .文字_双选:
            addAutoView([(.label, 1),(.button, 2)])
        case .文字_输入框_双选:
            addAutoView([(.label, 1),(.textField, 1),(.button, 2)])
            break
        default:
            break
        }
        super.initializePage()
    }
    
    public override func initLayoutSubviews() {
        if inputBoxType == nil
        {
            return
        }
        getSubLabelView(index: 1)?.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(20.pd6sW)
            make.width.equalTo(90.pd6sW)
        })
        switch inputBoxType {
        case .文字_输入框:
            getSubview(autoViewClass: .textField, index: 1)?.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(getSubLabelView(index: 1)!.snp_right).offset(25.pd6sW)
                make.height.equalToSuperview()
                make.right.equalTo(-20.pd6sW)
            })
        case .文字_输入框_按钮:
              getSubview(autoViewClass: .textField, index: 1)?.snp.makeConstraints({ (make) in
                   make.centerY.equalToSuperview()
                   make.left.equalTo(getSubLabelView(index: 1)!.snp_right).offset(25.pd6sW)
                   make.height.equalToSuperview()
                   make.right.equalTo(-20.pd6sW)
               })
              getSubview(autoViewClass: .button, index: 1)?.snp.makeConstraints({ (make) in
                make.center.equalTo(getSubview(autoViewClass: .textField, index: 1)!)
                make.size.equalTo(getSubview(autoViewClass: .textField, index: 1)!)
              })
        case .文字_双选:
            getSubview(autoViewClass: .button, index: 1)?.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(getSubLabelView(index: 1)!.snp_right).offset(25.pd6sW)
                make.size.equalTo(CGSize(width: 50.pd6sW, height: 23.pd6sW))
            })
            
            getSubview(autoViewClass: .button, index: 2)?.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(getSubview(autoViewClass: .button, index: 1)!.snp_right).offset(20.pd6sW)
                make.size.equalTo(getSubview(autoViewClass: .button, index: 1)!)
            })
        case .文字_输入框_双选:
          getSubview(autoViewClass: .textField, index: 1)?.snp.makeConstraints({ (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(getSubLabelView(index: 1)!.snp_right).offset(25.pd6sW)
                make.size.equalTo(CGSize(width: 50.pd6sW, height: 23.pd6sW))
            })
          
          getSubview(autoViewClass: .button, index: 1)?.snp.makeConstraints({ (make) in
              make.centerY.equalToSuperview()
              make.left.equalTo(getSubview(autoViewClass: .textField, index: 1)!.snp_right).offset(17.pd6sW)
             make.size.equalTo(CGSize(width: 23.pd6sW, height: 23.pd6sW))
          })
          
          getSubview(autoViewClass: .button, index: 2)?.snp.makeConstraints({ (make) in
              make.centerY.equalToSuperview()
              make.left.equalTo(getSubview(autoViewClass: .button, index: 1)!.snp_right).offset(23.pd6sW)
              make.size.equalTo(getSubview(autoViewClass: .button, index: 1)!)
          })
            break
        default:
            break
        }
    }
    
    public override func initializeDraw() {
        if inputBoxType ==  nil
        {
            return
        }
        getSubLabelView(index: 1)?.textColor = .initString("#333333")
        getSubLabelView(index: 1)?.setFont(17)
        getSubLabelView(index: 1)?.text = inputBox.title
        func setButton(_ index : Int , name : String)
        {
            if let button = getSubview(autoViewClass: .button, index: index) as? UIButton
            {
                button.addTarget(self, action: #selector(self.touchButton(_:)), for: .touchUpInside)
                button.setTitle(name, for: .normal)
                button.setCornerRadius(4)
                button.titleLabel?.setFont(13)
            }
        }
        switch inputBoxType {
        case .文字_输入框:
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.placeholder = inputBox.placeholder
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.font = UIFont.systemFont(ofSize: 16.pd6sW)
            break
        case .文字_输入框_按钮:
            
            setButton(1, name: "")
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.placeholder = inputBox.placeholder
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.font = UIFont.systemFont(ofSize: 16.pd6sW)
        case .文字_双选:
            setButton(1, name: inputBox.buttonTitles.first ?? "")
            setButton(2, name: inputBox.buttonTitles.last ?? "")
            touchButton(getSubview(autoViewClass: .button, index: 1) as! UIButton)
        case .文字_输入框_双选:
            setButton(1, name: inputBox.buttonTitles.first ?? "")
                      setButton(2, name: inputBox.buttonTitles.last ?? "")
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.placeholder = inputBox.placeholder
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.textAlignment = .center
            (getSubview(autoViewClass: .textField, index: 1) as? UITextField)?.font = UIFont.systemFont(ofSize: 16.pd6sW)
            getSubview(autoViewClass: .textField, index: 1)?.setCornerRadius(4)
            getSubview(autoViewClass: .textField, index: 1)?.backgroundColor = .initString("#F5F5F5")
            touchButton(getSubview(autoViewClass: .button, index: 1) as! UIButton)
            break
        default:
            break
        }
    }
    

    //目前来说，按钮最多2个  1 - 2
    @objc func touchButton(_ btn : UIButton)
    {
        
        if inputBoxType == .文字_输入框_按钮
        {
            inputBox.block?(0)
        }
        else if inputBoxType == .文字_双选 ||  inputBoxType == .文字_输入框_双选
        {
            let tag = ( btn.tag - 200 ) 
            seletIndex = tag
            
            getSubview(autoViewClass: .button, index: tag)?.backgroundColor = .initString("#FF9714")
            (getSubview(autoViewClass: .button, index: tag) as? UIButton)?.setTitleColor(.white, for: .normal)
            if let button =  getSubview(autoViewClass: .button, index: (tag) % 2 + 1) as? UIButton
            {
               Tools.masksToBounds(cornerView: button, cornerRadius: 4, borderWidth: 1, borderColor: .initString("#FF9714"))
                button.setTitleColor(.initString("#666666"), for: .normal)
               button.backgroundColor = .white
            }
            inputBox.block?(tag)
        }
    }
    
    
    @objc public func touchButtonToIndex(_ tag : Int)
        {
        if inputBoxType == .文字_输入框_按钮
        {
            inputBox.block?(0)
        }
        else if inputBoxType == .文字_双选 ||  inputBoxType == .文字_输入框_双选
        {
            seletIndex = tag
            
            getSubview(autoViewClass: .button, index: tag)?.backgroundColor = .initString("#FF9714")
            (getSubview(autoViewClass: .button, index: tag) as? UIButton)?.setTitleColor(.white, for: .normal)
            if let button =  getSubview(autoViewClass: .button, index: (tag) % 2 + 1) as? UIButton
            {
               Tools.masksToBounds(cornerView: button, cornerRadius: 4, borderWidth: 1, borderColor: .initString("#FF9714"))
                button.setTitleColor(.initString("#666666"), for: .normal)
               button.backgroundColor = .white
            }
            inputBox.block?(tag)
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
