//
//  CoursesTableViewCell.swift
//  MB
//
//  Created by Max Bolotov on 06.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var currencyLabel: UILabel?
    @IBOutlet weak var dateLabel: UILabel?
    
    @IBOutlet weak var purchaseLabel: UILabel?
    @IBOutlet weak var purchaseDifLabel: UILabel?

    @IBOutlet weak var saleLabel: UILabel?
    @IBOutlet weak var saleDifLabel: UILabel?

    var course: CourseObject? {
        didSet {
            self.configure()
        }
    }
    
    // MARK: - Private
    
    private func configure() {
        
        guard let obj = self.course else { return }
        
        self.currencyLabel?.text = obj.currencyString()
        self.dateLabel?.text = obj.pointDateString()
        
        self.purchaseLabel?.text = obj.bid
        self.purchaseDifLabel?.text = obj.trendBid
        
        self.saleLabel?.text = obj.ask
        self.saleDifLabel?.text = obj.trendAsk
        
        let trendBidColor = obj.isTrendBidNegative() ? UIColor.red : UIColor.green
        let trendAskColor = obj.isTrendAskNegative() ? UIColor.red : UIColor.green
        self.purchaseDifLabel?.textColor = trendBidColor
        self.saleDifLabel?.textColor = trendAskColor
    }
    
}
