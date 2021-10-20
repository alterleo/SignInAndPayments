//
//  PaymentsPresenter.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import Foundation

class PaymentsPresenter {
    var view: PaymentsVCProtocol?
    
    var payments = [Payment]()
    
    init(view: PaymentsVCProtocol) {
        self.view = view
    }
    
    func fetchPayments() {
        payments.append(Payment(description: "Operation description-1", amount: 11.6, currency: "BTC", created: Date()))
        payments.append(Payment(description: "Operation description-2", amount: 1100000000.000006, currency: "ETH", created: Date()))
        payments.append(Payment(description: "Operation description-3", amount: 11.6, currency: "LTC", created: Date()))
        payments.append(Payment(description: "Operation description-4", amount: 11.6, currency: "SXRP", created: Date()))
        payments.append(Payment(description: "Operation description-5", amount: 11.6, currency: "TRON", created: Date()))
        payments.append(Payment(description: "Operation description-6", amount: 1200000.006, currency: "USDT", created: Date()))
        payments.append(Payment(description: "Operation description-7", amount: 11.6, currency: "BTC", created: Date()))
        payments.append(Payment(description: "Operation description-8", amount: 11.6, currency: "LTC", created: Date()))
        payments.append(Payment(description: "Operation description-9", amount: 11.6, currency: "USDT", created: Date()))
        payments.append(Payment(description: "Operation description-10", amount: 11.6, currency: "SXRP", created: Date()))
        
        view?.reloadView()
    }
}
