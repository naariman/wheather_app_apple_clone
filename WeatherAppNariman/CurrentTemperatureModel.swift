//
//  CurrentTemperatureModel.swift
//  WeatherAppNariman
//
//  Created by Nariman on 18.05.2023.
//

import Foundation

struct CurrentTemperatureModel {
    var cityName: String
    var temperature: Int
    var condition: String
    private var maxTemperature: Int
    private var minTemperature: Int
    var rangeTemperature: String {
        "Макс.: \(maxTemperature.tempStyle), Мин.: \(minTemperature.tempStyle)"
    }
    
    init(cityName: String, temperature: Int, condition: String, maxTemperature: Int, minTemperature: Int) {
        self.cityName = cityName
        self.temperature = temperature
        self.condition = condition
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
    }
}
