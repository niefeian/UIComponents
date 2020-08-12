//
//  HomeCollectionCell.swift
//  liangyi
//
//  Created by 聂飞安 on 2020/5/21.
//  Copyright © 2020 Nie. All rights reserved.
//

import UIKit
import SwiftProjects

public class HomeCollectionCell: CusAutoTableViewCell {

    var collectionView : UICollectionView!
    public var selectBlock : ((Int) -> Void)!
    
    var selectIndex = 0{
        didSet{
            collectionView.reloadData()
        }
    }
   
    
    public var nameList : [String]! = [String](){
        didSet{
            collectionView?.reloadData()
        }
    }
    
    override public func initializePage() {
        collectionView = getSubview(autoViewClass: .collectionView, index: 1 , autoInit : true) as? UICollectionView
        self.addSubview(collectionView)
    }
    
    override public func initLayoutSubviews() {
        collectionView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalTo(15)
            make.height.equalTo(60.pd6sW)
            make.bottom.equalToSuperview()
        }
    }
    
    public func updateHeight(_ height: CGFloat){
        collectionView?.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
    }
    
    override public func initializeDraw() {
            
            collectionView.backgroundColor = .white
            
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 10
            layout.minimumInteritemSpacing = 10
            layout.scrollDirection = .horizontal
            collectionView.setCollectionViewLayout(layout, animated: false)
            collectionView.register(CollectionItemCell.self, forCellWithReuseIdentifier: "cell")
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
        }
    
  
}

extension HomeCollectionCell : UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let count = nameList[indexPath.row].count
        return CGSize(width: CGFloat(count) * 15 + 20, height:60.pd6sW)
    }
    
    
    
}

extension HomeCollectionCell : UICollectionViewDelegate , UICollectionViewDataSource {
   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionItemCell
        cell.layoutType = .文字下滑块
        cell.setInfo(nameList[indexPath.row],showView: selectIndex == indexPath.row)
        return cell
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectIndex = indexPath.row
        selectBlock?(indexPath.row)
    }
    
    
}
