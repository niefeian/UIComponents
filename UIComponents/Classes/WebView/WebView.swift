//
//  wk.swift
//  WKWebViewSwift
//

import UIKit
import WebKit
import NFAToolkit

@IBDesignable
class WebView: UIView {
    /// 事件
    fileprivate weak var target: AnyObject?
    
    /// 创建webveiew
    open var webView = WKWebView()
    
    /// 进度条
    fileprivate var progressView = UIProgressView()
    
    /// 创建一个webiview的配置项
    let configuretion = WKWebViewConfiguration()
    
    //执行JS 需要实现代理方法
    fileprivate var POSTJavaScript = String()
    
    //是否是第一次加载
    fileprivate var needLoadJSPOST:Bool?
    
    /// WebView配置项
    var webConfig : WkwebViewConfig?
    
    var  webTop : CGFloat = 0.0
    
    //保存请求链接
    fileprivate var snapShotsArray:Array<Any>?
    
    //设置代理
    weak var delegate : WKWebViewDelegate?
    

    func canGoBack() -> Bool{
        return  webView.canGoBack
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    open override func layoutSubviews() {
        super.layoutSubviews()
        webView.frame = CGRect(x: 0, y: webTop, width: self.width, height: self.height)
        webView.scrollView.contentSize = CGSize(width: AppWidth, height: self.height)
       
    }
    
    fileprivate func setupUI(webConfig:WkwebViewConfig)  {
        // Webview的偏好设置
        configuretion.preferences = WKPreferences()
        configuretion.preferences.minimumFontSize = webConfig.minFontSize
        configuretion.preferences.javaScriptEnabled = webConfig.isjavaScriptEnabled
        configuretion.preferences.javaScriptCanOpenWindowsAutomatically = webConfig.isAutomaticallyJavaScript
        configuretion.userContentController = WKUserContentController()
        _ = webConfig.scriptMessageHandlerArray.map{configuretion.userContentController.add(self, name: $0)}
        
        webView = self.viewWithTag(102) as? WKWebView ??  WKWebView(frame:frame,configuration: configuretion)
        webView.tag = 102
        
        //开启手势交互
        webView.allowsBackForwardNavigationGestures = webConfig.isAllowsBackForwardGestures
        
        //滚动条
        webView.scrollView.showsVerticalScrollIndicator = webConfig.isShowScrollIndicator
        webView.scrollView.showsHorizontalScrollIndicator = webConfig.isShowScrollIndicator

        // 监听支持KVO的属性
//        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        //内容自适应
        webView.sizeToFit()
        self.addSubview(webView)
        
        progressView = self.viewWithTag(104) as? UIProgressView ?? UIProgressView(progressViewStyle: .default)
        progressView.tag = 104
        progressView.frame = CGRect(x: 0, y: 0, width: webView.width, height: webConfig.progressHeight)
        progressView.trackTintColor = webConfig.progressTrackTintColor
        progressView.progressTintColor = webConfig.progressTintColor
        webView.addSubview(progressView)
        progressView.isHidden = webConfig.isProgressHidden
        
        reloadDelegate()
    
    }
    
    func reloadDelegate(){
       webView.uiDelegate = self
       webView.navigationDelegate = self
    }
    /// 加载webView
    /// 改动处   采用额外传值方式
    func webloadType(_ target:AnyObject,_ loadType:WkwebLoadType,reqMap : [String:String] = [String:String]()) {
        self.target = target
        setupUI(webConfig:webConfig ?? WkwebViewConfig())
        switch loadType {
        case .URLString(let urltring):
            if let urlstr = URL(string: urltring){
                var request = URLRequest(url: urlstr)
                for map in reqMap {
                    request.setValue(map.value, forHTTPHeaderField: map.key)
                }
                 webView.load(request)
            }
        case .HTMLName(let string):
            loadHost(string: string)
        case .POST(let string, parameters: let postString):
            needLoadJSPOST = true
            let dictMap = postString.map({"\"\($0.key)\":\"\($0.value)\""})
            POSTJavaScript = "post('\(string)\',{\(dictMap.joined(separator: ","))})"
            loadHost(string: "WKJSPOST")
        case .HTMLString(let richContent):
            webView.loadHTMLString(richContent, baseURL: nil)
        }
    }
    
    fileprivate func loadHost(string:String) {
        let path = Bundle.main.path(forResource: string, ofType: "html")
        // 获得html内容
        do {
            let html = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
            // 加载js
            webView.loadHTMLString(html, baseURL: Bundle.main.bundleURL)
        } catch { }
    }
    
    /// 执行JavaScript代码
    /// 例如 run_JavaScript(script:"document.getElementById('someElement').innerText")
    ///
    /// Parameter titleStr: title字符串
    public func run_JavaScript(javaScript:String?) {
        if let javaScript = javaScript {
            webView.evaluateJavaScript(javaScript) { result,error in
                self.delegate?.webViewEvaluateJavaScript(result, error: error)
            }
        }
    }
    
    /// 刷新
    public func reload() {
        webView.reload()
    }
    /// 后退
    public func goBack() {
        webView.goBack()
    }
    /// 前进
    public func goForward() {
        webView.goForward()
    }
    
    /// 移除webView
    public func removeWebView(){
        if let scriptMessage = webConfig?.scriptMessageHandlerArray {
            _ = scriptMessage.map{webView.configuration.userContentController .removeScriptMessageHandler(forName: $0)}
        }
        webView.navigationDelegate = nil
        webView.uiDelegate = nil
        self.removeFromSuperview()
    }
    
    
    //请求链接处理
    fileprivate func pushCurrentSnapshotView(_ request: NSURLRequest) -> Void {
        // 连接是否为空
        guard let urlStr = snapShotsArray?.last else { return }
        // 转换成URL
        let url = URL(string: urlStr as! String)
        // 转换成NSURLRequest
        let lastRequest = NSURLRequest(url: url!)
        // 如果url是很奇怪的就不push
        if request.url?.absoluteString == "about:blank"{ return }
        // 如果url一样就不进行push
        if (lastRequest.url?.absoluteString == request.url?.absoluteString) {return}
        // snapshotView
        let currentSnapShotView = webView.snapshotView(afterScreenUpdates: true);
        //向数组添加字典
        snapShotsArray = [["request":request,"snapShotView":currentSnapShotView]]
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            // 设置进度条透明度
            progressView.alpha = CGFloat(1.0 - webView.estimatedProgress)
            // 给进度条添加进度和动画
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
            // 结束进度
            if Float(webView.estimatedProgress) >= 1.0{
                progressView.alpha = 0.0
                progressView .setProgress(0.0, animated: false)
            }
        }
    }
    
}

// MARK: - WKScriptMessageHandler
extension WebView: WKScriptMessageHandler{
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        print(message.name)
        if let scriptMessage = webConfig?.scriptMessageHandlerArray {
            self.delegate?.webViewUserContentController(scriptMessage, didReceive: message)
        }
    }
}
// MARK: - WKNavigationDelegate
extension WebView: WKNavigationDelegate{
    
    //服务器开始请求的时候调用
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if self.delegate != nil {
            self.delegate?.webView(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler)
        }
        else
        {
            decisionHandler(.allow)
        }
      
        /*
        let navigationURL = navigationAction.request.url?.absoluteString
        if let requestURL = navigationURL?.removingPercentEncoding {
            //拨打电话
            //兼容安卓的服务器写法:<a class = "mobile" href = "tel://电话号码"></a>
            //或者:<a class = "mobile" href = "tel:电话号码"></a>
            if requestURL.hasPrefix("tel://") {
                //取消WKWebView 打电话请求
                decisionHandler(.cancel);
                //用openURL 这个API打电话
                if let mobileURL:URL = URL(string: requestURL) {
                    UIApplication.shared.openURL(mobileURL)
                }
            }
            // 支付宝支付
            if requestURL.hasPrefix("alipay://") {
                
                var urlString = requestURL.mySubString(from: 23)
                urlString = urlString.replacingOccurrences(of: "alipays", with: webConfig!.aliPayScheme)
                
                if let strEncoding = urlString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                    
                    let payString = "alipay://alipayclient/?\(strEncoding)"
                    
                    if let urlalipayURL:URL = URL(string: payString) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(urlalipayURL, options: [:], completionHandler: { result in
                                self.webView.reload()
                            })
                        } else {
                            UIApplication.shared.openURL(urlalipayURL)
                        }
                    }
                }
            }
        }
        switch navigationAction.navigationType {
        case WKNavigationType.linkActivated:
            pushCurrentSnapshotView(navigationAction.request as NSURLRequest)
            break
        case WKNavigationType.formSubmitted:
            pushCurrentSnapshotView(navigationAction.request as NSURLRequest)
            break
        case WKNavigationType.backForward:
            break
        case WKNavigationType.reload:
            break
        case WKNavigationType.formResubmitted:
            break
        case WKNavigationType.other:
            pushCurrentSnapshotView(navigationAction.request as NSURLRequest)
            break
        }
        decisionHandler(.allow)
        */
    }
    
    //开始加载
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.delegate?.webView(webView, didStartProvisionalNavigation: navigation)
    }
    
    //这个是网页加载完成，导航的变化
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.delegate?.webView(webView, didFinish: navigation)
        // 判断是否需要加载（仅在第一次加载）
        if needLoadJSPOST == true {
            // 调用使用JS发送POST请求的方法
            run_JavaScript(javaScript: POSTJavaScript)
            // 将Flag置为NO（后面就不需要加载了）
            needLoadJSPOST = false
        }
    }
    
    //跳转失败的时候调用
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.delegate?.webView(webView, didFail: navigation, withError: error)
    }
    // 内容加载失败时候调用
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.delegate?.webView(webView, didFailProvisionalNavigation: navigation, withError: error)
        progressView.isHidden = true
    }
    
    // 打开新窗口委托
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

// MARK: - WKUIDelegate 不实现该代理方法 网页内调用弹窗时会抛出异常,导致程序崩溃
extension WebView: WKUIDelegate{
    
    // 获取js 里面的提示
    @objc  func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler()
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) -> Void in
            completionHandler()
        }))
         target?.present(alert, animated: true, completion: nil)
    }
    
    // js 信息的交流
    @objc  func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (_) -> Void in
            completionHandler(false)
        }))
         target?.present(alert, animated: true, completion: nil)
    }
    
    // 交互。可输入的文本。
    @objc  func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alert = UIAlertController(title: prompt, message: defaultText, preferredStyle: .alert)
        
        alert.addTextField { (textField: UITextField) -> Void in
            textField.textColor = UIColor.red
        }
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) -> Void in
            if let t = alert.textFields {
                if t.count > 0 {
                    let h = t[0].text ?? ""
                    completionHandler(h)
                }
            }
        }))
        target?.present(alert, animated: true, completion: nil)
    }
    
    @objc func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
}
