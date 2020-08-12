//
//  CollectionItemCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/5/20.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit

public class CollectionItemCell: CusAutoCollectionCell {
    
    public var layoutType : LayoutType!{
        didSet{
            self.reloadUI()
        }
    }
    
    public var lineSpacing : CGFloat = 0
    
    func reloadUI(){
        initializePage()
        initLayoutSubviews()
        initializeDelegate()
        initializeDraw()
        initializeData()
    }
    
    override public func initializePage() {
        switch layoutType {
        case .图文:
            addAutoView([(.imageView, 1),(.label, 1)])
        case .图: addAutoView([(.imageView, 1)])
        case .文字下滑块 :
            addAutoView([(.view , 2),(.label, 1)])
        case .文字:
            addAutoView([(.label, 1)])
        case .none:
            break
        }
        super.initializePage()
    }
    
    override public func initLayoutSubviews() {
        switch layoutType {
               case .图文:
                    getSubview(autoViewClass: .imageView, index: 1)?.snp.makeConstraints({ (make) in
                        make.centerX.equalToSuperview()
                        make.top.equalTo(10)
                        make.size.equalTo(45.pd6sW)
                    })

                    getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
                        make.centerX.equalToSuperview()
                        make.top.equalTo( getSubview(autoViewClass: .imageView, index: 1)!.snp_bottom).offset(lineSpacing)
                        make.height.equalTo(12)
                        make.bottom.equalToSuperview().offset(-5)
                    })
               case .图:
                    getSubview(autoViewClass: .imageView, index: 1)?.snp.makeConstraints({ (make) in
                        make.size.equalToSuperview()
                        make.center.equalToSuperview()
                    })
        case .文字下滑块:
            getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
//                make.ce.equalTo(10)
            })
            
        getSubview(autoViewClass: .view, index: 2)?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo( getSubview(autoViewClass: .label, index: 1)!.snp_bottom).offset(5.pd6sW)
            make.height.equalTo(4)
            make.width.equalTo(18)
        })

        getSubview(autoViewClass: .view, index: 1)?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(1)
            make.bottom.equalTo(1)
            make.left.equalTo(1)
        })
        case .文字:
            getSubview(autoViewClass: .label, index: 1)?.snp.makeConstraints({ (make) in
                make.center.equalToSuperview()
                make.size.equalToSuperview()
            })
        case .none:
            break
        }
        super.initializePage()
    }
    
    public override func initializeDraw() {
        switch layoutType {
            
        case .图文:
            break
        case .图:
            break
        case .文字下滑块:
            if let view = getSubview(autoViewClass: .view, index: 2){
                view.backgroundColor = .initString("#E67458")
                Tools.setCornerRadius(view, rate: 2)
            }
            getSubview(autoViewClass: .view, index: 1 , autoInit: true)?.isHidden = true
        case .none:
            break
        case .文字:
            break
        }
    }
    public func setInfo(_ image : String , title : String , imageUrl : String = ""){
        if imageUrl.count > 0 {
            (getSubview(autoViewClass: .imageView, index: 1) as? UIImageView)?.setImageFromURL(imageUrl)
        }else{
            (getSubview(autoViewClass: .imageView, index: 1) as? UIImageView)?.image = UIImage.init(named: image)
        }
        (getSubview(autoViewClass: .imageView, index: 1) as? UIImageView)?.contentMode = .scaleAspectFit
        (getSubview(autoViewClass: .label, index: 1) as? UILabel)?.text = title
        (getSubview(autoViewClass: .label, index: 1) as? UILabel)?.setFont(12)
        (getSubview(autoViewClass: .label, index: 1) as? UILabel)?.textColor = .initString("#333333")
    }
    
    public func setInfo(_ title : String , showView : Bool){
        
        if let label = getSubview(autoViewClass: .label, index: 1  , autoInit: true) as? UILabel {
            label.font = showView ? UIFont.boldSystemFont(ofSize: 15.pd6sW) : UIFont.systemFont(ofSize: 15.pd6sW)
            label.textColor =  showView ? .initString("##181819") : .initString("###7C828D")
            label.text = title
            label.numberOfLines = 0
            label.textAlignment = .center
        }
        
        (getSubview(autoViewClass: .view, index: 2 , autoInit: true))?.isHidden = !showView
    }
    
    public func setRichInfo(_ attributedText : NSAttributedString ){
        if let label = getSubview(autoViewClass: .label, index: 1  , autoInit: true) as? UILabel {
            label.setFont(13)
            label.textColor = .initString("#919399")
            label.attributedText = attributedText
            label.numberOfLines = 0
            label.textAlignment = .center
        }
        getSubview(autoViewClass: .view, index: 1 , autoInit: true)?.isHidden = false
        (getSubview(autoViewClass: .view, index: 2 , autoInit: true))?.isHidden = true
       
    }
    
    public  func reloadBgColor(_ select : Bool){
        if select {
            if let view  = getSubview(autoViewClass: .view, index: 1 , autoInit: true) {
                            view.backgroundColor = .initString("##FCEBE7")
                            Tools.masksToBounds(cornerView: view ,cornerRadius:5,borderWidth:1 , borderColor: .initString("#E67458"))
                            view.isHidden = false
                        }
        }else{
            if let view  = getSubview(autoViewClass: .view, index: 1 , autoInit: true) {
                view.backgroundColor = .initString("#F5F7FA")
//                Tools.setCornerRadius(view, rate: 5)
                Tools.masksToBounds(cornerView: view ,cornerRadius:5,borderWidth:1 , borderColor: .initString("F5F7FA"))
                view.isHidden = false
            }
        }
        
    }
}
