//
//  LoginViewController.swift
//  Super easy dev
//
//  Created by Aleksandr Garipov on 24.12.2023
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func getPassword() -> String
    func getEmail() -> String
    func setLoginButtonEnabled(_ isEnabled: Bool)
}

class LoginViewController: UIViewController {
    
    //MARK: - UI Elements
    
    private let emailView = CustomContainerView(labelText: "e-mail", textFieldPlaceholder: "example@example.ru", isSecure: false, spacing: 10)
    
    private let passwordView = CustomContainerView(labelText: "Пароль", textFieldPlaceholder: "*******", isSecure: true, spacing: 10)
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.tintColor = UIColor(resource: .lightBrown)
        button.layer.cornerRadius = 24.5
        button.backgroundColor = .gray
        button.isUserInteractionEnabled = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    // MARK: - Public
    var presenter: LoginPresenterProtocol?

    // MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        print("Deinit LoginViewController")
    }
}

// MARK: - Private functions
private extension LoginViewController {
    func initialize() {
        setupUI()
        setupConstraints()
        addObserverForKeyboard()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        self.navigationItem.title = "Вход"
        
        [emailView, passwordView, loginButton].forEach {
            stackView.addArrangedSubview($0)
            if let customView = $0 as? CustomContainerView {
                customView.textFieldDelegate = self
            }
        }
        view.addSubview(stackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        loginButton.snp.makeConstraints { make in
            make.height.equalTo(47)
        }
    }
    
    func addObserverForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let keyboardHeight = keyboardSize.height
        let bottomSpace = view.frame.height - (stackView.frame.origin.y + stackView.frame.height)
        let offset = keyboardHeight - bottomSpace + 20 // 20 - это дополнительное пространство
        
        if offset > 0 {
            view.frame.origin.y = -offset
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

//MARK: - Private actions

private extension LoginViewController {
    @objc
    func loginButtonTapped() {
        presenter?.loginButtonTapped()
    }
}

// MARK: - LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func getPassword() -> String {
        passwordView.textField.text ?? ""
    }
    
    func getEmail() -> String {
        emailView.textField.text ?? ""
    }
    
    func setLoginButtonEnabled(_ isEnabled: Bool) {
        loginButton.isUserInteractionEnabled = isEnabled
        loginButton.backgroundColor = isEnabled ? .darkBrown : .gray
    }
    
}

//MARK: UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.presenter?.checkLoginAvailability()
    }
}
