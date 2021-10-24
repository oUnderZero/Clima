//
//  ClimaDatos.swift
//  ClimaApp
//
//  Created by Mac11 on 01/05/21.
//

import Foundation
struct ClimaDatos: Decodable {
    let name: String
    let id: Int
    let cod: Int
    let main: Main
    let weather: [Weather]
    let coord: Coord
}
struct Coord: Decodable {
    let lon: Double
    let lat: Double
}
struct Main: Decodable {
    let temp: Double
    let feels_like: Double
    let humidity: Int
}
struct Weather: Decodable {
    let id: Int
    let description: String
}
