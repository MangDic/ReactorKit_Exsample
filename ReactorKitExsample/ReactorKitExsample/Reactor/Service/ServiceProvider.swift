//
//  ServiceProvider.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/12/01.
//

import Foundation

protocol ServiceProviderProtocol: class {
    var valueService: ValueServiceProtocol { get }
}

final class ServiceProvider: ServiceProviderProtocol {
    lazy var valueService: ValueServiceProtocol = ValueService(provider: self)
}
