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
    @IBOutlet weak var buttonsStackHeight: NSLayoutConstraint!
    @IBOutlet weak var stackBottomConstraint: NSLayoutConstraint!
    
    var selectedElement: MapModel?
    
    override func viewDidLoad() {
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        addButtonAction(open: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchElements()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func fetchElements() {
        APIManager.map.getElements() { mapElements in
            var anns = [CLAnnotation]()
            
            for el in mapElements {
                let ann = CLAnnotation()
                ann.coordinate = CLLocationCoordinate2D(latitude: el.location.latitude, longitude: el.location.longitude)
                print(el.mediumPhotoUrl)
                ann.title = el.group?.name ?? "Brak grupy!"
                ann.subtitle = el.desc
                ann.problem = el
                anns.append(ann)
            }
            self.updateMap(with: anns)
        }
    }
    
    @IBAction func addButton(_ sender: Any) {
        addButtonAction(open: buttonsStackHeight.constant == 0)
    }
    
    func addButtonAction(open: Bool) {
        if open {
            buttonsStackHeight.constant = 160
            stackBottomConstraint.constant = 5
        } else {
            buttonsStackHeight.constant = 0
            stackBottomConstraint.constant = -20
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutSubviews()
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
        selectedElement = (view.annotation as! CLAnnotation).problem
        performSegue(withIdentifier: "presentDetails", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let details = segue.destination as? ProblemViewController {
            details.problem = selectedElement!
        }
    }
}
