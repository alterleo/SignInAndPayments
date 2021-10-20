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
}
