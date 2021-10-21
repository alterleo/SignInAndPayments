//
//  Network.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import Foundation

class Network {
    static let share = Network()
    let baseURL = "http://82.202.204.94/api-test/"
    
    private init() {}
    
    /// Запрос данных о платежах
    func fetchPayments(with token: String, completion: @escaping (Result<[PaymentResponse], Error>)->()) {
        guard let url = URL(string: baseURL + "payments?token=\(token)") else { return }
        let boundary = UUID().uuidString
        var request = createRequest(url: url, boundary: boundary)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Status code is not 200 =(")
                completion(.failure(NetworkError.statusCodeIsNot200))
                return
            } else {
                let decoder = JSONDecoder()
                if let payments = try? decoder.decode(PaymentsModel.self, from: data) {
                    completion(.success(payments.response))
                }
            }
        }.resume()
        
    }
    
    /// Авторизация пользователя
    func login(login: String, password: String, completion: @escaping (Result<String, NetworkError>)->() ) {
        
        guard let url = URL(string: baseURL + "login") else { return }
        let boundary = UUID().uuidString
        var request = createRequest(url: url, boundary: boundary)
        request.httpMethod = "POST"
        
        let parameters = ["login": "\(login)", "password": "\(password)"]
        request.httpBody = createDataBody(parameters: parameters, boundary: boundary)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.responseError))
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("Status code is not 200 =(")
                completion(.failure(NetworkError.statusCodeIsNot200))
                return
            } else {
                let decoder = JSONDecoder()
                if let tokenModel = try? decoder.decode(SigninModel.self, from: data) {
                    completion(.success(tokenModel.response.token))
                } else {
                    completion(.failure(NetworkError.wrongAuth))
                }
            }
        }.resume()
    }
    
    private func createRequest(url: URL, boundary: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("12345", forHTTPHeaderField: "app-key")
        request.addValue("1", forHTTPHeaderField: "v")
        return request
    }
    
    private func createDataBody(parameters: [String: String], boundary: String) -> Data {
        var data = Data()
        for (key, value) in parameters {
            data.append("--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(key)\";\r\n\r\n".data(using: .utf8)!)
            data.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return data
    }
}

// MARK: - Payments Model
struct PaymentsModel: Codable {
    let success: String
    let response: [PaymentResponse]
}

struct PaymentResponse: Codable {
    let desc: String
    let amount: Amount
    let currency: String?
    let created: Int
}

enum Amount: Codable {
    case double(Double)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Double.self) {
            self = .double(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Amount.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Amount"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .double(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - SignIn Model
struct SigninModel: Decodable {
    let success: String
    let response: Token
}

struct Token: Decodable {
    let token: String
}

enum NetworkError: Error {
    case statusCodeIsNot200
    case wrongAuth
    case responseError
}
