//
//  DocumentsApi.swift
//
//
//  Created by Anuar Orazbekov on 05.12.2023.
//

import Foundation

public enum DocumentsApi {
    case getInitialDocuments
    case getDocuments(parameters: Parameters)
    case uploadDocument(parameters: Parameters)
    case publishDocument(id: String)
    case revokeDocument(id: String)
    case getDocument(id: String)
    case deleteDocument(id: String)
    case getAttachment(id: String)
    case getDocAttachment(id: String)
    case updateDocument(id: String, model: Parameters)
    case createDocument(model: Parameters)
    case getDocumentDownload(model: Parameters)
    case getCompanyEmployees(model: Parameters)
}

extension DocumentsApi: EndPointType {
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getDocuments, .getInitialDocuments:
            return "/documents"
        case .uploadDocument:
            return "documents/attachments"
        case .publishDocument(let id):
            return "/documents/\(id)/publish"
        case .revokeDocument(let id):
            return "/documents/\(id)/revoke"
        case .getDocument(let id):
            return "/documents/\(id)"
        case .deleteDocument(let id):
            return "/documents/\(id)"
        case .getAttachment(let id):
            return "/documents/attachments/\(id)"
        case .getDocAttachment(let id):
            return "/documents/file/\(id)"
        case .getDocumentDownload:
            return "/documents/attachments"
        case .updateDocument(let id, _):
            return "/documents/\(id)"
        case .createDocument:
            return "/documents"
        case .getCompanyEmployees:
            return "/api/v1/route-api/hcms/employees/company"
        }
    }
    
    var isAuthorizedSession: Bool {
        return true
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getDocuments, .getDocument, .getAttachment, .getDocAttachment, .getInitialDocuments, .getCompanyEmployees:
            return .get
        case .uploadDocument, .createDocument, .getDocumentDownload:
            return .post
        case .publishDocument:
            return .put
        case .updateDocument, .revokeDocument:
            return .patch
        case .deleteDocument:
            return .delete
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getInitialDocuments:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .getDocuments(let parameters):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: parameters,
                                                additionHeaders: self.headers)
        case .uploadDocument(let parameters):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: parameters,
                                                additionHeaders: self.headers)
        case .publishDocument:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .revokeDocument:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .getDocument:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .deleteDocument:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .getAttachment:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .updateDocument(_, let model):
            return .requestParametersAndHeaders(bodyParameters: model,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .createDocument(let parameters):
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .getDocAttachment:
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .getDocumentDownload(let parameters):
            return .requestParametersAndHeaders(bodyParameters: parameters,
                                                urlParameters: nil,
                                                additionHeaders: self.headers)
        case .getCompanyEmployees(let parameters):
            return .requestParametersAndHeaders(bodyParameters: nil,
                                                urlParameters: parameters,
                                                additionHeaders: self.headers)
        }
    }
        
    var headers: HTTPHeaders? {
        switch self {
        default:
            return [
                "dar-dms-user-id": "a502eb74-4346-452b-9187-f711846a4dcc",
                "dar-dms-org-id": "655b7bfb-ff67-4a81-a48f-89c054f188b7",
                "Workspace-Authorization": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiI1Y2Q0MmZjMy0xOWRiLTQ4OTUtYWVlMC04ZWI2ZGY2NThhM2MvMzY3Y2MyYzgtMmM2My00M2RlLTgzMDYtNDE1MTk3MDMzMDJiIiwiZXhwIjoxNzAxNTEzNDkxLCJpYXQiOjE3MDE0MjcwOTEsImlzcyI6Imh0dHBzOi8vZ3JpZmZvbi5pbyIsInN1YiI6ImIyNmQyYWQ3LWFiYzQtNGRiMC05MzA1LTYzMDMzYTZkMmYyNyIsIm5vbmNlIjoiMzYxYmM3MzctM2E5OS00YTRhLWE1MGItNmM2MDI3NTI2MGQ5IiwiYWNyIjoib2F1dGgyIiwiYXpwIjoiMzY3Y2MyYzgtMmM2My00M2RlLTgzMDYtNDE1MTk3MDMzMDJiIiwiZW1haWwiOiJhbnVhci5vQGluZm9sYW5kLmt6IiwibmFtZSI6IlVzZXIgVXNlciJ9.aZMj2BY0wFrnVbidrjGsqRSfknHKVKLOUDkNPTd7dKb03vs1qSM2npcTluUqpBZfe9KeT-kDw4meaUSPyEvNbaluy56sHdYWlTwlrGFPjXHywpRsOGd-zy_sQ3j8HGDScgeru8thUVIIwo-Pcp-HXt5DI3bgIQNlYrj6K7pQbphRieSX9S1KCT1LQ6PwYQUf77pmxvtLELHKZPkNjQJOhbjeQa13ZS8ERLz00iF7PBtq5fidFiS4nT4TrJnosuLB7sgPsWevJLRAhpwOAi3bLnP9bO7qaX5aUTxmny4ez0HuqAu6G0robteRKmc1caa7x_fBDv6hcVrIVG5BhnELDQ",
                "Access-Control-Allow-Origin": "*",
                "Authorization": "Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiI1Y2Q0MmZjMy0xOWRiLTQ4OTUtYWVlMC04ZWI2ZGY2NThhM2MvMzY3Y2MyYzgtMmM2My00M2RlLTgzMDYtNDE1MTk3MDMzMDJiIiwiZXhwIjoxNzAxNjIwOTA4LCJpYXQiOjE3MDE1MzQ1MDgsImlzcyI6Imh0dHBzOi8vZ3JpZmZvbi5pbyIsInN1YiI6ImIyNmQyYWQ3LWFiYzQtNGRiMC05MzA1LTYzMDMzYTZkMmYyNyIsIm5vbmNlIjoiZjRkYTUzM2EtOTVjZS00OThlLWIyNTgtYmI0MGQ3MDZiMTI0IiwiYWNyIjoib2F1dGgyIiwiYXpwIjoiMzY3Y2MyYzgtMmM2My00M2RlLTgzMDYtNDE1MTk3MDMzMDJiIiwiZW1haWwiOiJhbnVhci5vQGluZm9sYW5kLmt6IiwibmFtZSI6IlVzZXIgVXNlciJ9.ewGpI-jFWlbmfjQG2FvYD2YN0yOhd4n5_GfRrXwz3TBcoVq9-uoKNPM_ywnOQKWn3-Ay4M8awyKbVqysOBajOMgfb6SIR_c5KkbxiRJlU2H989dR5Y_riA2E48zF94MnU2AUnZCkFpnebOXHxyfbcNpmYfiwIEifm-lFSqITffkK3Orn3fbvfjrIov6U_z5ZqVmxjMNUe_0ScWfxNiEL7xHns4O64bPIHL1rY1K4Hn_ORxyZaa0ioHU7xT8eH-g_HbOl9FaAs2-jtkF2nBeH_VQyjuxiFrx8PbwalE6TzHyblHU-4drTiMnJC7f22JU8C6mCuSastHBMo-gGJl2b2g"
            ]
        }
    }
}
