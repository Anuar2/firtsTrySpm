//
//  EndPointType.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

enum NetworkEnvironment {
    case develop
    case production
    case staging
}

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var isAuthorizedSession: Bool { get }
}

extension EndPointType {
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .develop       :   return "https://dms.dar-dev.zone/api/v1/docflow"
        case .production    :   return "https://dms.dar-dev.zone/api/v1/docflow"
        case .staging       :   return "https://dms.dar-qa.zone/api/v1/docflow"
        }
    }
}
