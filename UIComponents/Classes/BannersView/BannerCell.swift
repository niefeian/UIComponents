//
//  BannerCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/4/24.
//

import UIKit
import SwiftProjects
import SnapKit
import NFAToolkit

public class BannerCell: CusTableViewCell ,BannersViewDelegate {
   
    public weak var delegate : BannersViewDelegate!
    
    public func didClickScrollView(_ index: NSInteger, by type: String) {
        delegate?.didClickScrollView(index,by:"banner")
    }
    
    public func didClickScrollView(_ index: NSInteger) {
        delegate?.didClickScrollView(index)
    }
    
    public func scrollViewDidScroll(_ index: NSInteger) {
        pageC.currentPage = index%pageC.totalCount
        delegate?.scrollViewDidScroll(index)
    }
    

    public var pageC: CusPageControl! =  CusPageControl()
    public var bannerView: BannersView!  =  BannersView(frame: CGRect(x: 0, y: 0, width:AppWidth, height:AppWidth * 177.5 / 375))
    
    public func initBannerView(urls : [String]?) {
        if urls?.count ?? 0 > 0{
            pageC.totalCount = urls!.count
            var images = [String]()
            images.append(contentsOf: urls!)
            if urls!.count < 3 {
                 images.append(contentsOf: urls!)
            }
            if urls!.count < 3 {
                 images.append(contentsOf: urls!)
            }
            self.bannerView.setupViewWithBannerVos(images, timeDelay: 3, count: images.count)
        }
    }
    

    override public func initializePage() {
        self.addSubview(bannerView)
        self.addSubview(pageC)
        self.clipsToBounds = true
        pageC.backgroundColor = .clear
    }
    
    public override func initLayoutSubviews() {
       
        bannerView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        pageC.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
    }
    
    public func updatePageConstraints(_ bottom : CGFloat) {
        pageC.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-bottom)
        }
    }
    
    
    public override func initializeDelegate() {
         bannerView.delegate = self
    }
    
    
}
