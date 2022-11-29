//
//  ViewController.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/28.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class ViewController: UIViewController {
    // MARK: Properties
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    let actionTrigger = PublishRelay<ViewModelActionType>()
    let numberRelay = BehaviorRelay<Int>(value: 0)
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }

    // MARK: Binding()
    private func bind() {
        let req = viewModel.transform(req: ViewModel.Input(actionTrigger: actionTrigger.asObservable()))
        
        req.numberRelay.bind(to: self.numberRelay).disposed(by: disposeBag)
        
        // 바로 req.numberRelay를 구독해도 됨
        numberRelay.subscribe(onNext: { value in
            DispatchQueue.main.async {
                self.valueLabel.text = "\(value)"
            }
        }).disposed(by: disposeBag)
        
        // plusBtn을 클릭하면 actionTrigger에게 plus 액션을 취했다고 알려줌
        plusBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.actionTrigger.accept(.plus(value: 1))
        }).disposed(by: disposeBag)
        
        minusBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let `self` = self else { return }
            self.actionTrigger.accept(.minus(value: 1))
        }).disposed(by: disposeBag)
    }
    
    // MARK: View
    private func setupLayout() {
        view.addSubview(valueLabel)
        view.addSubview(btnStack)
        
        btnStack.addArrangedSubview(plusBtn)
        btnStack.addArrangedSubview(minusBtn)
        
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
}

