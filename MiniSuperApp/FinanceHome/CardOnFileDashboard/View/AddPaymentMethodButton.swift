//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/23.
//

import Foundation
import UIKit

final class AddPaymentMethodButton: UIControl {
  private let plusIcon: UIImageView = {
    let imageView = UIImageView(
      image: UIImage(
        systemName: "plus",
        withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
      )
    )
    imageView.tintColor = .white
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    return imageView
  }()
}
