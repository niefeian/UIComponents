//
//  SearchBarView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/9.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import SnapKit

public enum SearchBarType {
    case 文字 , 滑块 , 文字加上下指示器
}

public protocol SearchViewDelegate : NSObjectProtocol {
    func didClick(_ row : Int , key : String)
}

public class Search{
    
    public var barType : SearchBarType = .文字
    @objc public var barName = ""
    @objc public var filterArr = [String]()
    @objc public var normalColor : UIColor = .initString("#666666")
    @objc public var selectColor : UIColor! = .initString("#FF1357")
    @objc public var normalFont : UIFont = .systemFont(ofSize: 14.pd6sW)
    @objc public var selectFont : UIFont! = .systemFont(ofSize: 14.pd6sW)
    
   public class func createSearch(barName : String , filterArr : [String] , barType : SearchBarType = .文字 , normalColor : UIColor = .initString("#666666"), selectColor : UIColor = .initString("#FF1357"), normalFont : UIFont = .systemFont(ofSize: 14.pd6sW), selectFont : UIFont = .systemFont(ofSize: 14.pd6sW)) -> Search{
        let model = Search()
        model.barName = barName
        model.filterArr = filterArr
        model.barType = barType
        model.normalColor = normalColor
        model.selectColor = selectColor
        model.selectFont = selectFont
        model.normalFont = normalFont
        return model
    }
    
}

class SearchBarItem : UIView{
    
    var blcok : ((String) -> Void)!
    var search : Search!
    var searchBtn : UIButton! = UIButton()
    var switchUI : UISwitch?
    var switchImage : UIImageView?
    var index = 0
    let imageArr = ["dsj_wxz","dsj_shang","dsj_xia"]
    class func createSearchBar(_ search : Search , block : @escaping (String) -> Void) -> SearchBarItem{
        let searchBarItem = SearchBarItem()
        searchBarItem.blcok = block
        searchBarItem.search = search
        switch search.barType {
        case .文字:
            searchBarItem.createSearchBarTxet(search)
        case .滑块:
            searchBarItem.createSearchSwitch(search)
        case .文字加上下指示器:
            searchBarItem.createSearchTextAndImage(search)
        }
        return searchBarItem
    }
    
    func createSearchTextAndImage(_ search : Search){
           let label = UILabel()
           self.addSubview(label)
           let image = UIImageView()
           self.addSubview(image)
           label.text = search.barName
           label.snp.makeConstraints { (make) in
               make.center.centerY.equalToSuperview()
               make.left.equalTo(20)
           }
           label.font = search.normalFont
           label.textColor = search.normalColor
           label.sizeToFit()
           image.snp.makeConstraints { (make) in
               make.center.centerY.equalToSuperview().offset(0)
               make.left.equalTo(label.width + 22)
               make.size.equalTo(CGSize(width: 10, height: 16))
           }
           self.bounds = CGRect(x: 0, y: 0, width: label.width + 50, height: 0)
        
        
           self.addSubview(searchBtn)
           searchBtn.snp.makeConstraints { (make) in
               make.center.equalToSuperview()
               make.size.equalToSuperview()
           }
            image.image = UIImage(named: imageArr[index])
            image.contentMode = .scaleAspectFill
           searchBtn.addTarget(self, action: Selector(("selectedImage:")), for: UIControl.Event.touchUpInside)
           self.switchImage = image
       }
    
    
    func createSearchSwitch(_ search : Search){
        let label = UILabel()
        self.addSubview(label)
        let switchUI = UISwitch()
        self.addSubview(switchUI)
        label.text = search.barName
        label.snp.makeConstraints { (make) in
            make.center.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        label.font = search.normalFont
        label.textColor = search.normalColor
        label.sizeToFit()
        switchUI.snp.makeConstraints { (make) in
            make.center.centerY.equalToSuperview().offset(2)
            make.left.equalTo(label.width + 19)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        // 修改控件的大小，不能设置frame，只能用缩放比例
        switchUI.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.bounds = CGRect(x: 0, y: 0, width: label.width + 70, height: 0)
      
        self.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        searchBtn.addTarget(self, action: Selector(("selectedSwitchUI:")), for: UIControl.Event.touchUpInside)
        self.switchUI = switchUI
    }
    
    func createSearchBarTxet(_ search : Search){
      
        searchBtn.setTitleColor(search.normalColor, for: UIControl.State.normal)
        searchBtn.setTitleColor(search.selectColor, for: UIControl.State.selected)
        searchBtn.titleLabel?.font = search.normalFont
        searchBtn.setTitle(search.barName, for: UIControl.State.normal)
        self.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        searchBtn.titleLabel?.sizeToFit()
        let width = searchBtn.titleLabel?.frame.width ?? 0
        self.bounds = CGRect(x: 0, y: 0, width: width + 40, height: 0)
        searchBtn.addTarget(self, action: Selector(("selected:")), for: UIControl.Event.touchUpInside)
    }
    
    @objc func selectedSwitchUI(_ btn : UIButton){
        btn.isSelected = !btn.isSelected
        switchUI?.setOn(btn.isSelected, animated: true)
        if btn.isSelected {
           blcok?("1")
        }else{
           blcok?("0")
        }
    }
    
    @objc func selectedImage(_ btn : UIButton){
        index += 1
        if search.filterArr.count > 0 {
            switchImage?.image = UIImage(named: imageArr[index%imageArr.count])
            blcok?(search.filterArr[index%search.filterArr.count])
        }
        
    }
    
    @objc func selected(_ btn : UIButton){
        btn.isSelected = !btn.isSelected
        if btn.isSelected {
            if search.filterArr.count > 0 {
                blcok?(search.filterArr[0])
            }
        }else{
            blcok?("")
        }
    }
    
    func updateBtn(selected : Bool){
        searchBtn.isSelected = selected
        switchUI?.setOn(selected, animated: true)
        switchImage?.image = UIImage(named: imageArr[selected ? 1 : 0])
    }
    
}

public class SearchBarView: UIView {
    
    private var scrollView = UIScrollView()
    public weak var delegate : SearchViewDelegate!
    public func setData(_ searchs : [Search]){
        
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalToSuperview()
        }
        var x : CGFloat = 0
        for (index,search) in searchs.enumerated(){
            let searchBarItem = SearchBarItem.createSearchBar(search, block: { str in
                self.delegate?.didClick(index, key: str)
            })
            searchBarItem.frame = CGRect(x: x, y: 0, width: searchBarItem.width, height: self.height)
            x += searchBarItem.width
            searchBarItem.tag = 100 + index
            scrollView.addSubview(searchBarItem)
        }
    }
    
    public func updateIndexView(index : Int , on : Bool){
        (scrollView.viewWithTag(100+index) as? SearchBarItem)?.updateBtn(selected: on)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
