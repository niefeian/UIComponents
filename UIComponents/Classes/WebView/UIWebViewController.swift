//
//  UIWebViewController.swift
//  zhouyi
//
//  Created by 聂飞安 on 2019/7/23.
//  Copyright © 2019 聂飞安. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import SwiftProjects
import NFAToolkit

open class UIWebViewController: BaseProVC {
    
    private var webView: WebView!
    public var model : WebViewModel!
    public var scriptMessageHandlerArray = [String]()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        if postData is WebViewModel {
            model = postData as? WebViewModel
        }

        if #available(iOS 11.0, *) {
           webView.webView.scrollView.contentInsetAdjustmentBehavior = .never
        }else{
           self.automaticallyAdjustsScrollViewInsets = false
        }
        if model != nil {
            if model?.title?.count ?? 0 > 0 {
               self.navigationItem.title =  model.title
            }
            loadWeb()
        }
    }

    public func getShowView() ->  UIView?{
        return  webView
    }
    
    public func getWebView() ->  WKWebView?{
        return  webView?.webView
    }
    
   public func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)? = nil){
        webView?.webView.evaluateJavaScript(javaScriptString, completionHandler: completionHandler)
    }
    
    @objc open func loadWeb(){
       
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        webView.delegate = self
        if model.getWebType() == WEB_TYPE.本地网页.rawValue {
           config.scriptMessageHandlerArray = ["valueName"]
           webView.webConfig = config
           webView.webloadType(self, .HTMLName(name: model.localFile!))
        } else if model.getWebType() == WEB_TYPE.富文本.rawValue {
           webView.webloadType(self, .HTMLString(richContent: model.imageFItStyle +  model.richContent!))
        } else {
           config.scriptMessageHandlerArray = scriptMessageHandlerArray
           webView.webConfig = config
            if model.addingPercentEncoding
            {
                webView.webloadType(self, .URLString(url: model.website?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""),reqMap:getParameters())
            }
            else
            {
                webView.webloadType(self, .URLString(url: model.website ?? ""),reqMap:getParameters())
            }
        }       
    }
    
    override open func initializePage() {
        var config = WkwebViewConfig()
        config.isShowScrollIndicator = false
        config.isProgressHidden = false
        webView = WebView(frame: CGRect.zero)
        webView.delegate = self
         config.scriptMessageHandlerArray = ["imageChoose","openShareCard"]
        webView.webConfig = config
        
        webView.webView.scrollView.delegate = self
        self.view.addSubview(webView)
    }
    
    
    open func reloadDelegate(){
        webView.reloadDelegate()
    }
    
    override open func initLayoutSubviews() {
        webView?.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(NavigationH)
        }
    }
    
     open func updateLayoutSubviews(_ edgeInsets : UIEdgeInsets) {
           webView?.snp.updateConstraints { (make) in
                make.left.equalTo(edgeInsets.left)
               make.right.equalTo(edgeInsets.right)
               make.bottom.equalTo(edgeInsets.bottom)
               make.top.equalTo(edgeInsets.top)
           }
       }

    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
   @objc open func reloadWebView(){
        if model != nil && webView != nil {
            if model.addingPercentEncoding {
                webView.webloadType(self, .URLString(url: model.website?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""),reqMap:getParameters())
            }else{
                webView.webloadType(self, .URLString(url: model.website ?? ""),reqMap:getParameters())
            }
        }
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return nil
    }
    
   
    open func webView(_ webView: WKWebView, navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    open func webViewUserContentController(_ scriptMessageHandlerArray: [String],  message: WKScriptMessage) {
         
    }
    
    open func getParameters()->[String:String]{
      
       var parameters = [String:String]()
       let infoDictionary = Bundle.main.infoDictionary! as Dictionary
       parameters["ver"] = infoDictionary["CFBundleShortVersionString"] as? String ?? "1.0"
       return parameters
    }
    
    open func finshLoad(){
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}


extension UIWebViewController:WKWebViewDelegate{
    
    open func webViewUserContentController(_ scriptMessageHandlerArray: [String], didReceive message: WKScriptMessage) {
        self.webViewUserContentController(scriptMessageHandlerArray,message:message)
    }
    
    open func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.finshLoad()
    }
    
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
    }
    
    open func webViewEvaluateJavaScript(_ result: Any?, error: Error?) {
      
    }
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            self.finshLoad()
            if self.model.title == nil
            {
            webView.evaluateJavaScript("document.title") {[weak self] (data, e) in
              if let str = data as? String {
                  if str != "" {
                      if str.count > 8 {
                           self?.navigationItem.title = str.subString(start: 0, length: 8)
                      }else{
                          self?.navigationItem.title = str
                      }
                  }
              }
            }
        }
        
        hiddenBlankDataTip()
    }
    
    
    open func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
     
    }
   
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        self.webView(webView, navigationAction: navigationAction, decisionHandler: decisionHandler)
    }
    
}
    

extension UIWebViewController : UIScrollViewDelegate{
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y >= 10
    }
    
}
