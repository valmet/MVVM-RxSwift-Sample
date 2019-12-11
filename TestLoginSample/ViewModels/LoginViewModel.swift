//
//  LoginViewModels.swift
//  TestLoginSample
//
//  Created by valmet on 2019/12/11.
//  Copyright © 2019 valmet. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class LoginViewModel {
    let userId = BehaviorRelay<String>(value: "")
    let password = BehaviorRelay<String>(value: "")
    let isLoading = BehaviorRelay<Bool>(value: false)
    
    private let model = LoginModel()
    private var disposeBag = DisposeBag()
    
    init() {
        self.model.setup(viewModel: self)
    }
}

extension LoginViewModel {
    func login(completion: @escaping ((Error?) -> Void)) {
        self.model.login(completion: completion)
    }
}
