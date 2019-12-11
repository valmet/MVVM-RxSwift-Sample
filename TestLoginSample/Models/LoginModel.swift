//
//  LoginModel.swift
//  TestLoginSample
//
//  Created by valmet on 2019/12/11.
//  Copyright © 2019 valmet. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginModel {
    private weak var viewModel: LoginViewModel?
    private let disposeBag = DisposeBag()
    
    func setup(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }

    func login(completion: @escaping ((Error?) -> Void)) {
        guard let userId = self.viewModel?.userId.value, !userId.isEmpty else {
            completion(AuthError.requireUserId)
            return
        }
        
        guard let password = self.viewModel?.password.value, !password.isEmpty else {
            completion(AuthError.requirePassword)
            return
        }

        self.viewModel?.isLoading.accept(false)

        LoginAPI.login(userId: userId, password: password)
            .subscribe(
                onNext: { response in
                    completion(nil)
                }, onError: { error in
                    completion(error)
            }, onCompleted: { [weak self] in
                self?.viewModel?.isLoading.accept(false)
            })
            .disposed(by: self.disposeBag)
    }
}

class LoginAPI {
    class func login(userId: String, password: String) -> Observable<String> {
        return Observable<String>.create { observer -> Disposable in
            if !userId.isEmpty && !password.isEmpty {
                observer.on(.next("OK"))
            } else {
                observer.on(.error(NSError.init()))
            }
            observer.on(.completed)
            return Disposables.create()
        }
    }
}
