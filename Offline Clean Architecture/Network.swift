//
//  Newtwork.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import Moya
import RxSwift

public enum NetworkPath : String {
    case posts = "/posts"
    case commments = "/commens"
}

public enum Network {
    
    case posts
    case comments
}

extension Network : TargetType {
    
    /// The target's base `URL`.
    var baseURL: URL {
        let url = URL(string: "http://jsonplaceholder.typicode.com")!
        return url
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        
        switch self {
        case .posts:
            return NetworkPath.posts
        case .commments:
            return NetworkPath.comments
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        
        return nil
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        return Data()
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}


let provider = RxMoyaProvider<Network>()


