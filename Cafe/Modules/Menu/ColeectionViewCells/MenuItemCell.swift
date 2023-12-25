//
//  MenuItemCell.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 25.12.2023.
//

import UIKit
import SnapKit
import Kingfisher

protocol MenuItemCellDelegate: AnyObject {
    func menuItemCell(didUpdateQuantity quantity: Int, forItem menuItem: MenuItem)
}

final class MenuItemCell: UICollectionViewCell {
    
    weak var delegate: MenuItemCellDelegate?
    private var menuItem: MenuItem!
    
    private var quantity: Int = 0 {
        didSet {
            quantityLabel.text = "\(quantity)"
            delegate?.menuItemCell(didUpdateQuantity: quantity, forItem: menuItem)
        }
    }
    
    //MARK: - UI Elements
    
    private var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.min")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var itemTitle: UILabel = {
        let label = UILabel()
        label.text = "Еда"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor(resource: .brown)
        return label
    }()
    
    private var priceTitle: UILabel = {
        let label = UILabel()
        label.text = "0 руб"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(resource: .brown)
        return label
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(resource: .brown)
        label.textAlignment = .center
        return label
    }()
    
    private let minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "minus"), for: .normal)
        button.tintColor = UIColor(resource: .brown)
        button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        return button
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(resource: .brown)
        button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    //MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func configure(with menuItem: MenuItem) {
        let imageUrlString = menuItem.imageURL
        self.menuItem = menuItem
        updateItemImage(with: imageUrlString)
        itemTitle.text = menuItem.name
        priceTitle.text = "\(Int(menuItem.price)) руб"
        quantityLabel.text = "0"
    }
    
    func setQuantityLabel(count: Int) {
        quantity = count
    }
    
    
    //MARK: - Private methods
    private func setupUI() {
        contentView.addSubview(itemImageView)
        contentView.addSubview(itemTitle)
        contentView.addSubview(priceTitle)
        setupStackView()
        contentView.addSubview(stackView)
    }
    
    private func setupStackView() {
        [minusButton, quantityLabel, plusButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        itemImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(itemImageView.snp.width)
        }
        
        itemTitle.snp.makeConstraints { make in
            make.top.equalTo(itemImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(11)
        }
        
        priceTitle.snp.makeConstraints { make in
            make.top.equalTo(itemTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(11)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.width.equalTo(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(priceTitle)
            make.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func setupShadow() {
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.25
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.cornerRadius).cgPath
    }
    
    private func updateItemImage(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let cache = ImageCache.default
        cache.diskStorage.config.expiration = .seconds(360)
        
        
        itemImageView.kf.indicatorType = .activity
        itemImageView.kf.setImage(with: url,
                                  placeholder: UIImage(systemName: "cup.and.saucer"),
                                  options: [.cacheSerializer(FormatIndicatedCacheSerializer.png)])
    }
}

//MARK: private actions

extension MenuItemCell {
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
