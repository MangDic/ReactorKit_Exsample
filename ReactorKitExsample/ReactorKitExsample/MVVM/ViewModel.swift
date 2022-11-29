//
//  ViewModel.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/28.
//

import Foundation
import RxSwift
import RxCocoa

/// 해당 뷰에서 발생할 수 있는 액션들을 정의합니다.
enum ViewModelActionType {
    case plus(value: Int)
    case minus(value: Int)
}

class ViewModel {
    let disposeBag = DisposeBag()
    
    let numberRelay = BehaviorRelay<Int>(value: 0)
    
    struct Input {
        /// 각 ViewModelAction 이벤트 구독을 위한 Observable을 생성합니다.
        let actionTrigger: Observable<ViewModelActionType>
    }
    
    /// 특정 Action을 수행 후 결과값
    struct Output {
        let numberRelay: BehaviorRelay<Int>
    }
    
    /// 이 뷰모델을 사용하는 곳의 데이터와 바인딩을 위한 메소드 (여기서는 ViewController)
    func transform(req: Input) -> Output{
        req.actionTrigger.bind(onNext: runAction).disposed(by: disposeBag)
        return Output(numberRelay: numberRelay)
    }
    
    /// 각 Action에 대한 로직을 연결합니다.
    private func runAction(action: ViewModelActionType) {
        switch action {
        case .plus(let value): plusValue(value: value)
        case .minus(let value): minusValue(value: value)
        }
    }
    
    private func plusValue(value: Int){
        numberRelay.accept(numberRelay.value + value)
    }
    
    private func minusValue(value: Int){
        numberRelay.accept(numberRelay.value - value)
    }
}
