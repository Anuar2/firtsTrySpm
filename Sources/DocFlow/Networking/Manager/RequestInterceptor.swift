//
//  RequestInterceptor.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

class RequestInterceptor: NSObject, URLSessionTaskDelegate {
    private var orgId: String?
    private var userId: String?
    
    static let shared = RequestInterceptor()
    
    func setCommonHeader(orgId: String?, userId: String?) {
        self.orgId = orgId
        self.userId = userId
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        guard let originalRequest = task.originalRequest, var request = (originalRequest as NSURLRequest).mutableCopy() as? NSMutableURLRequest else { return }
        
        if let orgId = orgId {
            request.setValue(orgId, forHTTPHeaderField: "dar-dms-org-id")
        }
        
        if let userId = userId {
            request.setValue(userId, forHTTPHeaderField: "dar-dms-user-id")
        }
        
        task.setValue(request, forKey: "currentRequest")
    }
}
