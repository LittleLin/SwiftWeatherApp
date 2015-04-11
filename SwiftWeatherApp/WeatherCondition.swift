//
//  WeatherCondition.swift
//  SwiftWeatherApp
//

import Foundation

class WeatherCondition {
    var temperature: Double = 0
    var temperatureLow: Double = 0
    var temperatureHigh: Double = 0
    var cityName: String = ""
    var condition: String = ""
    var iconId: String = ""
    
    func getIconName() -> String {
        return "weather-clear";
    }
}