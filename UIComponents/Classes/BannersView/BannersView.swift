//
//  BannersView.swift
//  UIComponents
//
//  Created by 聂飞安 on 2020/4/22.
//

import Foundation
import UIKit
import NFAToolkit
import SnapKit
import ProThirdpart

public protocol BannersViewDelegate : NSObjectProtocol {
    
    func didClickScrollView(_ index:NSInteger)
    func scrollViewDidScroll(_ index:NSInteger)
    func didClickScrollView(_ index:NSInteger , by type : String)
}

open class BannersView: UIView , UIScrollViewDelegate {
    
    var _mainScrollView : UIScrollView?
    var currentImageView : UIImageView!
    var preImageView : UIImageView!
    var nextImageView : UIImageView!
    var _currentIndex: NSInteger! = 0
    var _dataArray = [String]()
    weak var timer : Timer?
    var rowTimeDelay : Int! = 0
    var addTimeDelay : Int! = 0
    var imgcount : Int = 0
    public weak var delegate : BannersViewDelegate!
    public var imageSize : CGSize! = CGSize(width: AppWidth, height: 300.pd6sW)
    public var scrollViewPoint : CGPoint! = CGPoint(x: 0, y: 0)
    public var minimumSpacing : CGFloat! = 0 //图片间距
    public var radius : CGFloat! = 0 //图圆角
    /*
     *初始化scrollView及其部件
     */
    public init(frame: CGRect, dataArray:[String]) {
        super.init(frame:frame)
        setupViewWithBannerVos(dataArray, count: dataArray.count)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
     public func setupViewWithBannerVos(_ banners : [String], timeDelay : Double = 4, count : Int) {
        imgcount = count
        setupView(banners, timeDelay : timeDelay)
    }
    
    
    func setupView(_ dataArray: [String], timeDelay : Double = 4) {
        
        if _mainScrollView == nil{
             _mainScrollView = UIScrollView()
        }
        
        rowTimeDelay = Int(timeDelay)
        _mainScrollView?.frame = CGRect(x: scrollViewPoint.x, y: scrollViewPoint.y, width: AppWidth, height: imageSize.height)
        
        // 如果只有一张图片，就不需要滚动了
        if dataArray.count >= 3 {
            _mainScrollView?.contentSize = CGSize(width: AppWidth * 3, height: imageSize.height)
        } else  {
            _mainScrollView?.contentSize = CGSize(width: AppWidth * CGFloat(dataArray.count) , height: imageSize.height)
        }
        
        _mainScrollView?.backgroundColor = UIColor.clear
        _mainScrollView?.delegate = self
        _mainScrollView?.isPagingEnabled = true
        _mainScrollView?.isUserInteractionEnabled = true
        _mainScrollView?.showsHorizontalScrollIndicator = false
        _mainScrollView?.showsVerticalScrollIndicator = false
        _mainScrollView?.bounces = false;
        _mainScrollView?.contentOffset = CGPoint(x: AppWidth, y: 0)
        if imageSize != nil {
            _mainScrollView?.clipsToBounds = true
        }
        if _mainScrollView != nil{
            self.addSubview(_mainScrollView!)
        }
        _currentIndex = 0;
       
        currentImageView = (_mainScrollView?.viewWithTag(101) as? UIImageView) ?? UIImageView()
        if currentImageView.tag != 101 {
            currentImageView.tag = 101
            currentImageView.clipsToBounds = true
            if radius > 0 {
                Tools.setCornerRadius(currentImageView, rate: radius)
            }
        }
        
        
        _dataArray.append(contentsOf: dataArray)
        self.setUpDataDataArray(_dataArray)
        // 手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapCLick))
        currentImageView.addGestureRecognizer(tap)
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        if dataArray.count > 1 {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.runImgPage), userInfo: nil, repeats: true)
        }
       
    }
    
    @objc func runImgPage(){
        addTimeDelay += 1
        if  addTimeDelay  >= rowTimeDelay {
            addTimeDelay =  0
            timerAction()
        }
    }
    
    /*
     *此处为scrollView的复用，比目前网上大部分的同类型控件油画效果好，只需要三张图片依次替换即可实现轮播，不需要有几张图就使scrollView的contentSize为图片数＊宽度
     */
    func setUpDataDataArray(_ dataArray:[String]) {
        // 中间图 一定要在中间
        //左侧的则为   中间图 的left - imageSize.width -  minimumSpacing
        //右侧为 中间图的right + minimumSpacing
        currentImageView.frame = CGRect(x: AppWidth * 1.5 - imageSize.width/2, y: 0, width: imageSize.width, height: imageSize.height);
        currentImageView.setImageFromURL(_dataArray[_currentIndex])
        currentImageView.isUserInteractionEnabled = true;
        _mainScrollView?.addSubview(currentImageView)
        
        // 如果只有一张图片，就创建一张好了
        if dataArray.count == 1 {
            _mainScrollView?.contentOffset = CGPoint(x: 0, y: 0)
            return
        }
        
        // 左侧图
        if preImageView == nil {
            preImageView = UIImageView()
            preImageView.clipsToBounds = true
            _mainScrollView?.addSubview(preImageView)
            if radius > 0 {
                Tools.setCornerRadius(preImageView, rate: radius)
            }
        }
        
//        AppWidth * 2.5 - imageSize.width/2 - imageSize.width - minimumSpacing
        preImageView.frame = CGRect(x:AppWidth * 1.5 - imageSize.width * 1.5  - minimumSpacing, y: 0, width: imageSize.width, height: imageSize.height);
   
        let imageStr = _currentIndex - 1 >= 0 ? dataArray[_currentIndex-1] : dataArray.last
        preImageView.isUserInteractionEnabled = true
        preImageView.setImageFromURL(imageStr)
        // 右侧
        
        if nextImageView == nil {
            nextImageView = UIImageView()
            nextImageView.clipsToBounds = true
            _mainScrollView?.addSubview(nextImageView)
            if radius > 0 {
               Tools.setCornerRadius(nextImageView, rate: radius)
            }
        }
        
        nextImageView.frame = CGRect(x: AppWidth * 1.5 + imageSize.width/2 + minimumSpacing , y: 0, width: imageSize.width, height: imageSize.height);
        
        let imageStr1 = _currentIndex + 1 < dataArray.count ? dataArray[_currentIndex+1] : dataArray.first
        
        nextImageView.isUserInteractionEnabled = true
        nextImageView.setImageFromURL(imageStr1)
        currentImageView.contentMode = .scaleAspectFill
        preImageView.contentMode = .scaleAspectFill
        nextImageView.contentMode = .scaleAspectFill

    }
  
    /*
     *图片的代理点击响应方法
     */
    @objc func tapCLick() {
        delegate?.didClickScrollView(_currentIndex)
    }
    /*
     *定时器方法，使banner页无限轮播
     */
    @objc func timerAction() {
        if _currentIndex+1 < _dataArray.count {
            _currentIndex = _currentIndex + 1;
        }
        else {
            _currentIndex=0;
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self._mainScrollView?.contentOffset = CGPoint(x: AppWidth * 1.5 + self.imageSize.width/2  , y: 0)
        },completion: {
            (finished) in
            self._mainScrollView?.contentOffset = CGPoint(x: AppWidth, y: 0)
            self.setUpDataDataArray(self._dataArray)
        })
    }
    
    /*
     *UIScrollViewDelegate  协议方法，拖动图片的处理方法
     */
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == _mainScrollView
        {
            let index = scrollView.contentOffset.x / AppWidth;
            if index > 1
            {
                _currentIndex = _currentIndex + 1 < _dataArray.count ? _currentIndex+1 : 0;
                UIView.animate(withDuration: 0.5, animations: {
                    self._mainScrollView?.contentOffset = CGPoint(x: AppWidth * 1.5 + self.imageSize.width/2 , y: 0)
                },completion: {
                    (finished) in
//                    self._mainScrollView?.contentOffset = CGPoint(x:  AppWidth * 1.5 - self.imageSize.width * 1.5 , y: 0)
                    self.setUpDataDataArray(self._dataArray)
                    self._mainScrollView?.contentOffset = CGPoint(x: AppWidth, y: 0)
                })
            }
            else if index < 1
            {
                _currentIndex = _currentIndex - 1 >= 0 ? _currentIndex-1 : _dataArray.count - 1;
                UIView.animate(withDuration: 0.5, animations: {
                    self._mainScrollView?.contentOffset = CGPoint(x: AppWidth * 1.5 - self.imageSize.width * 1.5 , y: 0)
                },completion: {
                    (finished) in
//                    self._mainScrollView?.contentOffset = CGPoint(x: AppWidth * 1.5 + self.imageSize.width/2 , y: 0)
                    self.setUpDataDataArray(self._dataArray)
                    self._mainScrollView?.contentOffset = CGPoint(x: AppWidth, y: 0)
                })
            }
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        addTimeDelay = 0
        delegate?.scrollViewDidScroll(_currentIndex)
    }
    
    
}

