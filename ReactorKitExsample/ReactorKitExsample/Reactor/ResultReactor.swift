//
//  ResultReactor.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/29.
//

import ReactorKit
import RxCocoa

class ResultReactor: Reactor {
    init(valueRelay: BehaviorRelay<Int>) {
        initialState = State(valueRelay: valueRelay)
    }
    
    enum Action {
        case action
    }
    
    enum Mutation {
        case mutating
    }
    
    struct State {
        let valueRelay: BehaviorRelay<Int>
    }
    
    var initialState: State
}
