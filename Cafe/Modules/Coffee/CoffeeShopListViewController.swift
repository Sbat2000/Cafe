//
//  CoffeeShopListViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit

protocol CoffeeShopListViewProtocol: AnyObject {
}

class CoffeeShopListViewController: UIViewController {
    
    private let onMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("На карте", for: .normal)
        button.tintColor = UIColor(resource: .buttonTitle)
        button.layer.cornerRadius = 24.5
        button.backgroundColor = UIColor(resource: .darkBrown)
        button.addTarget(self, action: #selector(onMapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let coffeeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .gray
        return tableView
    }()
    
    // MARK: - Public
    var presenter: CoffeeShopListPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

// MARK: - Private functions
private extension CoffeeShopListViewController {
    func initialize() {
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Ближайшие кофейни"
        self.navigationController?.navigationBar.barTintColor = UIColor.gray
        self.navigationController?.navigationBar.tintColor = UIColor(resource: .brown)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(resource: .brown)]
        
        view.addSubview(onMapButton)
        view.addSubview(coffeeTableView)
    }
    
    func setupConstraints() {
        onMapButton.snp.makeConstraints { make in
            make.height.equalTo(47)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        coffeeTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(onMapButton.snp.top).inset(-20)
        }
    }
}

private extension CoffeeShopListViewController {
    @objc
    func onMapButtonTapped() {
        presenter?.onMapButtonTapped()
    }
}

// MARK: - CoffeeShopListViewProtocol
extension CoffeeShopListViewController: CoffeeShopListViewProtocol {
}
