//
//  BackgroundLocationService.swift
//  Demo App
//
//  Created by Muhammad Usman on 07/04/2020.
//  Copyright © 2020 Usman. All rights reserved.
//

import CoreLocation
import Foundation

// AppDelegate class
// Declare these propetise in your AppDelegate class

// MARK: Class
class AppDelegate: UIResponder, UIApplicationDelegate {
    var userCoordinate: CLLocationCoordinate2D = .init()
    let locationManager = CLLocationManager()
    var bgTimer = Timer()
    var backgroundTaskIdentifier: UIBackgroundTaskIdentifier?
    
    /// All other code over here ....
    
}

// AppDelegate extension for background location update service.
// CoreLocation for location update.
// HTTP Network request to update location on server.

// MARK: Extension
extension AppDelegate {
    
    // Call this method from your appdelegate functions or within your app to start updating location
    
    private func setupBackgroundLocationUpdate() {
        backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            if let backgroundTaskIdentifier = self.backgroundTaskIdentifier {
                UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
            }
        })
        bgTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)
        bgTimer.fire()
    }
    
    // Start updating location
    @objc private func updateLocation() {
       // update location on server here ...
    }
    
    // Stop updating location service
    internal func stopBackgroundLocationService() {
        locationManager.stopMonitoringSignificantLocationChanges()
        bgTimer.invalidate()
    }
    
    // setup location manager
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.allowsBackgroundLocationUpdates = true
    }
}

// MARK: Extension CoreLocation Delegates

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userCoordinate = location
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            setupLocationUpdate()
        }
    }
}
