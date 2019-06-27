//
//  CalendarVars.swift
//  Prototype
//
//  Created by Павел Григорьев on 26/06/2019.
//  Copyright © 2019 GP. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current
let day = calendar.component(.day, from: date)
var weekday = calendar.component(.weekday, from: date) - 1
var month = calendar.component(.month, from: date) - 1
var year = calendar.component(.year, from: date)

var numberOfEmptyCells = Int()
var nextNumberOfEmptyCells = Int()
var previousNumberOfEmptyCells = 0
var direction = 0
//variable for storing number of empty cells
var positionIndex = 0
