//
//  Reactor.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/28.
//

import ReactorKit
import RxCocoa

class MyReactor: Reactor {
    enum Action {
        case increase(value: Int)
        case decrease(value: Int)
        case result
    }
    
    enum Mutation {
        case increaseValue(value: Int)
        case decreaseValue(value: Int)
    }
    
    struct State {
        let valueRelay = BehaviorRelay<Int>(value: 0)
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase(let value):
            return Observable.just(.increaseValue(value: value))
        case .decrease(let value):
            return Observable.just(.decreaseValue(value: value))
        case .result:
            navigateToResultScreen()
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        let newState = state
        
        switch mutation {
        case .increaseValue(let value):
            newState.valueRelay.accept(newState.valueRelay.value + value)
        case .decreaseValue(value: let value):
            newState.valueRelay.accept(newState.valueRelay.value - value)
        }
        
        return newState
    }
    
    private func navigateToResultScreen() {
        let vc = ResultViewController()
        vc.setupDI(valueRealy: initialState.valueRelay)
        AppDelegate.rootViewController.pushViewController(vc, animated: true)
    }
}
