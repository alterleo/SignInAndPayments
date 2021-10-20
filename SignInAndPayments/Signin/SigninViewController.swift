//
//  SigninViewController.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import UIKit

protocol SigninVCProtocol {
    func reloadView()
}

class SigninViewController: UIViewController {
    
    let mainView = SigninView()
    private lazy var presenter = SigninPresenter(view: self)
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped(sender: UIButton) {
        print(#function)
        mainView.button.configuration?.showsActivityIndicator = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() ) { [weak self] in
            self?.openPayments()
        }
    }
    
    func openPayments() {
        mainView.button.configuration?.showsActivityIndicator = false
        
        let vc = PaymentsViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}

extension SigninViewController: SigninVCProtocol {
    func reloadView() {
        
    }
}
