//
//  PaymentsViewController.swift
//  SignInAndPayments
//
//  Created by Alexander Konovalov on 20.10.2021.
//

import UIKit

protocol PaymentsVCProtocol {
    func reloadView()
}

class PaymentsViewController: UIViewController {
    
    private lazy var presenter = PaymentsPresenter(view: self)
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.cellId)
        table.isHidden = true
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.fetchPayments()
    }
    
    func setupView() {
        view.backgroundColor = .white
        navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.title = "Payments"
        let button = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutButton))
        button.tintColor = .gray
        navigationItem.rightBarButtonItem = button
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    @objc func logoutButton(sender: UIButton) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
}

// MARK: PaymentsVCProtocol
extension PaymentsViewController: PaymentsVCProtocol {
    func reloadView() {
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension PaymentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.cellId, for: indexPath) as! PaymentCell
        cell.configure(payment: presenter.payments[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
