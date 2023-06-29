//
//  WeatherCondition.swift
//  WeatherAppNariman
//
//  Created by Nariman on 19.05.2023.
//

import Foundation

enum WeatherCondition {
    case clouds
    case sunny
    case rainy
    case snowy
    
    var iconName: String {
        switch self {
        case .clouds:
            return "cloudly"
        case .sunny:
            return "cloudly"
        case .snowy:
            return "cloudly"
        case .rainy:
            return "cloudly"
        }
    }
    
    var conditionText: String {
        switch self {
        case.clouds:
            return "Преимущественно облочно"
        case.rainy:
            return "Идет дождь"
        case .snowy:
            return  "Идет снег"
        case .sunny:
            return "Ясно"
        }
        
    }
}
