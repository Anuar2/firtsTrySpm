//
//  NetworkRouter.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

class NetworkRouter<EndPoint: EndPointType>: NetworkRouterProtocol {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint,
                 completion: @escaping NetworkRouterCompletion) {
        
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            
            task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let response = response { print("RESPONSE IS \(response)") }
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        do {
            switch route.task {
            case .request:
                
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
            case .requestParameters(let bodyParameters,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let urlParameters,
                                              let additionHeaders):
                
                self.addAdditionalHeaders(additionHeaders, request: &request)
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestMultipart(let multipart, let headers):
                
                self.addAdditionalHeaders(headers, request: &request)
                
                try self.configureMultipart(multipart: multipart,
                                            request: &request)
                
            }
            
            print("REQUEST IS \(request) \n\n")
            print("HEADERS ARE \(request.allHTTPHeaderFields ?? ["headers": "nothing"]) \n\n")
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request,
                                                with: bodyParameters)
            }
            
            if let urlParameters = urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request,
                                               with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    fileprivate func configureMultipart(
        multipart: Data?,
        request: inout URLRequest) throws {
        
        do {
            if let multipart = multipart {
                request.httpBody = multipart
            }
        }
    }
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?,
                                          request: inout URLRequest) {
        
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
