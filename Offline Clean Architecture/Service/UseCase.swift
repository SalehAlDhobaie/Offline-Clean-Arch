//
//  UseCase.swift
//  Offline Clean Architecture
//
//  Created by Saleh AlDhobaie on 1/21/17.
//  Copyright © 2017 Saleh AlDhobaie. All rights reserved.
//

import Foundation

public protocol UseCaseRequest {
    
}

public struct EmptyUseCaseRequest : UseCaseRequest {
    
}


public protocol UseCase {
    associatedtype Element
    func execute(request: UseCaseRequest) -> Element
}
