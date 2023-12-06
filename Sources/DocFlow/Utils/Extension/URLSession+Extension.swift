//
//  URLSession+Extension.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

extension URLSession {
    static func configuredSession() -> URLSession {
        let config = URLSessionConfiguration.default
        let interceptor = RequestInterceptor.shared
        
        return URLSession(configuration: config, delegate: interceptor, delegateQueue: nil)
    }
}
