
import UIKit
import Firebase
import Foundation

class BeforeTripViewController: UIViewController {

    @IBOutlet var tripinfoLabel: UILabel!
    
    @IBOutlet var cityAndDateLabel: UILabel!
    
    @IBOutlet var timeLeftLabel: UILabel!
    
    var locations : String?
    var timer = Timer()
    let db = Firestore.firestore()
    
    
    
    var day = 2
    var hours = 24
    var minute = 60 
    var second = 60
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        tripinfoLabel.isUserInteractionEnabled = true
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.triplabelGesture))
        
        tripinfoLabel.addGestureRecognizer(gesture)
        
        navigationController?.isNavigationBarHidden = true
        
        
        showDateAndLocation()
        startTimer()
    
       

            
    }
    
 
    
    func startTimer() {
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLeft), userInfo: nil, repeats: true)
        
        
        
    }
    
    
    @objc func timeLeft () {
        
        
        second -= 1
                      
              let calendar = Calendar.current
              
              var currentDay = calendar.component(.day, from: Date())
           
        db.collection("Trip").getDocuments { (snapshot, error) in
            
            if error != nil {
                
                print(error?.localizedDescription)
                
                
            } else {
                
                if snapshot?.isEmpty == false  && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        
                        if let day = document.get("day") as? [Int] {
                            
                            if currentDay - day.first! <= 3 {
                                
                                self.timeLeftLabel.text = String("\(self.day) : \(self.hours) : \(self.minute) : \(self.second)")
                                     
                                if self.second == 0 {
                                         
                                        self.second = 60
                                         
                                        self.minute -= 1
                                         
                                    if self.minute == 0 {
                                             
                                            self.second = 60
                                             
                                        self.hours -= 1
                                             
                                        self.minute = 60
                                             
                                        if self.hours == 0 {
                                                 
                                            self.second = 60
                                                 
                                            self.day -= 1
                                                 
                                            self.minute = 60
                                                 
                                            self.hours = 24
                                                 
                                                 
                                             
                                             
                                         }
                                     }
                                    if self.second == 0 && self.minute == 0 && self.hours == 0 && self.day == 0 {
                                         
                                        self.timer.invalidate()
                                         
                                     }
                                    
                                 }
                                
                                
                                
                            }
                                                        
                        }
 
                    }
                    
                }
                
            }
        }
        
     
    }
   
    @objc func triplabelGesture() {
            
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "tabBar") as!
        UITabBarController
        
        controller.selectedIndex = 1
        controller.navigationController?.hidesBarsOnTap = true
        definesPresentationContext = true
        
        controller.modalPresentationStyle = .fullScreen
        
        self.navigationController?.present(controller , animated: true)
        
        
        
    }
    
   
    
    func showDateAndLocation() {
        
    
        db.collection("Trip").getDocuments { (snapshot, error) in
            
            if error != nil {
                
                print(error?.localizedDescription)
                
                
            } else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        
                        if let date = document.get("dateOfTrip") as? [String] {
                            
                            if let city = document.get("location") as? String {
                                
                                
                                self.cityAndDateLabel.text = city + " " + date.first! + " - " + date[1]
                                
                                
                            }
                            
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            }
        }
    
    
}
}
