//
//  GalleryLayout.swift
//  AutoData
//
//  Created by 聂飞安 on 2020/5/22.
//

import UIKit
import NFAToolkit

public class GalleryLayout: UICollectionViewFlowLayout {
    
   public var activeDistance : CGFloat = AppWidth*0.4
   public var scaleFactor : CGFloat = 0.7
   public var rowSize : CGSize = CGSize(width: (AppWidth - 100)*0.25, height: (AppWidth - 100)*0.25 * 184 / 135)
    
    override init() {
        super.init()
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 30
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var adjust = CGFloat(MAXFLOAT)
        let horizontalCent = proposedContentOffset.x + (self.collectionView!.bounds.width / 2.0);//collectionView落在屏幕中点的x坐标
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0.0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height);//collectionView落在屏幕的大小
        
        let attrs = super.layoutAttributesForElements(in: targetRect) //获得落在屏幕的所有cell的属性

        for attr in attrs! {
            let layoutAttr = (attr as UICollectionViewLayoutAttributes).copy() as! UICollectionViewLayoutAttributes
            let center = layoutAttr.center.x
            if (abs(center - horizontalCent) < abs(adjust)) {
                adjust = center - horizontalCent
            }
            
        }
        return CGPoint(x: proposedContentOffset.x + adjust, y: proposedContentOffset.y)
    }
 
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)
        
        var visibleRect : CGRect = CGRect()
        visibleRect.origin = self.collectionView!.contentOffset
        visibleRect.size = self.collectionView!.bounds.size
        var i = 0
        for attr in attrs! {
            let layoutAttr = (attr as UICollectionViewLayoutAttributes).copy() as! UICollectionViewLayoutAttributes
            if (layoutAttr.frame.intersects(rect)) {
                let distance = visibleRect.midX - layoutAttr.center.x // 距离终点的距离
                let normalizedDitance = distance / activeDistance
                var zoom : CGFloat = 1.3
                if (abs(distance) < activeDistance) {
                    zoom = 1 + scaleFactor * (1 - abs(normalizedDitance))  > 1.3 ? 1 + scaleFactor * (1 - abs(normalizedDitance)) : 1.3
                    layoutAttr.zIndex = 1
                    layoutAttr.frame = CGRect(x: layoutAttr.frame.origin.x, y: (visibleRect.height-rowSize.height*zoom) * 0.5, width: rowSize.width*zoom, height: rowSize.height*zoom)
                    let layoutAttrC = layoutAttr.frame.origin.x + rowSize.width*zoom*0.5 - visibleRect.origin.x
                    let zooms = 1.7 - zoom
                    layoutAttr.transform3D = CATransform3DMakeTranslation((AppWidth/2 - layoutAttrC) * (1-zooms)*0.6, 0, zoom)
                }else{
                    zoom =  1 + scaleFactor * (1 - abs(normalizedDitance/1.5))
                    layoutAttr.zIndex = 1
                    layoutAttr.frame = CGRect(x: layoutAttr.frame.origin.x, y: (visibleRect.height-rowSize.height*zoom) * 0.5, width: rowSize.width*zoom, height: rowSize.height*zoom)
                    let layoutAttrC = layoutAttr.frame.origin.x + rowSize.width*zoom*0.5 - visibleRect.origin.x
                    let zooms = 1.7 - zoom
                    layoutAttr.transform = CGAffineTransform.init(translationX: (AppWidth/2 - layoutAttrC) * (1-zooms), y: 0)
                }
                attrs![i] = layoutAttr
            }
            i += 1
        }
        return attrs
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
