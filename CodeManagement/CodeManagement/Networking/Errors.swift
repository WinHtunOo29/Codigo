//
//  Error.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation
import Combine

enum Errors: Error {
    case notFound(String)
    case other(Int?, String)
    case decodingError(Error)
    
    static func map(_ statusCode: Int?, _ error: Error) -> Errors {
        var errorStrig = error.localizedDescription
        if let err = error as? ErrorResponse {
            if err.error_msg.isEmpty {
                errorStrig = "Somethig went wrong. Cannot get information from server. Status code = \(statusCode ?? -2). -2 is clinet defined error code when status code not found."
            } else {
                errorStrig = err.error_msg
            }
        }
        
        switch statusCode {
        case 0: return .decodingError(error)
        case 404: return .notFound(errorStrig)
        default: return .other(statusCode, errorStrig)
        }
    }
    
    func get() -> String {
        switch self {
        case .notFound(let errString): return errString
        case .decodingError(let error): return error.localizedDescription
        case .other(_, let errString): return errString
        }
    }
    
    func getStatusCode() -> Int {
        switch self {
        case .notFound(_): return 404
        case .decodingError(_): return 0
        case .other(let statusCode, _): return statusCode ?? -2
        }
    }
    
    func getDebugDescription<T: ObservableObject>(_ type: T.Type) -> String {
        let str = "\(T.self) has error 😱😱😱 with status Code <\(self.getStatusCode())> and error message is <\(self.get())>"
        return str
    }
}

struct ErrorResponse: Codable, Error {
    let error_msg: String
}
