//
//  MenuViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 25.12.2023
//

import UIKit

protocol MenuViewProtocol: AnyObject {
    func updateMenu()
}

class MenuViewController: UIViewController {
    
    //MARK: - UI Elements
    private lazy var goToPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Перейти к оплате", for: .normal)
        button.tintColor = UIColor(resource: .lightBrown)
        button.layer.cornerRadius = 24.5
        button.backgroundColor = UIColor(resource: .darkBrown)
        button.addTarget(self, action: #selector(goToPayButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16 //
        layout.minimumInteritemSpacing = 16
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    // MARK: - Public
    var presenter: MenuPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuCollectionView.reloadData()
    }
    
    deinit {
        presenter?.menuViewControllerDeinit()
    }
}

// MARK: - Private functions
private extension MenuViewController {
    func initialize() {
        view.backgroundColor = .white
        setupUI()
        setupMenuCollectionView()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(goToPayButton)
        view.addSubview(menuCollectionView)
    }
    
    func setupConstraints() {
        goToPayButton.snp.makeConstraints { make in
            make.height.equalTo(47)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(30)
        }
        
        menuCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(goToPayButton.snp.top).inset(-20)
        }
    }
    
    func setupMenuCollectionView() {
        menuCollectionView.dataSource = self
        menuCollectionView.delegate = self
        menuCollectionView.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
    }
    
    @objc
    func goToPayButtonTapped() {
        presenter?.goToPayButtonTapped()
    }
}

// MARK: - MenuViewProtocol
extension MenuViewController: MenuViewProtocol {
    func updateMenu() {
        menuCollectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 18
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2 + 68)
    }
}


//MARK: - UICollectionViewDataSource

extension MenuViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.getMenuItemsCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuItemCell", for: indexPath) as? MenuItemCell else {
            fatalError("Unable to dequeue MenuItemCell")
        }
        guard let menuItem = presenter?.getMenuItems(at: indexPath) else {
            return UICollectionViewCell()
        }
        cell.configure(with: menuItem)
        if let orderItem = presenter?.getOrderItem(for: menuItem) {
            let count = orderItem.quantity
            cell.setQuantityLabel(count: count)
        } else {
            cell.setQuantityLabel(count: 0)
        }
        cell.delegate = presenter
        return cell
    }
}
