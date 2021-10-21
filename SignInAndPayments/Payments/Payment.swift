//
//  Payment.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import Foundation

// Модель для отображения
struct Payment: Decodable {
    let description: String
    let amount: String
    let currency: String?
    let created: String?
}
