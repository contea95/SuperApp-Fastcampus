//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 한상혁 on 2022/03/23.
//

import ModernRIBs
import Combine

protocol CardOnFileDashboardRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
  var listener: CardOnFileDashboardPresentableListener? { get set }
  
  func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
  // 여기서 부모 리블렛에게 알릴 수 있다.
  func cardOnFileDashboardDidTapAddPaymentMethod()
}

protocol CardOnFileDashboardInteractorDependency {
  var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {
  
  weak var router: CardOnFileDashboardRouting?
  // 부모 리블렛의 리스너
  weak var listener: CardOnFileDashboardListener?
  
  private let dependency: CardOnFileDashboardInteractorDependency
  
  private var cancellables: Set<AnyCancellable>
  
  init(
    presenter: CardOnFileDashboardPresentable,
    dependency: CardOnFileDashboardInteractorDependency
  ) {
    self.dependency = dependency
    self.cancellables = .init()
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    
    dependency.cardOnFileRepository.cardOnFile.sink { methods in
      // 처음 5개 카드만 보여줌
      let viewModels = methods.prefix(5).map(PaymentMethodViewModel.init)
      // self -> [weak self]를 해줘야 하지만 하지 않고 cancellables를 전부 cancel(), removeAll()을 함
      self.presenter.update(with: viewModels)
    }.store(in: &cancellables)
  }
  
  override func willResignActive() {
    super.willResignActive()
    
    cancellables.forEach { $0.cancel() }
    cancellables.removeAll()
  }
  
  func didTapAddPaymentMethod() {
    // 홈에서 모달을 띄우는게 더 나아보이므로 FinanceHome에서 띄우자
    listener?.cardOnFileDashboardDidTapAddPaymentMethod()
  }
}
