//
//  WeatherManager.swift
//  Clima
//
//  Created by Onopriienko.Sergii on 20.04.2021.
//

import Foundation

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=2070d96882c850e284148d27b3a37fc1&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
