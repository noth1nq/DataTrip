//


import UIKit
import MapKit
import FSCalendar
import Firebase



protocol HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark)
    
}


class TripViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,FSCalendarDelegate{
    
    
    @IBOutlet var calendar: FSCalendar!
    
    let locationmanager = CLLocationManager()
    
    var selectedPin : MKPlacemark? = nil
    
    var resultSearchController : UISearchController? = nil
    
    var dateArray : [String] = []
    var dayArray : [Int] = []
    
    
    
    
    
    @IBOutlet var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mapView.delegate = self
        locationmanager.delegate = self
        calendar.delegate = self
            
        
      
        
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        
        locationmanager.startUpdatingLocation()
        
       
        
    
            
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(choosenLocation(gestureRecognizer:)))
        
        gestureRecognizer.minimumPressDuration = 2
    
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
        
            
        let locationSearchTable  = storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
         
         
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
         
        resultSearchController?.searchResultsUpdater = locationSearchTable as UISearchResultsUpdating
         
         
        let searchBar = resultSearchController?.searchBar
         
        searchBar?.sizeToFit()
        searchBar?.placeholder = "Search for places"
        searchBar?.barTintColor = .black
        
        navigationItem.searchController = resultSearchController
        navigationItem.titleView = resultSearchController?.searchBar
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneTrip))
        
        
        resultSearchController?.hidesNavigationBarDuringPresentation
        
        definesPresentationContext = true
        
        
        locationSearchTable.mapView = mapView
        locationSearchTable.handleMapSearchDelegate = self
        
        
        
        
    }
    
    @objc func doneTrip(){
        
       
      
            let getViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as!  UITabBarController
                 getViewController.selectedIndex = 0
                 definesPresentationContext = true
                getViewController.modalPresentationStyle = .fullScreen
                                 
                self.navigationController?.present(getViewController, animated: true)
                        
     
       
    }
        
        
    @objc func choosenLocation(gestureRecognizer : UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began {
            
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = touchedCoordinates
            annotation.title = "SzimplaKert"
            annotation.subtitle = "bar"
            
            
            self.mapView.addAnnotation(annotation)
            
            
        }
       
        
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        
        dateArray.append(formatter.string(from: date))
        
        
        let cal = Calendar.current
        
        dayArray.append(cal.component(.day, from: date))
        
        let db = Firestore.firestore()
        
        var ref : DocumentReference? = nil
        
        let calendarDic : [String : Any] = ["dateOfTrip" : dateArray, "day" : dayArray]
        
        ref = db.collection("Trip").document("info")
        
        ref?.updateData(calendarDic)
        
        
        
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first {
            
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
               
               let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
               
               let region = MKCoordinateRegion(center: location, span: span)
               
               
               mapView.setRegion(region, animated: true)
            
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            
            return nil
            
        }
          
        let reuseId = "Myannotation"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        
        if pinView == nil {
            
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
           
            
            
            let button = UIButton(type: UIButton.ButtonType.detailDisclosure)
            
            pinView?.rightCalloutAccessoryView = button
            
            
            
        } else {
            
            pinView?.annotation = annotation
            
            
        }
        
        
        return pinView
        
        
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
      
            
            let requestLocation = CLLocation(latitude: 47.49623, longitude: 19.06287)
            
            
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if  let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let newPlacemark = MKPlacemark(placemark: placemark[0])
                        
                        let item = MKMapItem(placemark: newPlacemark)
                        
                        item.name = "Szimpla Kert"
                        
                        var launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                        _ = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeWalking]
                        
                        item.openInMaps(launchOptions: launchOptions)
                        
                        
                    }
                    
                }
                
            }
            
        }
        
    
}

extension TripViewController {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationmanager.requestLocation()
            
            
        }
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("location: \(location)")
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: \(error.localizedDescription)")
    }
}

    extension TripViewController : HandleMapSearch {
    func dropPinZoomIn(placemark: MKPlacemark) {
        
        selectedPin = placemark
        
        mapView.removeAnnotations(mapView.annotations)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality {
            
            let state = placemark.administrativeArea
            
            annotation.subtitle = "\(city) \(state)"
            
            
            let database = Firestore.firestore()
            
            var referance : DocumentReference? = nil
            
            
            let tripDic : [String : Any] = ["location" : city]
 
            referance = database.collection("Trip").document("info")
            
            referance?.updateData(tripDic)
                
            
            
            
    }
        
        mapView.addAnnotation(annotation)
        
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
  
        
        mapView.setRegion(region, animated: true)
        
}
       

}
