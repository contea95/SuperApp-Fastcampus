//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/23.
//

import Foundation

struct PaymentMethod: Decodable {
  let id: String
  let name: String
  let digits: String
  let color: String
  let isPrimary: Bool  
}
