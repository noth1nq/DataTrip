
import UIKit
import Firebase

class RouterViewController: UINavigationController {
    
    var cityLocation : String?
    var tripModelArray = [tripModel]()
    
    

    var db = Firestore.firestore()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        changeTripController()
        showDayTrip()
        
        
    }
    
    
    
    func changeTripController () {
      
        
        db.collection("Trip").addSnapshotListener { (snapshot, error) in
            if error != nil {
                         
               self.makeAlert(title: "ERROR!", message: error?.localizedDescription ?? "ERROR!")
                         
                     } else {
                         
                         
                         if snapshot?.isEmpty == false && snapshot != nil {
                             
                          
                         for document in snapshot!.documents {
                             
                             if let dateTrip = document.get("dateOfTrip") as? [String]{
                                
                                 if let city = document.get("location") as? String {
                                    
                                     if let name = document.get("name") as? String {
                                      
                                        if let day = document.get("day") as? [Int] {
                                            
                                            let userinfo = ["city" : city]
                                            NotificationCenter.default.post(name: .myNotificationKey, object: nil, userInfo: userinfo)
                                           
                                         let currentindex = self.tripModelArray.last?.id
                                         
                                        var infoModel = tripModel(name: name, date: dateTrip, location: city, id: (currentindex ?? -1) + 1, day: day)
                                            
                                        self.tripModelArray.append(infoModel)
                                            
                                            
                                         let calendar = Calendar.current
                                              
                                         let currentDay = calendar.component(.day, from: Date())
                                              
                                        
                                            if day.first != currentDay {
                                                  
                                                  
                                               let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                                                                                        
                                                 let controller = storyboard.instantiateViewController(withIdentifier: "BeforeTripVC") as UIViewController
                                                
                                                
                                                 self.viewControllers = [controller]
                                                  
                                            
                                              }
                                         
                                     }
                                        
                                        
                                     
                                     
                                 }
                                 
                             }
                             
                             
                         }
                            
                            
                         
                     }
                     
                 }
                 
                 }
                
                
        }
         
        
        }
            
        
        
    
    func showDayTrip() {
        
       
        let calendar = Calendar.current
        
        let currentDay = calendar.component(.day, from: Date())
        
        print(tripModelArray.first)
        
        var db = Firestore.firestore()
        
        db.collection("Trip").addSnapshotListener { (snapshot, error) in
            if error != nil {
                
                print(error?.localizedDescription)
                
            } else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    
                    for document in snapshot!.documents {
                        
                        
                      if let dayArray = document.get("day") as? [Int] {
                            
                        if dayArray.first == currentDay {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                      
                                   let controller = storyboard.instantiateViewController(withIdentifier: "dayTrip") as! DayTripViewController
                                      
                                      
                            self.viewControllers = [controller]
                                       
                            
                            
                            
                        }
                           
                            
                        }
                        
                        
                    }
                    
                    
                }
                
                
            }
        }
        
        
        
    }
    
    func makeAlert (title : String , message : String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let alertButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(alertButton)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
        

}
extension Notification.Name {
    
    public static let myNotificationKey = Notification.Name(rawValue: "myNotificationKey")
    
    
}



