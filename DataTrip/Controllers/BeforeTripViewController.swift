
import UIKit
import Firebase
class BeforeTripViewController: UIViewController {

    @IBOutlet var tripinfoLabel: UILabel!
    
    @IBOutlet var cityAndDateLabel: UILabel!
    
    @IBOutlet var timeLeftLabel: UILabel!
    
    var locations : String?
    var timer = Timer()
    
    
    
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
        
        
        
        startTimer()
        
       
       

            
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived(_:)), name: .myNotificationKey, object: nil )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .myNotificationKey, object: nil)
    }
    
    func startTimer() {
        
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeLeft), userInfo: nil, repeats: true)
        
        
        
    }
    
    
    @objc func timeLeft () {
        
        
        second -= 1
                      
              let calendar = Calendar.current
              
              var currentDay = calendar.component(.day, from: Date())
              
      
        
        timeLeftLabel.text = String("\(day) : \(hours) : \(minute) : \(second)")
        
        if second == 0 {
            
            second = 60
            
            minute -= 1
            
            if minute == 0 {
                
                second = 60
                
                hours -= 1
                
                minute = 60
                
                if hours == 0 {
                    
                    second = 60
                    
                    day -= 1
                    
                    minute = 60
                    
                    hours = 24
                    
                    
                
                
            }
        }
        if second == 0 && minute == 0 && hours == 0 && day == 0 {
            
            timer.invalidate()
            
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
    
    @objc func notificationReceived (_ notification : Notification) {
        
        
        guard let location = notification.userInfo?["city"] as? String else {
            
            return
        }
        
        cityAndDateLabel.text = "city: \(location)"
        
    }
    
}
