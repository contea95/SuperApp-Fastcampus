//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/23.
//

import Foundation

// 서버API 호출해서 유저 카드 목록을 가지고 있음
// 데이터 스트림으로 저장, 필요할 때
protocol CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
  var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
  
  private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
    PaymentMethod(id: "0", name: "우리은행", digits: "0123", color: "#f19a38ff", isPrimary: false),
//    PaymentMethod(id: "1", name: "신한카드", digits: "0987", color: "#3478ㄹ6ff", isPrimary: false),
//    PaymentMethod(id: "2", name: "현대카드", digits: "8121", color: "#78c5f5ff", isPrimary: false),
//    PaymentMethod(id: "3", name: "국민은행", digits: "2812", color: "#65c466ff", isPrimary: false),
//    PaymentMethod(id: "4", name: "카카오뱅크", digits: "8751", color: "#ffcc00ff", isPrimary: false),
  ])
}
