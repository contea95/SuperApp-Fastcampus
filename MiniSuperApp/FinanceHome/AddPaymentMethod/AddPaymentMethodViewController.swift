//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/24.
//

import ModernRIBs
import UIKit

protocol AddPaymentMethodPresentableListener: AnyObject {
  // 화면 닫기는 라우터가 적합하므로 리스너에게 전달 -> 지금은 interactor로 전달됨
  func didTapClose()
  func didTapConfirm(with number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {
  
  weak var listener: AddPaymentMethodPresentableListener?
  
  private let cardNumberTextField: UITextField = {
    let textField = makeTextField()
    textField.placeholder = "카드 번호"
    return textField
  }()
  
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.alignment = .center
    stackView.distribution = .fillEqually
    stackView.spacing = 14
    return stackView
  }()
  
  private let securityTextField: UITextField = {
    let textField = makeTextField()
    textField.placeholder = "CVC"
    return textField
  }()
  
  private let expirationTextField: UITextField = {
    let textField = makeTextField()
    textField.placeholder = "유효기한"
    return textField
  }()
  
  private let addCardButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.roundCorners()
    button.backgroundColor = .primaryRed
    button.setTitle("추가하기", for: .normal)
    button.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
    return button
  }()
  
  private static func makeTextField() -> UITextField {
    let textField = UITextField()
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.backgroundColor = .white
    textField.borderStyle = .roundedRect
    textField.keyboardType = .numberPad
    return textField
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    
    setupViews()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    setupViews()
  }
  
  private func setupViews() {
    title = "카드 추가"
    
    // 모달 창 X 버튼
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(
        systemName: "xmark",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)),
      style: .plain,
      target: self,
      action: #selector(didTapClose))
    
    
    view.backgroundColor = .backgroundColor
    view.addSubview(cardNumberTextField)
    view.addSubview(stackView)
    view.addSubview(addCardButton)
    
    stackView.addArrangedSubview(securityTextField)
    stackView.addArrangedSubview(expirationTextField)
    
    NSLayoutConstraint.activate([
      cardNumberTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
      cardNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      cardNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      cardNumberTextField.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -20),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      stackView.bottomAnchor.constraint(equalTo: addCardButton.topAnchor, constant: -20),
      addCardButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
      addCardButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
      
      cardNumberTextField.heightAnchor.constraint(equalToConstant: 60),
      securityTextField.heightAnchor.constraint(equalToConstant: 60),
      expirationTextField.heightAnchor.constraint(equalToConstant: 60),
      addCardButton.heightAnchor.constraint(equalToConstant: 60),
    ])
  }
  
  @objc
  private func didTapAddCard() {
    // 텍스트 언래핑 후 인터렉터로 전달
    if let number = cardNumberTextField.text,
       let cvc = securityTextField.text,
       let expiry = expirationTextField.text {
      listener?.didTapConfirm(with: number, cvc: cvc, expiry: expiry)
    }
  }
  
  @objc
  private func didTapClose() {
    listener?.didTapClose()
  }
}
