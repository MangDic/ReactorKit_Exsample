//
//  ResultViewController.swift
//  ReactorKitExsample
//
//  Created by 이명직 on 2022/11/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class ResultViewController: UIViewController {
    // MARK: Properties
    var disposeBag = DisposeBag()
    let valueRealy = BehaviorRelay<Int>(value: 0)
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        bind()
    }
    
    // MARK: Binding
    private func bind() {
        valueRealy
            .map { String($0) }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // MARK: Dependency Injection
    func setupDI(valueRealy: BehaviorRelay<Int>) {
        valueRealy.bind(to: self.valueRealy).disposed(by: disposeBag)
    }
    
    // MARK: View
    lazy var valueLabel = UILabel().then {
        $0.textAlignment = .center
    }
    
    private func setupLayout() {
        view.addSubview(valueLabel)
        valueLabel.snp.makeConstraints {
            $0.center.leading.trailing.equalToSuperview()
        }
    }
}
