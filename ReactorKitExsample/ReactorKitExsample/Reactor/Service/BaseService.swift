//
//  BaseService.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/12/01.
//

class BaseService {
    unowned let provider: ServiceProviderProtocol
    
    init(provider: ServiceProviderProtocol) {
        self.provider = provider
    }
}
