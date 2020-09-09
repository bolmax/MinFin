//
//  BaseService.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Foundation
import Moya

typealias MoyaResult = Result<Moya.Response, MoyaError>
typealias BaseResponseFailure = (MBError?) -> Void
typealias BaseResponseSuccess = (Moya.Response) -> Void
typealias DecodeSuccess = (Codable) -> Void

enum MBError: Swift.Error {
    case moyaError(MoyaError)
}

class BaseService<Target: BaseAPI> {

    lazy var decoder = JSONDecoder()
    var provider: MoyaProvider<Target>

    // MARK: - Initialization

    init() {
        let shouldUseStubs = Target.self.shouldUseStubs
        let stubClosure = shouldUseStubs ? MoyaProvider<Target>.delayedStub(TimeInterval(5)) : MoyaProvider.neverStub
        self.provider = MoyaProvider<Target>(stubClosure: stubClosure, plugins: [NetworkLogPlugin()])
    }
    
    // MARK: - Serialize
    
    func serialize<T: Codable>(_ result: MoyaResult,_ codable: T.Type, _ decoder: JSONDecoder = JSONDecoder() , success: DecodeSuccess, failure: BaseResponseFailure) {
        
        self.handleResult(result, success: { (response) in
            self.decode(response, codable, decoder, success: success, failure: failure)
        }, failure: failure)
    }
    
    // MARK: - Private
    
    func handleResult(_ result: MoyaResult, success: BaseResponseSuccess, failure: BaseResponseFailure) {
        switch result {
        case let .success(moyaResponse):

            do {
                let response = try moyaResponse.filterSuccessfulStatusCodes()
                success(response)
            } catch {
                failure(MBError.moyaError(error as! MoyaError))
            }
            
        case let .failure(error):
            failure(MBError.moyaError(error))
        }
    }
    
    func decode<T: Codable>(_ response: Moya.Response, _ codable: T.Type, _ decoder: JSONDecoder, success: DecodeSuccess, failure: BaseResponseFailure) {
        
        do {
            let obj = try response.map(codable, using: decoder)
            success(obj)
        } catch {
            failure(MBError.moyaError(error as! MoyaError))
        }
    }
    
}
