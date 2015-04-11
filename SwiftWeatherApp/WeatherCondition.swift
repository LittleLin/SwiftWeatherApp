//
//  WeatherCondition.swift
//  SwiftWeatherApp
//

import Foundation

struct WeatherCondition {
    var temperature: Double = 0
    var temperatureLow: Double = 0
    var temperatureHigh: Double = 0
    var cityName: String = ""
    var condition: String = ""
    var iconId: String = ""
    
    static var iconMap: Dictionary<String, String> = [
        "01d" : "weather-clear",
        "02d" : "weather-few",
        "03d" : "weather-few",
        "04d" : "weather-broken",
        "09d" : "weather-shower",
        "10d" : "weather-rain",
        "11d" : "weather-tstorm",
        "13d" : "weather-snow",
        "50d" : "weather-mist",
        "01n" : "weather-moon",
        "02n" : "weather-few-night",
        "03n" : "weather-few-night",
        "04n" : "weather-broken",
        "09n" : "weather-shower",
        "10n" : "weather-rain-night",
        "11n" : "weather-tstorm",
        "13n" : "weather-snow",
        "50n" : "weather-mist"
    ]
    
    func getIconName() -> String {
        return WeatherCondition.iconMap[iconId]!
    }
}