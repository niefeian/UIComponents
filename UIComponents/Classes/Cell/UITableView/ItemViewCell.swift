//
//  ItemViewCell.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/6/5.
//

import UIKit
import SwiftProjects
import NFAToolkit

public class ItemVO : NSObject {
    @objc public var image = ""//网络图片
    @objc public var icon = ""
    @objc public var title = ""
}

public class ItemViewCell: CusAutoTableViewCell {

    public weak var delegate : BannersViewDelegate!
    var collectionView : UICollectionView!
    public var items : [ItemVO]!{
        didSet{
            updatetLayoutSubviews()
        }
    }
    
    override public func initializePage() {
        collectionView = getSubview(autoViewClass: .collectionView, index: 1, autoInit: true) as? UICollectionView
        self.addSubview(collectionView)
    }
    
    override public func initLayoutSubviews() {
        
        collectionView.snp.makeConstraints { (make) in
            make.right.equalTo(-10.pd6sW)
            make.height.equalTo(84.pd6sW)
            make.top.equalTo(10.pd6sW)
            make.left.equalTo(10.pd6sW)
            make.bottom.equalTo(0)
        }
        
        Tools.setCornerRadius(collectionView, rate: 4)
    }
    
    
    func updatetLayoutSubviews(){
        let height = ceil(CGFloat(items.count)/5) * 79.pd6sW + 5.pd6sW
        collectionView.snp.updateConstraints { (make) in
            make.height.equalTo(height)
        }
        collectionView?.reloadData()
    }
    
    override public func initializeDraw() {
        
        collectionView.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0.1
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0.1
        layout.itemSize = CGSize(width:  70.pd6sW , height: 75.pd6sW)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(CollectionItemCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

    }
   
}

extension ItemViewCell : UICollectionViewDelegate , UICollectionViewDataSource {
   
   public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }

    
    
   public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionItemCell
        cell.layoutType = .图文
        cell.setInfo(items[indexPath.row].icon,title: items[indexPath.row].title , imageUrl : items[indexPath.row].image )
        return cell
    }
    
    
   public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didClickScrollView(indexPath.row, by: "item")
    }

}


extension ItemViewCell : UICollectionViewDelegateFlowLayout{
    
}
