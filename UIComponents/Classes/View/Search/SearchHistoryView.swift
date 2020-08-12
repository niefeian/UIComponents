//
//  SearchHistoryView.swift
//  ZaiyiGouwuSQYHbuy
//
//  Created by 聂飞安 on 2020/6/9.
//  Copyright © 2020 zaiyici. All rights reserved.
//

import UIKit
import NFAFile
import NFAToolkit

public class SearchHistoryUtils : NSObject{
   
    public class func installData(_ text : String){
        var datas = getData()
        if datas.contains(text) {
            datas.removeAll { (str) -> Bool in
                return str == text
            }
        }
        if datas.count > 0 {
            datas.insert(text, at: 0)
        }else{
            datas.append(text)
        }
        UserDefaultsUtils.setInGroup("SearchHistory", key: "history", value: datas)
    }
    
   public class func getData()->[String]{
       return UserDefaultsUtils.getInGroup("SearchHistory", key: "history") as? [String] ?? [String]()
    }
    
    public class func removeData()->[String]{
        UserDefaultsUtils.setInGroup("SearchHistory", key: "history", value: [])
       return  [String]()
    }
    
}

public class SearchHistoryView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var historyView: UIView! = UIView()
    var btn: UIButton! = UIButton()
    public var searchBlock : ((String)->Void)!
    
    public class func show()->SearchHistoryView{
        let searchHistoryView = SearchHistoryView()
        searchHistoryView.showView(SearchHistoryUtils.getData())
        return searchHistoryView
    }
    
    func showView(_ strs :[String]){
        let lable = UILabel()
        lable.text = "历史记录"
        lable.textColor = .black
        lable.font = UIFont.boldSystemFont(ofSize: 16.pd6sW)
        lable.frame = CGRect(x: 15, y: 10, width: 120, height: 20)
//        lable.sizeToFit()
        btn.frame = CGRect(x: AppWidth - 80, y: 0, width: 65, height: 40)
        btn.setImage(UIImage.init(named: "1_qingchujilu"), for: UIControl.State.normal)
        self.addSubview(lable)
        self.addSubview(btn)
        self.addSubview(historyView)
        btn.addTarget(self, action: Selector(("clear")), for: .touchUpInside)
        setHistory(strs)
    }
    
    @objc func clear(){
        setHistory( SearchHistoryUtils.removeData())
    }
    func getSub(_ i : Int , baseView : UIView ) -> UILabel{
        if let label = baseView.viewWithTag(i) as? UILabel {
            return label
        }else{
            let label = UILabel()
            label.tag = i
            label.backgroundColor = .initString("#F2F2F2")
            label.textColor = UIColor.black
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.oneTap(_:)))
            tapGesture.numberOfTapsRequired = 1
            label.addGestureRecognizer(tapGesture)
            label.isUserInteractionEnabled = true
            baseView.addSubview(label)
            return label
        }
    }

    @objc open func oneTap(_ sender: UITapGestureRecognizer) {
        if let v = sender.view as? UILabel {
            searchBlock?(v.text ?? "")
        }
    }

    func setHistory(_ strs :[String]){
        var x : CGFloat = 0
        var y : CGFloat = 0
        for v in historyView.subviews {
            v.isHidden = true
        }
        
        for (index,str) in strs.enumerated(){
            let label = getSub(index+100, baseView: historyView)
            label.text = str
            label.sizeToFit()
            if x + label.width > AppWidth - 30 {
                x = 0
                y += 35
            }
            label.frame = CGRect(x: x, y: y, width: label.width + 30, height: 30)
            label.isHidden = false
            x +=  label.width + 10
            Tools.setCornerRadius(label, rate: 2)
        }
        let maxY = y + 35
        if strs.count == 0 {
            btn.backgroundColor = UIColor.white
        }else{
             btn.backgroundColor = UIColor.clear
        }
        self.bounds = CGRect(x: 0, y: 0, width: AppWidth, height:maxY+40)
        historyView.frame = CGRect(x: 15, y: 40, width: AppWidth - 30, height:maxY+40)
    }


}
