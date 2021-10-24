//
//  ViewController.swift
//  ClimaApp
//
//  Created by marco rodriguez on 01/04/21.
//

import UIKit
import CoreLocation
class ClimaViewController:  UIViewController,UITextFieldDelegate, ClimaManagerDelegate, CLLocationManagerDelegate{


    @IBOutlet weak var bgclima: UIImageView!
    @IBOutlet weak var imagenicono: UIImageView!
    var climaManager = ClimaManager()
    let locationManager = CLLocationManager()
    
    var lonUser: CLLocationDegrees = 0.0
    var error = true
    var latUser: CLLocationDegrees = 0.0
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var condicionClimaImageView: UIImageView!
    @IBOutlet weak var feelslikelabel: UILabel!
    @IBOutlet weak var humedadlabel: UILabel!
    @IBOutlet weak var descripcion: UILabel!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var ciudadLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        climaManager.delegate = self
        buscarTextField.delegate = self
        self.locationManager.requestAlwaysAuthorization()

        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }

    @IBAction func buscarButton(_ sender: UIButton) {
         
        if textFieldShouldEndEditing(buscarTextField) {
            buscarTextField.endEditing(true)
            buscarTextField.placeholder="Ciudad"
        }
        
        
        //ciudadLabel.text=buscarTextField.text
    }
    @IBAction func gpsButton(_ sender: UIButton) {
        
        
            climaManager.buscarUbicacion(lon: Double(lonUser), lat: Double(latUser))
          
        
        
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lonUser = locValue.longitude
        latUser = locValue.latitude
        print("Coords = \(locValue.latitude) \(locValue.longitude)")
    }
    //metodo del delegado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         
        buscarTextField.endEditing(true)
        
        return true
    }
    
    //no dejarlo continuar if vacio.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTextField.text != "" {
            
            return true
        }else{
            buscarTextField.placeholder = "no puedes dejar vacio.."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        climaManager.buscarClima(ciudad: buscarTextField.text!)
        buscarTextField.text = ""
        buscarTextField.placeholder="Ciudad"
        if error == true {
            let alerta = UIAlertController(title: "Error!",
                                           message: "No se ha encontrado la ciudad indicada",
                                           preferredStyle: UIAlertController.Style.alert)
            let accion = UIAlertAction(title: "Cerrar",
                                       style: UIAlertAction.Style.default) { _ in
                alerta.dismiss(animated: true, completion: nil) }
            alerta.addAction(accion)
            self.present(alerta, animated: true, completion: nil)
            
        }
        
        
    }
    func actclima(clima: Clima) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = String(format: "%.1f", clima.temp)
            self.ciudadLabel.text = clima.ciudad
                self.imagenicono.image =
                    UIImage(systemName: clima.CondicionClima)
                    if(clima.temp > 20){
                        self.bgclima.image = UIImage(named: "clima")
                    } else {
                        self.bgclima.image = UIImage(named: "frio")
                    }
                self.feelslikelabel.text = String(clima.feels_like)
            self.descripcion.text=clima.description
            self.humedadlabel.text = String(clima.humedad)
            self.error = clima.error
        }
    }
    
    
}

