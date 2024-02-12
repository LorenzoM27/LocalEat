//
//  LocationManager.swift
//  LocalEat
//
//  Created by Lorenzo Menino on 12/02/2024.
//

import MapKit

final class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    
    @Published var region = MKCoordinateRegion(
        center: .init(latitude: 37.334_900, longitude: -122.009_020),
        span: .init(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        // We can configure it in many ways. For example, we could specify a lower desiredAccuracy to consume less battery.
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.setup()
    }
    // Cette méthode setup(). Si l'utilisateur nous a donné l'autorisation, nous demanderons l'emplacement de l'utilisateur avec locationManager.requestLocation() (cette méthode ne demandera l'emplacement qu'une seule fois). D'un autre côté, si nous n'avons pas l'autorisation de l'utilisateur, nous la demanderons.
    
    func setup() {
        switch locationManager.authorizationStatus {
        //If we are authorized then we request location just once, to center the map
        case .authorizedWhenInUse:
            locationManager.requestLocation()
        //If we don´t, we request authorization
        case .notDetermined:
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
        default:
            break
        }
    }
}

// Nous devons d'abord implémenter le protocole CLLocationManagerDelegate. Deuxièmement, nous devons faire en sorte que notre LocationManager hérite de NSObject (cela est nécessaire pour mettre en œuvre le protocole).

extension LocationManager: CLLocationManagerDelegate {
    
    // Le premier est appelé lorsque l'utilisateur modifie l'autorisation. S'il est accepté, nous voulons demander l'emplacement afin de mettre à jour la carte (comme nous l'avons fait dans la méthode de configuration)
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        guard .authorizedWhenInUse == manager.authorizationStatus else { return }
        locationManager.requestLocation()
    }
    
    // La deuxième méthode consiste simplement à prévenir les accidents. Pour cet exemple, nous le laisserons vide, mais n'hésitez pas à y mettre en œuvre toute gestion des erreurs.
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error)")
    }
    
    // La dernière méthode est la plus intéressante. Il est appelé lorsque nous avons une mise à jour de localisation, et il nous donne un tableau de CLLocation. Selon la documentation officielle, le dernier emplacement du tableau est le plus récent, nous l'utiliserons donc pour centrer la carte sur la position de l'utilisateur.
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        locations.last.map {
            region = MKCoordinateRegion(
                center: $0.coordinate,
                span: .init(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }
    }
    
//    func requestLocation() {
//        locationManager.requestLocation()
//    }
}
