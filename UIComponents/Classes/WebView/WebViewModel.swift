//
//  WebViewModel.swift
//  zhouyi
//
//  Created by 聂飞安 on 2019/7/23.
//  Copyright © 2019 聂飞安. All rights reserved.
//

import UIKit
import NFAToolkit

public enum WEB_TYPE : Int {
    case 本地网页 = 0, 网页链接, 富文本
}

public class WebViewModel : NSObject {
    
    public var addingPercentEncoding : Bool = true
    public var title : String?
    public var subTitle : String?
    public var type : Int!
    public var isBinAL : Bool! = false
    public var subVo : AnyObject?
    
    // 本地文件扩展名，如html
    public var localFileType : String?

    
    public func getWebType() -> Int{
        return type
    }
    
    // 本地文件名称，不含扩展名
    public var localFile : String? {
        didSet {
            type = WEB_TYPE.本地网页.rawValue
        }
    }
    
    // 网址：当type = 网页链接时设置
    public var website : String? {
        didSet {
            type = WEB_TYPE.网页链接.rawValue
        }
    }
    
    // 富文本
    public var richContent : String? {
        didSet {
            type = WEB_TYPE.富文本.rawValue
        }
    }
    
    
    lazy var imageFItStyle : String = {
          let html = "<html><head><meta charset=\"utf-8\">"
              + "<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"
              + "<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"
              + "<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"
              + "<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"
              + "<style>img{width:99%;height:auto}</style>"
              + "<style>table{width:99%;}</style>"
              + "<title>webview</title>"
          return html
      }()
      
      lazy var imageAPPWidthFItStyle : String = {
          let html = "<html><head><meta charset=\"utf-8\">"
              + "<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"
              + "<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"
              + "<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"
              + "<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"
              + "<style>img{width:\(AppWidth * 0.9) !important;height:auto}</style></head>"
              + "<style>table{width:99%;}</style>"
              + "<title>webview</title>"
          return html
      }()

      
      lazy var imageFItAPPWidthMethod : String = {
          let html = "var script = document.createElement('script');"
              + "script.type = 'text/javascript';"
              + "script.text = \"function ResizeImages() { "
              + "var myimg,oldwidth;"
              + "var maxwidth = \(AppWidth - 40);"
              + "for(i=0;i <document.images.length;i++){"
              + "myimg = document.images[i];"
              + "if(myimg.width > maxwidth){"
              + "oldwidth = myimg.width;"
              + "myimg.width = maxwidth;"
              + "}"
              + "}"
              + "}\";"
              + "document.getElementsByTagName('head')[0].appendChild(script);"
          return html
      }()
      
      lazy var useImageFItAPPWidthMethod : String = {
          return "ResizeImages();"
      }()
      
      lazy var setTablesWidthMethod : String = {
         let html = "function SetTablesWidth() {"
          + "var objs = document.getElementsByTagName('table');"
          + "for(i=0;i<objs.length;i++){"
          + "objs[i].style.width = '100%';"
          + "objs[i].style.margin = 'auto auto auto auto';"
          + "}"
          + "};"
          return html
      }()
      
      lazy var setTablesWidth : String = {
          return "SetTablesWidth();"
      }()
      
      lazy var addAccountingJSonLoadFinish : String = {
          return "function onLoadFinish(){"
              + "var isHtmlAudioPaused = false;"
              + " var hasAudio = false;"
              + " if (document.getElementsByTagName('audio').length > 0)"
              + "{hasAudio = true;};"
              + "var isHtmVideoPaused = false;"
              + "var hasVideo = false;"
              + " if (document.getElementsByTagName('video').length > 0) "
              + "{hasVideo = true;}}"
      }()
      
      lazy var addAccountingJSonPause : String = {
          return "function onPause(){"
              + " if (hasAudio) {"
              + "var audio = document.getElementsByTagName('audio')[0];"
              + "isHtmlAudioPaused = audio.paused"
              + "if (!audio.paused) {"
              + " try { "
              + "audio.pause();"
              + "} catch (err) {}}}"
              + " if (hasAudio) {"
              + "var audio = document.getElementsByTagName('video')[0];"
              + "isHtmlAudioPaused = audio.paused"
              + "if (!audio.paused) {"
              + " try { "
              + "audio.pause();"
              + "} catch (err) {}}}"
              + "}"
      }()
      
      lazy var addAccountingJSonResume : String = {
          return "function onResume(){"
              + " if (hasAudio && audio) {"
              + "if (!isHtmlAudioPaused && audio.paused) {"
              + " try { "
              + "audio.play();"
              + "} catch (err) {}}}"
              + " if (hasAudio && video) {"
              + "if (!isHtmlAudioPaused && video.paused) {"
              + " try { "
              + "audio.play();"
              + "} catch (err) {}}}"
              + "}"
      }()
      

      lazy var useResume : String = {
          return "onResume();"
      }()
      lazy var usePause : String = {
          return "onPause();"
      }()
    
}

