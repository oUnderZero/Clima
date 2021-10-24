//
//  ClimaManager.swift
//  ClimaApp
//
//  Created by Mac11 on 01/05/21.
//

import Foundation
protocol ClimaManagerDelegate {
    func actclima(clima: Clima)
}
struct ClimaManager {
    let ClimaUrl="https://api.openweathermap.org/data/2.5/weather?appid=03c95df11102bdae5efc8d146aea716c&units=metric&lang=es"
    var delegate: ClimaManagerDelegate?
    
    func buscarClima(ciudad: String){
        let urlString  = "\(ClimaUrl)&q=\(ciudad)"
        realizarSolicitud(urlString: urlString)
    }
    func buscarUbicacion(lon: Double, lat: Double){
        let urlString = "\(ClimaUrl)&lon=\(lon)&lat=\(lat)"
        realizarSolicitud(urlString: urlString)
    }
    func realizarSolicitud(urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let tarea = session.dataTask(with: url) { (datos, respuesta, error) in
                
                if error != nil {
                    print("error al obtener los datos: \(error!)")
                    return
                }
                
                if let datosSeguros = datos {
                    
                    if let climaobj = self.parsearJson(datosClima: datosSeguros) {
                    self.delegate?.actclima(clima: climaobj)
                    }
                }
            }
            tarea.resume()
        }
        
    }
    
    func parsearJson(datosClima: Data)-> Clima?{
        //decodificarod JSON
        let decodificador = JSONDecoder()
        do {
            let datosDecodificados = try decodificador.decode(ClimaDatos.self, from: datosClima)
            //imprimir los datos de la API en uin formato especifico
            print(datosDecodificados)
            let id = datosDecodificados.weather[0].id
            let ciudad = datosDecodificados.name
            let temp = datosDecodificados.main.temp
            let feels_like = datosDecodificados.main.feels_like
            let humedad = datosDecodificados.main.humidity
            let lon = datosDecodificados.coord.lon
            let lat = datosDecodificados.coord.lat
            let des = datosDecodificados.weather[0].description
            let climaobj = Clima(id: id, temp: temp, ciudad: ciudad, humedad: humedad, feels_like: feels_like, lon: lon, lat: lat, time: "dia", description: des, error: false)
            //ObtenerCondicionClima(idClima: id)
            
            return climaobj
        } catch {
            let climaobj = Clima(id: 0, temp: 0, ciudad: "No se encontro ninguna ciudad", humedad: 0, feels_like: 0, lon: 0, lat: 0, time: " ", description: "" , error: true)
            print("error al decodificar los datos \(error.localizedDescription)")
           print(datosClima)
           
            return climaobj
        }
    }
    
}
