//
//  MZLRouter.swift
//  Pods
//
//  Created by minzhaolin on 2021/4/22.
//

import UIKit

typealias MZLRouterCallBack = (Any) -> ()

typealias MZLRouterHandler = (Dictionary<String, Any>?, MZLRouterCallBack?) -> ()


final class MZLRouter: NSObject {
    
    static let shared = MZLRouter()
    private override init() {}
    
    
    /* 格式
     moduleName: {
     method: {
     do:
     callBack:
     }
     }
     **/
    lazy var routes: Dictionary<String, Dictionary<String, Any>> = {
        let dic = Dictionary<String, Dictionary<String, Any>>()
        return dic
    }()
    
}


// 注册方法
extension MZLRouter {
    
    /// 注册url
    /// - Parameters:
    ///   - url: url
    ///   - handler: 对应处理
    static func register(method: String, handler: MZLRouterHandler?) {
        if method.count == 0 || handler == nil {
            MZLRouter.shared.failToRouteMethod(method: method, params: nil)
            return
        }
        
        MZLRouter.shared.addUrl(method, handler)
    }
    
    
    func addUrl(_ method: String, _ handler: MZLRouterHandler?) {
        //        处理当前是那个模块
        let className = type(of: self).description().components(separatedBy: ".").last!.lowercased()
        
        var dict = self.routes[className]
        if dict == nil {
            dict = [String: Any]()
        }
        
        dict?.updateValue(handler!, forKey: method)
        self.routes.updateValue(dict!, forKey: className)
    }
    
    // 注册失败
    func failToRouteMethod(method: String, params: Dictionary<String, Any>?) {
        
    }
}
