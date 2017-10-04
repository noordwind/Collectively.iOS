//
//  MapController.swift
//  collectively
//
//  Created by Łukasz Bożek on 28/09/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit
import MapKit

class MapController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchElements()
    }
    
    func fetchElements() {
        APIManager.map.getElements() { mapElements in
            var anns = [CLAnnotation]()
            
            for el in mapElements {
                let ann = CLAnnotation()
                ann.coordinate = CLLocationCoordinate2D(latitude: el.location.latitude, longitude: el.location.longitude)
                
                ann.title = el.group?.name ?? "Brak grupy!"
                ann.subtitle = el.desc

                anns.append(ann)
            }
            self.updateMap(with: anns)
        }
    }
    
    func updateMap(with annotations: [MKAnnotation]) {
        mapView.showAnnotations(annotations, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Don't want to show a custom image if the annotation is the user's location.
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        let annotationIdentifier = "AnnotationIdentifier"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: annotationIdentifier) as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotationIdentifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
            let subtitleView = UILabel()
            subtitleView.font = subtitleView.font.withSize(12)
            subtitleView.numberOfLines = 0
            subtitleView.text = annotation.subtitle ?? " "
            annotationView!.detailCalloutAccessoryView = subtitleView
        } else {
            annotationView?.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        print(view.annotation?.title ?? "")
    }
}
