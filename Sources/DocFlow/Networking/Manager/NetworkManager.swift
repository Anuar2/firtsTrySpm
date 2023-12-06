//
//  NetworkManager.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .develop
    
    enum NetworkResponse: String {
        case success
        case authError      = "Необходимо авторизоваться."
        case badRequest     = "Неправильный запрос."
        case outdated       = "Адрес, который Вы запросили, просрочен."
        case failed         = "Проблемы с интернет соединением."
        case noData         = "Полученный ответ с сервера не содержит данных для декодирования."
        case unableToDecode = "Невозможно обработать ответ."
        case notFound       = "Не удалось найти адрес."
        case serverError    = "Ошибка сервера."
    }
    
    enum Result<ErrorModel> {
        case success
        case failure(ErrorModel)
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<ErrorModel> {
        switch response.statusCode {
        case 200...299  :   return .success
        case 400        :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.badRequest.rawValue, origin: nil, timestamp: nil))
        case 401        :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.authError.rawValue, origin: nil, timestamp: nil))
        case 404, 505   :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.notFound.rawValue, origin: nil, timestamp: nil))
        case 500...504  :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.serverError.rawValue, origin: nil, timestamp: nil))
        case 506...599  :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.serverError.rawValue, origin: nil, timestamp: nil))
        case 600        :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.outdated.rawValue, origin: nil, timestamp: nil))
        default         :   return .failure(ErrorModel(сode: String(response.statusCode), description: NetworkResponse.failed.rawValue, origin: nil, timestamp: nil))
        }
    }
    
    private func error(from responseData: Data) -> ErrorModel? {
        do {
            let error = try JSONDecoder().decode(ErrorModel.self, from: responseData)
            print("//////////////// ERROR IS \(error)")
            return error
        } catch {
            return nil
        }
    }
    
    func request<Element:EndPointType, T:Decodable>(_ endpoint: Element, model: T.Type?, completion: @escaping (_ model: T?,_ error: ErrorModel?) -> ()) {
        
        NetworkRouter().request(endpoint) { (data, response, error) in
            
            if error != nil {
                completion(nil, ErrorModel(сode: "0001", description: "Пожалуйста, проверьте интернет соединение", origin: nil, timestamp: nil))
            }
            
            if let response = response as? HTTPURLResponse {
                
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil,  ErrorModel(сode: "0002", description: NetworkResponse.noData.rawValue, origin: nil, timestamp: nil))
                        return
                    }
                    do {
                        guard (model) != nil else {
                            /// Кейс, когда мы не ожидаем модели с сервера
                            completion(nil, nil)
                            return
                        }
                        let apiResponse = try JSONDecoder().decode(model!.self, from: responseData)
                        let responseData = String(data: data ?? Data(), encoding: String.Encoding.utf8)
                        print("RESPONSE BODY IS \(String(describing: responseData))")
                        completion(apiResponse as T, nil)
                    } catch {
                        completion(nil, ErrorModel(сode: "0002", description: NetworkResponse.noData.rawValue, origin: nil, timestamp: nil))
                    }
                case .failure(let networkFailureError):
                    guard let response = data else {
                        completion(nil, networkFailureError)
                        return
                    }
                    let error = self.error(from: response)
                    if (error?.description) != nil {
                        completion(nil, nil)
                    }

                    completion(nil, error)
                }
            }
        }
    }
}

