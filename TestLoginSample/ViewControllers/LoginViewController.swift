//
//  LoginViewController.swift
//  TestLoginSample
//
//  Created by valmet on 2019/12/11.
//  Copyright © 2019 valmet. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private var userIdTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var loginButton: UIButton!

    private let viewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViewModel()
        self.setupEvent()
    }
}

extension LoginViewController {
    private func setupViewModel() {
        self.userIdTextField.rx.text.orEmpty
            .bind { [weak self] in
                self?.viewModel.userId.accept($0)
        }
        .disposed(by: self.disposeBag)
        self.passwordTextField.rx.text.orEmpty
            .bind { [weak self] in
                self?.viewModel.password.accept($0)
        }
        .disposed(by: self.disposeBag)
        self.viewModel.isLoading
            .bind { [weak self] in
                if $0 {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
        }
        .disposed(by: self.disposeBag)
    }
    
    private func setupEvent() {
        self.loginButton.rx.tap
            .bind { [weak self] in
                self?.viewModel.login { [weak self] in self?.didLogin(error: $0) }
            }
        .disposed(by: self.disposeBag)
    }
    
    private func didLogin(error: Error?) {
        let alertController = UIAlertController(title: error == nil ? "OK" : "NG", message: "", preferredStyle: .alert)
        alertController.addAction(
            .init(title: "OK", style: .default)
        )
        self.present(alertController, animated: true, completion: nil)
    }
}
