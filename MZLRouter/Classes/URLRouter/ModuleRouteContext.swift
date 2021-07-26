//
//  ModuleRouteContext.swift
//  Pods
//
//  Created by minzhaolin on 2021/4/22.
//

import UIKit

//typealias ModuleCallBack = ((Any) -> ())?

class ModuleRouteContext: NSObject {
    
    var params: Dictionary<String, Any>?
    
    var callBack: MZLRouterCallBack?
    
    
    init(param: Dictionary<String, Any>?, moduleCallBack: MZLRouterCallBack?) {
        super.init()
        
        params = param
        callBack = moduleCallBack
    }
}
