//
//  ResultReactor.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/29.
//

import ReactorKit
import RxCocoa

class ResultReactor: Reactor {
    let provider: ServiceProviderProtocol
    
    init(provider: ServiceProviderProtocol, value: Int) {
        self.provider = provider
        initialState = State(value: value)
    }
    
    enum Action {
        case actor
    }
    
    enum Mutation {
        case updateValue(Int)
    }
    
    struct State {
        var value: Int = 0
    }
    
    var initialState: State
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        let eventMutating = provider.valueService.event.flatMap { event -> Observable<Mutation> in
            switch event {
            case .updateValue(let value):
                return .just(.updateValue(value))
            }
        }
        
        return Observable.merge(mutation, eventMutating)
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateValue(let value):
            newState.value = value
        }
        return newState
    }
}
