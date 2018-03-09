//
//  MapaTabBar.swift
//  LaNaranja
//
//  Created by Víctor Manuel Hernández Ramírez on 09/03/18.
//  Copyright © 2018 Ricardo Altamirano Cabrera. All rights reserved.
//

import UIKit
import GoogleMaps

class MapaTabBar: UIViewController, GMSMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let camera = GMSCameraPosition.camera(withLatitude: 19.002887, longitude: -98.202042, zoom: 17.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
