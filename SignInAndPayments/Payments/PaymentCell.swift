//
//  PaymentCell.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import UIKit

class PaymentCell: UITableViewCell {
    
    static let cellId = "paymentCell"
    
    let amountAndCurrency: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    let descriptionLabel = UILabel()
    let operationDate = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(amountAndCurrency)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(operationDate)
        
        amountAndCurrency.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        operationDate.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountAndCurrency.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            amountAndCurrency.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            amountAndCurrency.trailingAnchor.constraint(equalTo: operationDate.leadingAnchor, constant: -10),
            
            operationDate.widthAnchor.constraint(equalToConstant: 130),
            operationDate.centerYAnchor.constraint(equalTo: amountAndCurrency.centerYAnchor),
            operationDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            descriptionLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(payment: Payment) {
        amountAndCurrency.text = String(payment.amount) + " " + (payment.currency ?? "")
        descriptionLabel.text = payment.description
        operationDate.text = "20 october 2021"
    }
    
}
