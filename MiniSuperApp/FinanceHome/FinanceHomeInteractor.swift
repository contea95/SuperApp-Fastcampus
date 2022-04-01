import ModernRIBs

protocol FinanceHomeRouting: ViewableRouting {
  // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
  func attachSuperPayDashboard()
  func attachCardOnDashboard()
  func attachAddPaymentMethod()
  func detachAddPaymentMethod()
}

protocol FinanceHomePresentable: Presentable {
  var listener: FinanceHomePresentableListener? { get set }
  // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol FinanceHomeListener: AnyObject {
  // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class FinanceHomeInteractor: PresentableInteractor<FinanceHomePresentable>, FinanceHomeInteractable, FinanceHomePresentableListener {
  
  weak var router: FinanceHomeRouting?
  weak var listener: FinanceHomeListener?
  
  // TODO: Add additional dependencies to constructor. Do not perform any logic
  // in constructor.
  override init(presenter: FinanceHomePresentable) {
    super.init(presenter: presenter)
    presenter.listener = self
  }
  
  override func didBecomeActive() {
    super.didBecomeActive()
    // TODO: Implement business logic here.
    
    router?.attachSuperPayDashboard()
    router?.attachCardOnDashboard()
  }
  
  override func willResignActive() {
    super.willResignActive()
    // TODO: Pause any business logic.
  }
  
  // MARK: - CardOnFileDashboardListener
  func cardOnFileDashboardDidTapAddPaymentMethod() {
    // 라우터에게 AddPaymentMethod를 붙여달라 요청
    router?.attachAddPaymentMethod()
  }
  
  // MARK: - AddPaymentMethodListener
  func addPaymentMethodDidTapClose() {
    // 이 이벤트에 대한 메서드는 FinanceHomeRouter에서 진행
    router?.detachAddPaymentMethod()
  }
}
