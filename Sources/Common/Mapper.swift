//
//  File.swift
//  
//
//  Created by addin on 30/03/21.
//

import Foundation

public protocol Mapper {
  associatedtype Request
  associatedtype Response
  associatedtype Entity
  associatedtype Domain
  
  func transformResponseToEntity(request: Request?, response: Response) -> Entity
  func transformEntityToDomain(entity: Entity) -> Domain
}
