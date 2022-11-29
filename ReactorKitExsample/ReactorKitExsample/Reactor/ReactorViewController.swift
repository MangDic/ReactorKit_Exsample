//
//  ReactorViewController.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/28.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then

class ReactorViewController: UIViewController {
    // MARK: Properties
    var disposeBag = DisposeBag()
    let numberRelay = BehaviorRelay<Int>(value: 0)
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupReactor()
    }
    
    // MARK: Method
    private func setupReactor() {
        self.reactor = MyReactor()
    }
    
    // MARK: View
    private func setupLayout() {
        view.addSubview(valueLabel)
        view.addSubview(btnStack)
        
        btnStack.addArrangedSubview(plusBtn)
        btnStack.addArrangedSubview(minusBtn)
        btnStack.addArrangedSubview(resultBtn)
        
        valueLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(50)
        }
        
        btnStack.snp.makeConstraints {
            $0.top.equalTo(valueLabel.snp.bottom).offset(10)
            $0.height.equalTo(30)
            $0.leading.trailing.equalToSuperview().inset(50)
        }
    }
    
    lazy var valueLabel = UILabel().then {
        $0.textAlignment = .center
    }
    lazy var btnStack = UIStackView().then {
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    lazy var plusBtn = UIButton().then {
        $0.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.setTitle("+", for: .normal)
    }
    lazy var minusBtn = UIButton().then {
        $0.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.setTitle("-", for: .normal)
    }
    lazy var resultBtn = UIButton().then {
        $0.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        $0.layer.cornerRadius = 8
        $0.setTitle("result", for: .normal)
    }
}

extension ReactorViewController: View {
    typealias Reactor = MyReactor
    
    func bind(reactor: Reactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: MyReactor) {
        plusBtn.rx.tap
            .map { .increase(value: 1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        minusBtn.rx.tap
            .map { .decrease(value: 1) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        resultBtn.rx.tap
            .map { .result }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: MyReactor) {
        reactor.state
            .map{ String($0.valueRelay.value) }
            .distinctUntilChanged()
            .bind(to: self.valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
