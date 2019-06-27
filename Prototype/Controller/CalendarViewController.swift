//
//  CalendarViewController.swift
//  Prototype
//
//  Created by Павел Григорьев on 26/06/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var monthLable: UILabel!
    @IBOutlet weak var yearLable: UILabel!
    @IBOutlet weak var calendar: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    let daysOfWeek = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    let daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if currentMonth == "Декабрь" {
            month = 0
            year += 1
            yearLable.text = "\(year)"
        } else {
            month += 1
        }
        
        currentMonth = months[month]
        monthLable.text = currentMonth
        calendar.reloadData()
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if currentMonth == "Январь" {
            month = 11
            year -= 1
            yearLable.text = "\(year)"
        } else {
            month -= 1
        }
        
        currentMonth = months[month]
        monthLable.text = currentMonth
        calendar.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[month]
        monthLable.text = currentMonth
        yearLable.text = "\(year)"
    }
    
    func getStartDayPosition() {
        switch direction {
        case 0:
            numberOfEmptyCells = weekday - day
            while numberOfEmptyCells < 0 {
                numberOfEmptyCells += 7
            }
        case 1:
            nextNumberOfEmptyCells = (positionIndex + daysInMonth[month]) % 7
            positionIndex = nextNumberOfEmptyCells
        default:
            break
        }
        
        
    }

}

extension CalendarViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return daysInMonth[month]
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        cell.DateLable.text = "\(indexPath.row + 1)"
        return cell
    }
}
