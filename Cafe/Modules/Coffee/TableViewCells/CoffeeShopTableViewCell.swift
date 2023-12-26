//
//  CoffeeShopTableViewCell.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import UIKit

class CoffeeShopTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .darkBrown)
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(resource: .subLabel)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
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
    
    func configure(with coffeeShop: CoffeeShopViewModel) {
        nameLabel.text = coffeeShop.name
        distanceLabel.text = "\(coffeeShop.distance) от вас"
    }

    private func setupUI() {
        contentView.backgroundColor = UIColor(resource: .lightBrown)
        [nameLabel, distanceLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.layer.cornerRadius = 5
        contentView.addSubview(stackView)
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.25
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.masksToBounds = false
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
        }
    }
}
