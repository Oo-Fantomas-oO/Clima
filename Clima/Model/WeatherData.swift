//
//  WeatherData.swift
//  Clima
//
//  Created by Onopriienko.Sergii on 22.04.2021.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id : Int
}
