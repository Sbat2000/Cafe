//
//  CoffeeShopListViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit
import CoreLocation

protocol CoffeeShopListViewProtocol: AnyObject {
    func updateCoffeeTableView()
}

class CoffeeShopListViewController: UIViewController {
    
    private let onMapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("На карте", for: .normal)
        button.tintColor = UIColor(resource: .lightBrown)
        button.layer.cornerRadius = 24.5
        button.backgroundColor = UIColor(resource: .darkBrown)
        button.addTarget(self, action: #selector(onMapButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let coffeeTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: - Public
    var presenter: CoffeeShopListPresenterProtocol?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        presenter?.refreshCoffeeShops()
    }
}

// MARK: - Private functions
private extension CoffeeShopListViewController {
    func initialize() {
        setupUI()
        setupConstraints()
        setupTableView()
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
    
    func setupTableView() {
        coffeeTableView.dataSource = self
        coffeeTableView.delegate = self
        coffeeTableView.register(CoffeeShopTableViewCell.self, forCellReuseIdentifier: "CoffeeShopCell")
        coffeeTableView.separatorStyle = .none
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
    func updateCoffeeTableView() {
        coffeeTableView.reloadData()
    }
    
}

extension CoffeeShopListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getCoffeesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        71
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeShopCell", for: indexPath) as? CoffeeShopTableViewCell,
           let coffeeShop = presenter?.getCoffeeShop(at: indexPath) {
            cell.configure(with: coffeeShop)
            cell.selectionStyle = .none
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

extension CoffeeShopListViewController: CLLocationManagerDelegate {
    
}
