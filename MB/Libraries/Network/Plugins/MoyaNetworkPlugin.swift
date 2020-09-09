//
//  NetworkPlugin.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Foundation
import Moya

public final class NetworkLogPlugin: PluginType {
    
    fileprivate let dateFormatString = "dd/MM/yyyy HH:mm:ss"
    fileprivate let dateFormatter = DateFormatter()
    fileprivate let separator = "\n"
    fileprivate let terminator = "\n==========================================\n"

    public func willSend(_ request: RequestType, target: TargetType) {
        output(message: logNetworkRequest(request.request as URLRequest?))
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        if case .success(let response) = result {
            output(message: logNetworkResponse(response.response, data: response.data, target: target))
        } else {
            output(message: logNetworkResponse(nil, data: nil, target: target))
        }
    }
    
    fileprivate func output(message: String) {
        print(message)
    }
}

private extension NetworkLogPlugin {
    
    var date: String {
        dateFormatter.dateFormat = dateFormatString
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: Date())
    }
    
    func logNetworkRequest(_ request: URLRequest?) -> String {
        
        var output = String()
        
        guard let request = request else {
            return output
        }
        
        output.append("\(separator)[\(date)]\(separator)")
        
        if let url = request.url {
            output.append("URL: \(url)\(separator)")
        }
        
        if let httpMethod = request.httpMethod {
            output.append("HTTP Method: \(httpMethod)\(separator)")
        }
        
        if let allHTTPHeaderFields = request.allHTTPHeaderFields {
            output.append("HTTP Headers:\(separator)\(allHTTPHeaderFields)\(separator)")
        }

        if let httpBody = request.httpBody, let bodyString = String(data: httpBody, encoding: .utf8) {
            output.append("HTTP Body:\(separator)\(bodyString)")
        }
        
        output.append(separator)
        
        return output
    }
    
    func logNetworkResponse(_ response: URLResponse?, data: Data?, target: TargetType) -> String {
        
        var output = String()
        output.append("\(separator)[\(date)]\(separator)")
        output.append("URL: \(target.baseURL.absoluteString)\(target.path)\(separator)")
        
        if let data = data, let prettyPrinted = self.prettyPrintedJSONString(from: data) {
            output.append("Response:\(separator)\(prettyPrinted)")
        }
        
        output.append(separator)
        
        return output
    }
    
    func prettyPrintedJSONString(from data: Data) -> NSString? {
        
        guard let object = try? JSONSerialization.jsonObject(with: data, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}


