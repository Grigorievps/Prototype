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
    @IBOutlet weak var calendarView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    let months = ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    let daysOfWeek = ["ПН", "ВТ", "СР", "ЧТ", "ПТ", "СБ", "ВС"]
    var daysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    var currentMonth = String()
    
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if currentMonth == "Декабрь" {
            month = 0
            year += 1
            yearLable.text = "\(year)"
        } else {
            month += 1
        }
        // leap year calculation
        if month == 1 {
            if year % 400 == 0 {
            daysInMonth[1] = 29
        } else {
            if year % 100 == 0 {
                    daysInMonth[1] = 28
            } else {
                if year % 4 == 0 {
                    daysInMonth[1] = 29
                } else {
                    daysInMonth[1] = 28
                }
            }
        }
        }
        direction = 1
        getStartDayPosition()
        currentMonth = months[month]
        monthLable.text = currentMonth
        calendarView.reloadData()
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        if currentMonth == "Январь" {
            month = 11
            year -= 1
            yearLable.text = "\(year)"
        } else {
            month -= 1
        }
        
        // leap year calculation
        if year % 400 == 0 {
            daysInMonth[1] = 29
        } else {
            if year % 100 == 0 {
                daysInMonth[1] = 28
            } else {
                if year % 4 == 0 {
                    daysInMonth[1] = 29
                } else {
                    daysInMonth[1] = 28
                }
            }
        }
        
        direction = -1
        getStartDayPosition()
        currentMonth = months[month]
        monthLable.text = currentMonth
        calendarView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentMonth = months[month]
        monthLable.text = currentMonth
        yearLable.text = "\(year)"
        if weekday == 0 {
            weekday = 7
        }
        getStartDayPosition()
    }

    func getStartDayPosition() {
        switch direction {
        case 0:
            numberOfEmptyCells = weekday - day
            while numberOfEmptyCells < 0 {
                numberOfEmptyCells += 7
            }
            positionIndex = numberOfEmptyCells
        case 1:
            var numberOfMonth = month - 1
            if numberOfMonth < 0 {
                numberOfMonth = 11
            }
            nextNumberOfEmptyCells = (positionIndex + daysInMonth[numberOfMonth]) % 7
            positionIndex = nextNumberOfEmptyCells
        case -1:
            previousNumberOfEmptyCells = 7 - (daysInMonth[month] - positionIndex) % 7
            if previousNumberOfEmptyCells == 7 {
                previousNumberOfEmptyCells = 0
            }
            positionIndex = previousNumberOfEmptyCells
        default:
            fatalError()
        }
        
        
    }

}

extension CalendarViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch direction {
        case 0:
            return daysInMonth[month] + numberOfEmptyCells
        case 1:
            return daysInMonth[month] + nextNumberOfEmptyCells
        case -1:
            return daysInMonth[month] + previousNumberOfEmptyCells
        default:
            fatalError()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarCell", for: indexPath) as! DateCollectionViewCell
        cell.backgroundColor = UIColor.clear
        
        if cell.isHidden {
            cell.isHidden = false
        }
        
        if cell.dateLable.textColor == UIColor.red {
            cell.dateLable.textColor = UIColor.lightGray
        }
        
        switch direction {
        case 0:
            cell.dateLable.text = "\(indexPath.row + 1 - numberOfEmptyCells)"
        case 1:
            cell.dateLable.text = "\(indexPath.row + 1 - nextNumberOfEmptyCells)"
        case -1:
            cell.dateLable.text = "\(indexPath.row + 1 - previousNumberOfEmptyCells)"
        default:
            fatalError()
        }
        
        if Int(cell.dateLable.text!)! < 1 {
            cell.isHidden = true
        }
        
        if currentMonth == months[calendar.component(.month, from: date) - 1] &&
            year == calendar.component(.year, from: date) &&
            indexPath.row - numberOfEmptyCells + 1 == day {
            cell.dateLable.textColor = UIColor.red
        }
        
        return cell
    }
}
