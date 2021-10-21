//
//  SigninPresenter.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import Foundation

class SigninPresenter {
    var view: SigninVCProtocol?
    
    init(view: SigninVCProtocol) {
        self.view = view
    }
    
    /// Проверка авторегистрации
    func chechAutologin() {
        guard let token = UserSettings.token else { return }
        if !token.isEmpty {
            self.view?.openPayments(with: token)
        }
    }
    
    /// Авторизация пользователя
    func signin(login: String, password: String,
                completion: @escaping (Result<String, NetworkError>) -> ()) {
        Network.share.login(login: login, password: password) { result in
            switch result {
            case .success(let token):
                UserSettings.token = token
            case .failure(_):
                break
            }
            completion(result)
        }
    }
}
