//
//  CourseObject.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import Foundation

enum CurrencyType: String {
    case usd, eur, rub
}

struct CourseObject: Codable {
    
    var id: String
    var pointDate: Date
    var date: Date
    var ask: String
    var bid: String
    var trendAsk: String
    var trendBid: String
    var currency: String
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.id = try container.decode(String.self, forKey: .id)
            self.pointDate = try container.decode(Date.self, forKey: .pointDate)
            self.date = try container.decode(Date.self, forKey: .date)
            self.ask = try container.decode(String.self, forKey: .ask)
            self.bid = try container.decode(String.self, forKey: .bid)
            self.trendAsk = try container.decode(String.self, forKey: .trendAsk)
            self.trendBid = try container.decode(String.self, forKey: .trendBid)
            self.currency = try container.decode(String.self, forKey: .currency)
                        
        } catch {
            
            self.id = ""
            self.pointDate = Date()
            self.date = Date()
            self.ask = ""
            self.bid = ""
            self.trendAsk = "0"
            self.trendBid = "0"
            self.currency = ""
        }
        
    }
    
    func currencyString() -> String {
        return self.currency.uppercased()
    }
    
    func pointDateString() -> String {
        return DateFormatter.courseFormatter.string(from: self.pointDate)
    }
    
    func isTrendAskNegative() -> Bool {
        return self.trendAsk.contains("-")
    }
    
    func isTrendBidNegative() -> Bool {
        return self.trendBid.contains("-")
    }

}
