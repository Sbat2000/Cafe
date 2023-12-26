//
//  CustomContainerView.swift
//  Cafe
//
//  Created by Aleksandr Garipov on 24.12.2023.
//

import UIKit

class CustomContainerView: UIView {
    
    private let label: UILabel
    let textField: UITextField
    
    var textFieldDelegate: UITextFieldDelegate? {
        didSet {
            textField.delegate = textFieldDelegate
        }
    }
    
    //MARK: - Life Cycle
    
    init(labelText: String, textFieldPlaceholder: String, isSecure: Bool, spacing: CGFloat) {
        
        //MARK: - Label
        
        label = UILabel()
        label.text = labelText
        label.textColor = UIColor(resource: .brown)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: 2))
        
        //MARK: - TextField
        
        textField = UITextField()
        textField.isSecureTextEntry = isSecure
        textField.textContentType = .oneTimeCode
        textField.placeholder = textFieldPlaceholder
        textField.textColor = UIColor(resource: .brown)
        textField.layer.cornerRadius = 24.5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(resource: .brown).cgColor
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        super.init(frame: .zero)
        
        addSubview(label)
        addSubview(textField)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setupConstraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 47),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
