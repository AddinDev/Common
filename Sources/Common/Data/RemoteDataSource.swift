//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Combine

public protocol RemoteDataSource {
  associatedtype Request
  associatedtype Response
  
  func execute(request: Request?) -> AnyPublisher<Response, Error>
}
