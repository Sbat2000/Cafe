//
//  OrderViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import UIKit

protocol OrderViewProtocol: AnyObject {
}

class OrderViewController: UIViewController {
    // MARK: - Public
    var presenter: OrderPresenterProtocol?
    
    //MARK: -
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оплатить", for: .normal)
        button.tintColor = UIColor(resource: .lightBrown)
        button.layer.cornerRadius = 24.5
        button.backgroundColor = UIColor(resource: .darkBrown)
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let orderTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    private let thanksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = UIColor(resource: .brown)
        label.textAlignment = .center
        label.text = "Время ожидания заказа\n15 минут!\nСпасибо, что выбрали нас!"
        return label
    }()

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension OrderViewController {
    func initialize() {
        setupUI()
        setupConstraints()
        setupTableView()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Ваш заказ"
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.navigationController?.navigationBar.tintColor = UIColor(resource: .brown)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(resource: .brown)]
        
        view.addSubview(payButton)
        view.addSubview(thanksLabel)
        view.addSubview(orderTableView)
    }
    
    func setupConstraints() {
        payButton.snp.makeConstraints { make in
            make.height.equalTo(47)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        thanksLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(13)
            make.bottom.equalTo(payButton.snp.top).inset(-160)
        }
        
        orderTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(thanksLabel.snp.top).inset(-10)
        }
    }
    
    func setupTableView() {
        orderTableView.dataSource = self
        orderTableView.delegate = self
        orderTableView.register(OrderTableViewCell.self, forCellReuseIdentifier: "OrderTableViewCell")
        orderTableView.separatorStyle = .none
    }
    
    @objc
    func payButtonTapped() {
        
    }
}

// MARK: - OrderViewProtocol
extension OrderViewController: OrderViewProtocol {
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        71
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getTotalQuantity() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath) as? OrderTableViewCell,
           let orderItem = presenter?.fetchOrderItem(at: indexPath) {
            cell.configure(with: orderItem)
            cell.selectionStyle = .none
            cell.delegate = presenter
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
