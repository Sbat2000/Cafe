//
//  OrderTableViewCell.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import UIKit

protocol OrderTableViewCellDelegate: AnyObject {
    func menuItemCell(didUpdateQuantity quantity: Int, forItem menuItem: MenuItem)
}

class OrderTableViewCell: UITableViewCell {
    
    weak var delegate: OrderTableViewCellDelegate?
    private var menuItem: MenuItem!
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
            delegate?.menuItemCell(didUpdateQuantity: quantity, forItem: menuItem)
        }
    }
    
    //MARK: - UI Elements

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .darkBrown)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "0 руб"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(resource: .brown)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5
        return stackView
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(resource: .brown)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = UIColor(resource: .brown)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(resource: .brown)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    private let countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
//MARK: - Life Cycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0))
    }
    
    //MARK: - Methods
    
    func configure(with orderItem: OrderItem) {
        menuItem = orderItem.menuItem
        quantity = orderItem.quantity
        quantityLabel.text = "\(orderItem.quantity)"
        nameLabel.text = orderItem.menuItem.name
        priceLabel.text = "\(Int(orderItem.menuItem.price)) руб"
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(resource: .lightBrown)
        [nameLabel, priceLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [minusButton, quantityLabel, plusButton].forEach {
            countStackView.addArrangedSubview($0)
        }
        
        contentView.layer.cornerRadius = 5
        contentView.addSubview(stackView)
        contentView.addSubview(countStackView)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(countStackView.snp.leading).inset(-10)
            make.centerY.equalToSuperview()
        }
        
        countStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        
        plusButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
        }
    }
}

//MARK: private actions

extension OrderTableViewCell {
    @objc private func didTapMinusButton() {
        if quantity > 0 {
            quantity -= 1
        }
    }
    
    @objc private func didTapPlusButton() {
        if quantity < 99 {
            quantity += 1
        }
    }
}
