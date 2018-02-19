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
    case comments = "/commens"
}

public enum Network {
    
    case posts
    case comments
}

extension Network : TargetType {
    
    /// The target's base `URL`.
    public var baseURL: URL {
        let url = URL(string: "http://jsonplaceholder.typicode.com")!
        return url
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    public var path: String {
        
        switch self {
        case .posts:
            return NetworkPath.posts.rawValue
        case .comments:
            return NetworkPath.comments.rawValue
        }
    }
    
    /// The HTTP method used in the request.
    public var method: Moya.Method {
        return .get
    }
    
    /// The parameters to be incoded in the request.
    public var parameters: [String: Any]? {
        
        return nil
    }
    
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return JSONEncoding()
    }
    
    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return Data()
    }
    
    /// The type of HTTP task to be performed.
    public var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    public var validate: Bool {
        return false
    }
}


let provider = RxMoyaProvider<Network>()


