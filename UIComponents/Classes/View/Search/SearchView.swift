//
//  SearchView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/8.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit
import NFAToolkit

public class SearchView : UIView {
    
    public var textView : UITextField!
    private var searchImg : UIImageView!
    private var searchBtn : UIButton!
    private var noContent : Bool = true
   
    public var lineView : UIView!
    public var cancelTitle : String = "取消"
    public var searchlTitle : String = "搜索"
    private var backButton : UIButton!
    public var searchImage : UIImage!{
        didSet{
            searchImg?.image = searchImage
        }
    }
    
    public func becomeEidet() {
        textView.becomeFirstResponder()
    }
    
    public var searchBlock : CBWithParam!
    public var beginSearchBlock : CB!
    public var endSearchBlock : CB!
    public var cancelSearchBlock : CB!
    
    public var placeholder : String! = ""{
        didSet{
            textView?.placeholder = placeholder
        }
    }
    
    public var text : String! = ""{
        didSet{
            textView?.text = text
        }
    }
    
    open func getText()->String?{
        return textView?.text
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initUI(){
        
        lineView = UIView()
        self.addSubview(lineView)
        
        searchImg = UIImageView()
        searchImg?.image = searchImage
        self.addSubview(searchImg)
        
        textView = UITextField()
        textView.placeholder = placeholder
        textView.text = text
        textView.clearButtonMode = .always
     
        self.addSubview(textView)
        
        searchBtn = UIButton()
        self.addSubview(searchBtn)
        searchBtn.setTitleColor(.initString("#333333"), for: UIControl.State.normal)
        searchBtn.setTitle(cancelTitle, for: UIControl.State.normal)
        searchBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.pd6sW)
        searchBtn.addTarget(self, action: Selector(("toSearch1")), for: UIControl.Event.touchUpInside)
     
        registerKeyboardNotification()
        
        backButton = UIButton()
        backButton.setImage(UIImage(named: "bottom_getback"), for: UIControl.State.normal)
           backButton.addTarget(self, action: Selector(("toSearch1")), for: UIControl.Event.touchUpInside)
        
        self.addSubview(backButton)
        
        backButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(5)
            make.size.equalTo(0)
        }
        
        searchImg.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(backButton.snp_right).offset(15)
            make.size.equalTo(CGSize(width: self.height-15, height: self.height-15))
        }
    
        textView.snp.makeConstraints { (make) in
          make.centerY.equalToSuperview()
          make.left.equalTo(backButton.snp_right).offset(self.height)
          make.size.equalTo(CGSize(width: self.width-self.height-5 - 80, height: self.height-20))
        }

        searchBtn.snp.makeConstraints { (make) in
          make.centerY.equalToSuperview()
          make.left.equalTo(textView.snp_right).offset(10)
          make.size.equalTo(CGSize(width: 50, height: self.height-20))
        }
           
        lineView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(backButton.snp_right).offset(5)
            make.size.equalTo(CGSize(width: self.width-80, height: self.height))
        }

        textView.font = UIFont.systemFont(ofSize: 14.pd6sW)
        searchBtn.isHidden = false
        textView.tintColor = UIColor.clear
        textView.returnKeyType = .search
        textView.delegate = self
        
    }
    
    public func upbackView(_ hide : Bool){
        backButton.isHidden = hide
        searchBtn.isHidden = !hide
        backButton.snp.updateConstraints { (make) in
            make.size.equalTo(hide ? 0 : self.height)
        }
    }
    
   private func registerKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        textView.addTarget(self, action: Selector(("textFieldvalueChanged:")), for: .allEvents)

    }
    
    @objc func textFieldvalueChanged(_ textField: UITextField){
        if textField.text?.count ?? 0 >= 20 {
            textField.text =  textField.text?.subString(start: 0, length: 19)
        }
    }
    
    
    @objc func toSearch(){
        if textView?.text?.count ?? 0 > 0 {
            searchBlock?(textView?.text as AnyObject?)
        }else{
             searchBlock?(placeholder as AnyObject?)
        }
        textView?.resignFirstResponder()
    }
    
    @objc func toSearch1(){
        textView?.resignFirstResponder()
        cancelSearchBlock?()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        textFieldvalueChanged(textView)
        beginSearchBlock?()
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        endSearchBlock?()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension SearchView : UITextFieldDelegate{
    
    @objc public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
    
    @objc public func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        toSearch()
        textField.resignFirstResponder()
        return true;
    }
    
    
}
