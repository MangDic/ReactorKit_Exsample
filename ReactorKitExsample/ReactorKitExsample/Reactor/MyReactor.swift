//
//  Reactor.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/28.
//

import ReactorKit
import RxCocoa

class MyReactor: Reactor {
    let provider: ServiceProviderProtocol
    
    init(provider: ServiceProviderProtocol) {
        self.provider = provider
    }
    
    enum Action {
        case load
        case increase(value: Int)
        case decrease(value: Int)
        case tapResult
    }
    
    enum Mutation {
        case loadData(value: Int)
        case increaseValue(value: Int)
        case decreaseValue(value: Int)
    }
    
    struct State {
        var value = 0
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .load:
            return Observable.just(self.loadData())
        case .increase(let value):
            return Observable.just(.increaseValue(value: value))
        case .decrease(let value):
            return Observable.just(.decreaseValue(value: value))
        case .tapResult:
            navigateToResultScreen()
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .loadData(let value):
            newState.value = value
        case .increaseValue(let value):
            newState.value += value
        case .decreaseValue(let value):
            newState.value -= value
        }
        
        return newState
    }
    
    // API호출 등의 로직을 이런식으로 작성한 뒤 reduce에서 state를 업데이트
    private func loadData() -> Mutation {
        let value = 3
        return .loadData(value: value)
    }
    
    private func navigateToResultScreen() {
        let vc = ResultViewController()
        let reactor = ResultReactor(provider: provider, value: currentState.value)
        vc.reactor = reactor
        AppDelegate.rootViewController.pushViewController(vc, animated: true)
    }
}
