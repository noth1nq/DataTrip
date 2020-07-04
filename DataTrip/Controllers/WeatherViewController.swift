import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation
import NVActivityIndicatorView

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var imageLabel: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempretureLabel: UILabel!
    
    
    let apiKey = "66904e8b326f99d8a58912e3aba65f6b"
    var latitude = 11.344533
    var longitude = 104.33322
    let locationManager = CLLocationManager()
    
    var activityIndicator : NVActivityIndicatorView!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let indicatorSize : CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize)/2, y: (view.frame.height-indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        
        activityIndicator.color = UIColor.black
        
        view.addSubview(activityIndicator)
        
        
        locationManager.requestWhenInUseAuthorization()
        
        
        activityIndicator.startAnimating()
        
        if (CLLocationManager.locationServicesEnabled()) {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
            
        }
        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(done))
        
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let location = locations[0]
        longitude = location.coordinate.longitude
        latitude = location.coordinate.latitude
        
        DispatchQueue.main.async {
            

            Alamofire.request("http://api.openweathermap.org/data/2.5/weather?lat=\(self.latitude)&lon=\(self.longitude)&appid=\(self.apiKey)&units=metric").responseJSON{ response in
                
                
                self.activityIndicator.stopAnimating()
                
                if let responseStr = response.result.value {
                    
                    let jsonResponse = JSON(responseStr)
                    
                    let jsonWeather = jsonResponse["weather"].array![0]
                    
                    let jsonTemp = jsonResponse["main"]
                    
                    let iconName = jsonWeather["icon"].stringValue
                    
                    
                    
                    
                    self.cityLabel.text = jsonResponse["name"].stringValue
                    self.imageLabel.image = UIImage(named: iconName)
                    self.weatherLabel.text = jsonResponse["main"].stringValue
                    self.tempretureLabel.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
                    
                    let date = Date()
                    
                    let dateFormatter = DateFormatter()
                    
                    dateFormatter.dateFormat = "EEEE"
                    
                    
                    self.dayLabel.text = dateFormatter.string(from: date)
                    
                    
                }
                
                
            }
            
            
        }
        
        self.locationManager.stopUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    
    
    @objc func done() {
        
        
        let selectedTabBar = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as? UITabBarController
        
        selectedTabBar?.selectedIndex = 0
        selectedTabBar?.modalPresentationStyle = .fullScreen
        
        self.present(selectedTabBar! , animated: true)

    }

    
    
    
    
}



