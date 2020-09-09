//
//  MBService.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Foundation

typealias GetMBResult = (([CourseObject], MBError?) -> Void)

protocol MBNetworkServiceProtocol: class {
    func getMB(completion: @escaping GetMBResult)
}

class MBNetworkService: BaseService<MinFinAPI>, MBNetworkServiceProtocol {
    
    func getMB(completion: @escaping GetMBResult) {
        
        self.provider.request(.getMB) { (result) in
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.fullFormatter)
            
            self.serialize(result, [CourseObject].self, decoder, success: { (objects) in
                completion(objects as! [CourseObject], nil)
            }) { (error) in
                completion([], error)
            }
        }
    }
    
}
