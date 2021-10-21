//
//  SigninViewController.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import UIKit

protocol SigninVCProtocol {
    func openPayments(with token: String)
}

class SigninViewController: UIViewController {
    
    let mainView = SigninView()
    private lazy var presenter = SigninPresenter(view: self)
    var keyboardDismissTapGestrure: UIGestureRecognizer?
    
    override func loadView() {
        // Checking autologin
        presenter.chechAutologin()
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        mainView.loginTF.delegate = self
        mainView.passwordTF.delegate = self
        mainView.loginTF.becomeFirstResponder()
        
        // Регистрация обработчика появления клавиатуры
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWill), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    /// Клавиатура появилась - регистрируем обработчик таппа
    @objc func keyboardWill(_ notification: Notification) {
        if keyboardDismissTapGestrure == nil {
            keyboardDismissTapGestrure = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            keyboardDismissTapGestrure?.cancelsTouchesInView = false
            if let keyboardDismissTapGestrure = keyboardDismissTapGestrure {
                self.view.addGestureRecognizer(keyboardDismissTapGestrure)
            }
        }
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    /// button SignIn tapped
    @objc func buttonTapped(sender: UIButton) {
        
        mainView.button.configuration?.showsActivityIndicator = true
        
        guard let login = mainView.loginTF.text,
              let password = mainView.passwordTF.text else { return }
        
        presenter.signin(login: login, password: password) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.mainView.button.configuration?.showsActivityIndicator = false
                }
            }
            
            switch result {
            case .success(let token):
                self?.openPayments(with: token)
            case .failure(let error):
                print(error.localizedDescription)
                if error == NetworkError.wrongAuth {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Ошибка авторизации", message: "Проверьте введенные данные", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default))
                        self?.present(alert, animated: true)
                    }
                }
            }
        }
    }
    
    /// Запрет поворота экрана
    override var shouldAutorotate: Bool {
        return false
    }
}

// MARK: SigninVCProtocol
extension SigninViewController: SigninVCProtocol {
    
    func openPayments(with token: String) {
        DispatchQueue.main.async {
            let vc = PaymentsViewController()
            vc.token = token
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
    
    
// MARK: UITextFieldDelegate
extension SigninViewController: UITextFieldDelegate {
    
    /// Сокрытие клавиатуры при нажатии return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
