//
//  API.swift
//  Currency
//
//  Created by Max Bolotov on 04.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Moya

protocol BaseAPI: TargetType {
    static var shouldUseStubs: Bool { get }
}

extension BaseAPI {
    
    var baseURL: URL {
        return URL(string: "https://api.minfin.com.ua")!
    }
    
    func stubbedResponseFromJSONFile(filename: String, inDirectory subpath: String = "", bundle: Bundle = Bundle.main ) -> Data {
           
           guard let path = bundle.path(forResource: filename, ofType: "json", inDirectory: subpath) else { return Data() }
           
           if let dataString = try? String(contentsOfFile: path), let data = dataString.data(using: String.Encoding.utf8) {
               return data
           } else {
               return Data()
           }
    }
}
