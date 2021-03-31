//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import SwiftUI
import Combine

public class Presenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {
  
  private var cancellables: Set<AnyCancellable> = []
  
  private let _useCase: Interactor
  
  @Published public var item: Response?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false
  
  public init(useCase: Interactor) {
    _useCase = useCase
  }
  
  public func getList(request: Request?) {
    isLoading = true
    _useCase.execute(request: request)
      .receive(on: RunLoop.main)
      .sink { completion in
        switch completion {
        case .failure(let error):
          self.errorMessage = error.localizedDescription
          self.isError = true
          self.isLoading = false
        case .finished:
          self.isLoading = false
        }
      } receiveValue: { item in
        self.item = item
      }
      .store(in: &cancellables)
  }
  
}