//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by 김규철 on 2023/08/17.
//

import Foundation

// MARK: - Weather
struct WeatherData: Codable {
    let timezone: Int
    let coord: Coord
    let weather: [WeatherElement]
    let sys: Sys
    let cod, visibility: Int
    let main: Main
    let base: String
    let clouds: Clouds
    let wind: Wind
    let id: Int
    let name: String
    let dt: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Codable {
    let grndLevel: Int
    let temp, feelsLike, tempMin: Double
    let humidity: Int
    let tempMax: Double
    let seaLevel, pressure: Int

    enum CodingKeys: String, CodingKey {
        case grndLevel = "grnd_level"
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case humidity
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case pressure
    }
}

// MARK: - Sys
struct Sys: Codable {
    let type, sunset: Int
    let country: String
    let sunrise, id: Int
}

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int
    let icon, description, main: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed, gust: Double
    let deg: Int
}
