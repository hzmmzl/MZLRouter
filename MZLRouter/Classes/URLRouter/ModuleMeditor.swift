//
//  ModuleMeditor.swift
//  Pods
//
//  Created by minzhaolin on 2021/4/22.
//

import UIKit


/// 路由协议
let meditorScheme = "mzl://"


class ModuleMeditor: NSObject {
    
    /// 注册模块
    /// - Parameter connector: 模块
    static func registerModuleConnector(connector: MZLRouter) {
        
    }
//    MARK: 跳转无回调的路由
    
    /// 跳转链接
    /// - Parameter url: url
    /// - Returns: 返回处理结果是否成功跳转
    static func route(url: URL) -> Bool {
        return route(url: url, params: nil)
    }
    
    /// 跳转链接
    /// - Parameter url: url
    ///   - params: 参数
    /// - Returns: 返回处理结果是否成功跳转
    static func route(url: URL, params: Dictionary<String, Any>?, callBack: MZLRouterCallBack? = nil) -> Bool {
        let result = analytic(url: url, params: params)
        if result?.method?.count == 0 {
            return false
        }
        
        return jumpTo(module: result?.module, method: result!.method!, param: result?.params, callBack: callBack)
    }
    
    //    MARK: 跳转带回调的路由
    /// 包含回调的跳转，此方法包含跳转无回调路由的全部功能， context中包含参数 同时包含一个回调，此回调用于处理A类中注册路由，B类中使用，同时需要用到B类中的方法或者参数等（需要用到A类中注册回调的结果）
    /// - Parameters:
    ///   - url: url
    ///   - context: 上下文等
    /// - Returns: 返回处理结果是否成功跳转
    static func route(url: URL, context: ModuleRouteContext) -> Bool {
        return route(url: url, params: context.params, callBack: context.callBack)
    }
    
    
    /// 根据模块名，方法名， 参数等跳转到相应方法
    /// - Parameters:
    ///   - module: 模块名
    ///   - method: 方法名
    ///   - param: 参数
    /// - Returns: 是否跳转成功
    static func jumpTo(module: String?, method: String, param: Dictionary<String, Any>?, callBack: MZLRouterCallBack? = nil) -> Bool {
        
        if module?.count == 0 || module == nil {
//            遍历所有字典查找是否存在该方法
            let routes = MZLRouter.shared.routes
            let dic = routes.values
            // 遍历所有
            for obj in dic {
                for m in obj.keys {
                    if method == m {
                        // 找到该方法执行并退出循环
                        let handler: MZLRouterHandler = obj[method] as! MZLRouterHandler
//                        MARK: 待完成
                        // 获取到回调block
                        // 回调
                        handler(param, callBack)
                        return true
                        
                    }
                }
            }
            
            return false
        }
        
//        有模块名
        let keyValueDic = MZLRouter.shared.routes[module!]
        if keyValueDic?.keys.contains(method) ?? false {
            let handler: MZLRouterHandler = keyValueDic?[method] as! MZLRouterHandler
            handler(param, callBack)
            return true
        }
        return false
    }
    
    
    /// url是否可以跳转
    /// - Parameter url: url
    /// - Returns: 是否可以跳转
    static func canOpenRouteUrl(url: URL) -> Bool {
        return true
    }
    
    
    /// 解析url
    /// - Parameters:
    ///   - url: url
    ///   - params: 参数
    /// - Returns: 模块名，方法名，参数
    static func analytic(url: URL, params: Dictionary<String, Any>?) -> (module: String?, method: String?, params: Dictionary<String, Any>?)? {
        // 解析url，解析成method，和参数形式
        let urlStr = url.absoluteString
        let hasRange = urlStr.range(of: meditorScheme)?.isEmpty
        if hasRange == true {
            return nil
        }
        
        /* 解析url
         路由格式：
         mzl://模块名/方法名?id=x&name=x&password=x
         scheme://host/path?query
         */
        
        // 获取方法名
        var methodName = url.path
        if methodName.contains("/") {
            methodName = methodName.replacingOccurrences(of: "/", with: "")
        }
        // 获取模块名称（模块名称可空如果为空则遍历所有字典查找不建议为空，如果非空则查找key为模块的字典）url.host一定有值，可能为方法名也可能为模块名取决于methodName是否可以取到值
        var moduleName = url.host
        
        if methodName.count == 0 && moduleName?.count == 0 {
            return nil
        }
        
        // 获取url中的参数
        let urlParams = (url.query?.count != 0 && url.query != nil) ? getURLParameters(url.query!) : nil
        // 将url中的参数与拼接传递过来的params参数一起作为完整参数
        var totalParams = urlParams
        if urlParams == nil {
            totalParams = [String: Any]()
        }
        
        if params != nil {
            
            for (key, value) in params! {
                totalParams?.updateValue(value, forKey: key)
            }
        }
        
        // 如果方法名为空则模块名为方法名，无模块名
        if methodName.count == 0 {
            methodName = moduleName!
            moduleName = nil
        }
        return (moduleName, methodName, totalParams)
        
    }
    
    
    /// 获取url中的参数
    /// - Parameter query: url中参数组成
    /// - Returns: 参数字典
    static func getURLParameters(_ query: String) -> Dictionary<String, Any> {
        var params = [String: Any]()
        //          - some : "id=x&name=x&password=x"
        //          - some : "boardID=5&ID=24618&page=1"
        let urlComponents = query.components(separatedBy: "&")
        for keyValue in urlComponents {
            let keyValues = keyValue.components(separatedBy: "=")
            let key = keyValues.first?.removingPercentEncoding
            let value = keyValues.last?.removingPercentEncoding
            if key?.count == 0 || value?.count == 0 {
                continue
            }
            
            params[key!] = value!
        }
        
        return params
    }

}
