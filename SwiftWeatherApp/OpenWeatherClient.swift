//
//  OpenWeatherClient.swift
//  SwiftWeatherApp
//

import Foundation
import SwiftHTTP

class OpenWeatherClient {
    func fetchCurrentWeatherInfo(longitude: Float, latitude: Float, success: (WeatherCondition) -> Void) {
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        request.GET("http://api.openweathermap.org/data/2.5/weather",
            //parameters: ["lon": longitude, "lat": latitude],
            parameters: ["q": "Taipei", "units": "metric"],
            success: {(response: HTTPResponse) in
                if let weatherData = response.responseObject as? Dictionary<String, AnyObject> {
                    let weatherCondition = self.extractCurrentWeatherData(weatherData);
                    success(weatherCondition)
                }
            },
            failure: {(error: NSError, response: HTTPResponse?) in
                // TODO: error handling
                println("error: \(error)")
            }
        )

    }
    
    private func extractCurrentWeatherData(weatherData : NSDictionary!) -> WeatherCondition {
        var temperature = round(10 * (weatherData["main"]?["temp"] as? Double)!) / 10
        var temperatureLow = round(10 * (weatherData["main"]?["temp_min"] as? Double)!) / 10
        var temperatureHigh = round(10 * (weatherData["main"]?["temp_max"] as? Double)!) / 10
        var cityName = weatherData["name"] as! String
        var conditionString = weatherData["weather"]?[0]?["main"] as! String
        var weatherIconId = weatherData["weather"]?[0]?["icon"] as! String
        
        var weatherCondition = WeatherCondition();
        weatherCondition.temperature = temperature
        weatherCondition.temperatureLow = temperatureLow
        weatherCondition.temperatureHigh = temperatureHigh
        weatherCondition.cityName = cityName
        weatherCondition.condition = conditionString
        weatherCondition.iconId = weatherIconId
        return weatherCondition
    }
    
    func fetchDailyForecast(longitude: Float, latitude: Float, success: ([WeatherCondition]) -> Void) {
        var request = HTTPTask()
        request.responseSerializer = JSONResponseSerializer()
        request.GET("http://api.openweathermap.org/data/2.5/forecast/daily",
            //parameters: ["lon": longitude, "lat": latitude],
            parameters: ["q": "Taipei", "units": "metric", "cnt": 8],
            success: {(response: HTTPResponse) in
                if let weatherData = response.responseObject as? Dictionary<String, AnyObject> {
                    let dailyForecastData = self.extractDailyForecastData(weatherData);
                    success(dailyForecastData)
                }
            },
            failure: {(error: NSError, response: HTTPResponse?) in
                // TODO: error handling
                println("error: \(error)")
            }
        )
    }
    
    func extractDailyForecastData(weatherData : Dictionary<String, AnyObject>) -> [WeatherCondition] {
        var responsedData = weatherData["list"] as! [Dictionary<String, AnyObject>];
        var dateFormat = NSDateFormatter();
        dateFormat.dateFormat = "EEEE"
        
        var forecastData = [WeatherCondition]()
        for item in responsedData {
            var weatherCondition = WeatherCondition()
            weatherCondition.condition = item["weather"]?[0]?["main"] as! String
            weatherCondition.temperatureLow = round(10 * (item["temp"]?["min"] as! Double)) / 10
            weatherCondition.temperatureHigh = round(10 * (item["temp"]?["max"] as! Double)) / 10
            weatherCondition.iconId = item["weather"]?[0]?["icon"] as! String
            var date = NSDate(timeIntervalSince1970: item["dt"] as! NSTimeInterval)
            weatherCondition.date = dateFormat.stringFromDate(date)
            
            forecastData.append(weatherCondition)
        }
        
        return forecastData;
    }
}