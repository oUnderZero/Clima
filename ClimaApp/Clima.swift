//
//  clima.swift
//  ClimaApp
//
//  Created by Mac11 on 02/05/21.
//


import Foundation

struct  Clima {
    let id: Int
    let temp: Double
    let ciudad: String
    let humedad: Int
    let feels_like: Double
    let lon: Double
    let lat: Double
    let time: String
    let description: String
    let error: Bool
    
    
    var CondicionClima: String {
        switch id {
        case 200...232:
            return "cloud.bold.fill"
        case 300...331:
            return "cloud.hail.fill"
        case 500...531:
            return "cloud.sleet.fill"
        case 600...622:
            return "snow"
        case 701...781:
            return "sun.dust.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.sun.fill"
        default:
            return "cloud.fill"
        }
    }
}
