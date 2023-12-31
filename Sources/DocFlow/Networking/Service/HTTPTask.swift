//
//  HTTPTask.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionHeaders: HTTPHeaders?)
    
    case requestMultipart(multipart: Data?, additionalHeaders: HTTPHeaders?)
    
//    case download, upload...etc
}
