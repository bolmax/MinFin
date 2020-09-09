//
//  MinFinAPI.swift
//  Currency
//
//  Created by Max Bolotov on 04.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Foundation
import Moya

enum MinFinAPI {
    case getMB
    case getNBU
    case getBanksSummary
}

private let MinFinAPIKey = "bb5cec726f65afbcd397e6700a4f0c6679c271ed"

extension MinFinAPI: BaseAPI {
    
    // https://api.minfin.com.ua/mb/bb5cec726f65afbcd397e6700a4f0c6679c271ed/
    // https://api.minfin.com.ua/nbu/bb5cec726f65afbcd397e6700a4f0c6679c271ed/
    // https://api.minfin.com.ua/summary/bb5cec726f65afbcd397e6700a4f0c6679c271ed/
    
    static var shouldUseStubs: Bool {
        return true
    }
    
    var path: String {
        switch self {
        case .getMB: return "mb/\(MinFinAPIKey)"
        case .getNBU: return "nbu/\(MinFinAPIKey)"
        case .getBanksSummary: return "summary/\(MinFinAPIKey)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getMB, .getNBU, .getBanksSummary: return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getMB: return self.stubbedResponseFromJSONFile(filename: "MinFinMBStubs")
        default: return Data()
        }
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
