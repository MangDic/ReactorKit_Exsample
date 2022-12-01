//
//  ValueService.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/12/01.
//

import RxSwift

enum ValueEvent {
    case updateValue(Int)
}

protocol ValueServiceProtocol {
    var event: PublishSubject<ValueEvent> { get }
    func updateValue(to value: Int) -> Observable<Int>
}

class ValueService: BaseService, ValueServiceProtocol {
    let event = PublishSubject<ValueEvent>()
    func updateValue(to value: Int) -> Observable<Int> {
        event.onNext(.updateValue(value))
        return .just(value)
    }
}
