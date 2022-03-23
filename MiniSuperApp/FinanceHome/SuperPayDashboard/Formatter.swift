//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/23.
//

import Foundation

struct Formatter {
  static let balanceFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    return formatter
  }()
}
