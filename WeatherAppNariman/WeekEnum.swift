//
//  WeekEnum.swift
//  WeatherAppNariman
//
//  Created by Nariman on 22.05.2023.
//

import Foundation

enum Week: Int {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    var shortName: String {
        switch self {
        case .monday:
            return "Пн"
        case .tuesday:
            return "Вт"
        case .wednesday:
            return "Ср"
        case .thursday:
            return "Чт"
        case .friday:
            return "Пт"
        case .saturday:
            return "Cб"
        case .sunday:
            return "Вс"
        }
    }

}
