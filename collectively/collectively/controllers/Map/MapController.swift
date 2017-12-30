//
//  MapController.swift
//  collectively
//
//  Created by Łukasz Bożek on 28/09/2017.
//  Copyright © 2017 collectively. All rights reserved.
//

import UIKit
import MapKit
import RxSwift

class MapController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var buttonsStackHeight: NSLayoutConstraint!
    @IBOutlet weak var stackBottomConstraint: NSLayoutConstraint!
    
    var viewModel: MapViewModel!
    var disposeBag: DisposeBag = DisposeBag()
    
    var selectedElement: MapModel?
    
    override func viewDidLoad() {
        setupViewModel()
        setupBinding()
        mapView.showsUserLocation = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
        addButtonAction(open: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        _ = self.viewModel.getMapModels().subscribe { event in
            switch event {
            case .completed:
                print("refreshed")
            case .error(let error):
                //handleError(error)
                print(error)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func setupViewModel() {
        self.viewModel = MapViewModel()
        self.viewModel.getMapModels().subscribe { [weak self] event in
            guard let weakSelf = self else { return }
            switch event {
            case .completed:
                weakSelf.makeAnnotations(with: weakSelf.viewModel.models.value)
            case .error(let error):
                // TODO: handle error
                print(error)
            }
            }.disposed(by: self.disposeBag)
    }
    
    fileprivate func setupBinding() {
        self.viewModel.models.asObservable().subscribe { [weak self] (event) in
            guard let weakSelf = self else { return }
            switch event {
            case .next(_):
                weakSelf.makeAnnotations(with: weakSelf.viewModel.models.value)
            case .error(let error):
                // TODO: handle error
                print(error)
            case .completed:
                weakSelf.makeAnnotations(with: weakSelf.viewModel.models.value)
                print(event)
            }
            }.disposed(by: self.disposeBag)
    }
    
    func makeAnnotations(with elements: [MapModel]) {
        let anns = self.viewModel.makeAnnotations()
        self.updateMap(with: anns)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let details = segue.destination as? ProblemViewController {
            details.problem = selectedElement!
        }
    }
}

extension MapController: MKMapViewDelegate {

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
        } else {
            annotationView?.annotation = annotation
        }
        let subtitleView = UILabel()
        subtitleView.font = subtitleView.font.withSize(12)
        subtitleView.numberOfLines = 0
        subtitleView.text = annotation.subtitle ?? " "
        annotationView!.detailCalloutAccessoryView = subtitleView
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        selectedElement = (view.annotation as! CLAnnotation).problem
        performSegue(withIdentifier: "presentDetails", sender: nil)
    }
}
