//
//  ResultReactor.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/29.
//

import ReactorKit
import RxCocoa

class ResultReactor: Reactor {
    init(value: Int) {
        initialState = State(value: value)
    }
    
    enum Action {
        case action
    }
    
    enum Mutation {
        case mutating
    }
    
    struct State {
        var value: Int = 0
    }
    
    var initialState: State
}
