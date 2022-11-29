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
import ReactorKit

class ResultViewController: UIViewController {
    // MARK: Properties
    var disposeBag = DisposeBag()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
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

extension ResultViewController: View {
    typealias Reactor = ResultReactor
    
    func bind(reactor: ResultReactor) {
        reactor.state
            .map { String($0.value) }
            .bind(to: valueLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
