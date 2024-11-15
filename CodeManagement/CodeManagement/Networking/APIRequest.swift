//
//  APIRequest.swift
//  CodeManagement
//
//  Created by Win Htun Oo on 12/11/2024.
//

import Foundation

class APIRequest {
    let url: String
    var headers: [String: String]
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: HTTPMethod?
    var query: [String: String]?
    
    var session: URLSession {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        let session = URLSession(configuration: config)
        session.configuration.timeoutIntervalForRequest = TimeInterval(self.requestTimeOut ?? 30.0)
        return session
    }
    
    init(url: String,
                headers: [String: String]? = nil,
                reqBody: Encodable? = nil,
                reqTimeout: Float? = nil,
         httpMethod: HTTPMethod? = .GET
    ) {
        self.url = url
        if headers == nil {
            self.headers = Headers.headers
        } else {
            self.headers = headers ?? [:]
        }
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    func getURLRequest(_ base: String? = nil) -> URLRequest {
        var url = URL(string: (base ?? BaseUrl.baseUrl) + self.url)!
        if !(self.query?.isEmpty ?? true) {
            url = url.appending(self.query ?? [:])
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = self.httpMethod?.rawValue
        
        urlRequest.httpBody = self.body
        for (key, value) in self.headers {
            urlRequest.addValue( value, forHTTPHeaderField: key)
        }
        print("URL Request -->", urlRequest, urlRequest.allHTTPHeaderFields as Any, urlRequest.httpBody as Any, urlRequest.httpMethod as Any)
        return urlRequest
    }
    
    func query(_ query: [String:String]) -> APIRequest {
        self.query = query
        return self
    }
    
    func headers(_ headers: [String:String]) -> APIRequest {
        self.headers = headers
        return self
    }
    
    func addAdditionalHeaders(_ headers: [String:String]) -> APIRequest {
        for (key,value) in headers {
            self.headers[key] = value
        }
        return self
    }
}

public enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}

extension URL {

    func appending(_ query: [String:String]) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        for (queryItem, value) in query {
            if queryItem != "" && value != "" {
            let queryItem = URLQueryItem(name: queryItem, value: value)
                queryItems.append(queryItem)
            }
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
