//
//  HomeTableViewController.swift
//  MB
//
//  Created by Max Bolotov on 05.08.2020.
//  Copyright © 2020 Max Bolotov. All rights reserved.
//

import UIKit

struct CourseDataModel {
    
    var courses: [CourseObject]
    var lastCourse: CourseObject
    
}

class HomeTableViewController: UITableViewController {
    
    let service = MBNetworkService()
    
    var models: [CourseDataModel] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.getCourses()
    }
    
    func getCourses() {
        service.getMB { (objects, error) in
            self.setCourses(objects)
        }
    }
    
    func setCourses(_ courses: [CourseObject]) {
        
        let usd = courses.filter({ $0.currency == "usd" })
        let sortedUsd = usd.sorted { (obj1, obj2) -> Bool in
            return obj1.pointDate > obj2.pointDate
        }
        
        if !sortedUsd.isEmpty {
            let usdDataModel = CourseDataModel(courses: sortedUsd, lastCourse: sortedUsd.first!)
            self.models.append(usdDataModel)
        }
        
        let eur = courses.filter({ $0.currency == "eur" })
        let sortedEur = eur.sorted { (obj1, obj2) -> Bool in
            return obj1.pointDate > obj2.pointDate
        }
        
        if !sortedEur.isEmpty {
            let eurDataModel = CourseDataModel(courses: sortedEur, lastCourse: sortedEur.first!)
            self.models.append(eurDataModel)
        }
    }
    
    // MARK: - TableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CoursesTableViewCell.self), for: indexPath) as! CoursesTableViewCell
        cell.course = self.models[indexPath.item].lastCourse
        
        return cell
    }
}

