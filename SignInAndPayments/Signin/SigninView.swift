//
//  SigninView.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import UIKit

class SigninView: UIView {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "USER LOGIN"
        label.textColor = .systemIndigo
        label.font = UIFont.systemFont(ofSize: 40)
        return label
    }()
    
    let loginTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let passwordTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.configuration = .filled()
        
        var attrText = AttributedString("Sign In")
        attrText.font = UIFont.systemFont(ofSize: 30)
        button.configuration?.attributedTitle = attrText
        button.configuration?.baseBackgroundColor = .systemIndigo
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        button.configuration?.cornerStyle = .capsule
        button.configuration?.imagePadding = 20
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        addSubview(label)
        addSubview(loginTF)
        addSubview(passwordTF)
        addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        loginTF.translatesAutoresizingMaskIntoConstraints = false
        passwordTF.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor, constant: 220),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            loginTF.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 100),
            loginTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: 25),
            passwordTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            passwordTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 80),
            button.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -292),
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
