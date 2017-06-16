//
//  ErrorHandle.swift
//  Offline Clean Architecture
//
//  Created by Abdullah Alhazmy on 1/22/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation
import Moya_ModelMapper
import Moya


enum ErrorHandler: Swift.Error {
    
    case none
    
    static func handleError(error: Swift.Error) -> Swift.Error{
        if case MoyaError.underlying(let error) = error {
            print(error)
        }else if case MoyaError.jsonMapping(let e) = error {
            print("ERROR : \(error), jsonMapping: \(e)")
        }else if case MoyaError.statusCode(let status) = error {
            print("ERROR : \(error), Status: \(status)")
        }else if case MoyaError.requestMapping(let value) = error {
            print("ERROR : \(error), requestMapping: \(value)")
        }
        return error
    }
}
