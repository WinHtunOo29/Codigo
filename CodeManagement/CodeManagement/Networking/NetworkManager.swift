//
//  NetworkManager.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import Combine

class NetworkManager {
    var statusCode: Int?
    
    func request<T: Codable>(type: T.Type, _ request: APIRequest, base: String? = nil) -> AnyPublisher<T, Errors> {
        return request.session.dataTaskPublisher(for: request.getURLRequest(base))
          .tryMap { response -> Data in
            guard
              let httpURLResponse = response.response as? HTTPURLResponse,
              httpURLResponse.statusCode >= 200 && httpURLResponse.statusCode < 300
              else {
                self.statusCode = (response.response as? HTTPURLResponse)?.statusCode
                throw try JSONDecoder().decode(ErrorResponse.self, from: response.data)
            }
            return response.data
          }
          .decode(type: T.self, decoder: JSONDecoder())
          .mapError {
              if self.statusCode == nil {
                  print("Error occured -> ", $0)
                  return Errors.map(Int(0), $0)
              } else {
                  return Errors.map(self.statusCode, $0) }
          }
          .eraseToAnyPublisher()
    }
}
