//
//  PaymentsPresenter.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import Foundation

class PaymentsPresenter {
    weak var view: PaymentsVCProtocol?
    
    var payments = [Payment]()
    
    init(view: PaymentsVCProtocol) {
        self.view = view
    }
    
    /// Clear token in UserDeafults
    func logout(completion: () -> ()) {
        UserSettings.token = ""
        completion()
    }
    
    /// Fetch payments using network
    func fetchPayments(with token: String) {
        
        Network.share.fetchPayments(with: token) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let paymentResponse):
                self.makeDesiredFormat(with: paymentResponse)
            case .failure(let error):
                print(error)
            }
            
            self.view?.reloadView()
        }
    }
    
    /// Приводим полученный массив к подходящему виду для отображения
    private func makeDesiredFormat(with paymentResponse: [PaymentResponse]) {
        self.payments = paymentResponse.map { payment in
            
            var dateString: String?
            
            if payment.created > 0 {
                let date = Date(timeIntervalSince1970: TimeInterval(payment.created))
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
                dateString = dateFormatter.string(from: date)
            }
            
            var amountString = ""
            
            switch payment.amount {
            case Amount.double(let amount):
                amountString = String(amount)
            case Amount.string(let amount):
                amountString = String(amount)
            }
            
            return Payment(description: payment.desc,
                           amount: amountString,
                           currency: payment.currency,
                           created: dateString)
        }
    }
}
