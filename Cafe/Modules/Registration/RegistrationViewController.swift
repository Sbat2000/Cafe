//
//  RegistrationViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 22.12.2023
//

import UIKit
import SnapKit

protocol RegistrationViewProtocol: AnyObject {
}

class RegistrationViewController: UIViewController {
    //MARK: - UI Elements
    
    private let emailView = CustomContainerView(labelText: "e-mail", textFieldPlaceholder: "example@example.ru", isSecure: false, spacing: 10)
    
    private let passwordView = CustomContainerView(labelText: "Пароль", textFieldPlaceholder: "*******", isSecure: true, spacing: 10)
    
    private let confirmPasswordView = CustomContainerView(labelText: "Повторите пароль", textFieldPlaceholder: "*******", isSecure: true, spacing: 10)
    
    private let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Регистрация", for: .normal)
        button.tintColor = UIColor(resource: .buttonTitle)
        button.layer.cornerRadius = 24.5
        button.backgroundColor = UIColor(resource: .darkBrown)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - Public
    var presenter: RegistrationPresenterProtocol?
    
    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Регистрация"
        initialize()
    }
}

// MARK: - Private functions
private extension RegistrationViewController {
    func initialize() {
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        [emailView, passwordView, confirmPasswordView, registrationButton].forEach {
            stackView.addArrangedSubview($0)
            //$0.textFieldDelegate = self
        }
        view.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        registrationButton.snp.makeConstraints { make in
            make.height.equalTo(47)
        }
    }
}


// MARK: - RegistrationViewProtocol
extension RegistrationViewController: RegistrationViewProtocol {
}

//MARK: UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    
}
