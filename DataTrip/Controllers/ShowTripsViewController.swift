

import UIKit
import Firebase
import FSCalendar

class ShowTripsViewController: UIViewController {

    @IBOutlet var tripInfoLabel: UILabel!
    @IBOutlet var addTripLabel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(makeSearch))
        
        tripInfoLabel.isUserInteractionEnabled = true
        addTripLabel.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tripInfoClicked))
        let gesturerecog = UITapGestureRecognizer(target: self, action: #selector(addTripClicked))
        
        tripInfoLabel.addGestureRecognizer(gesture)
        addTripLabel.addGestureRecognizer(gesturerecog)
        
     
       
    }
    @objc func addTripClicked() {
        
        
        
        
        
    }
    
    
    
    @objc func makeSearch () {
        
        
    
        
        
    }
    
    @objc func tripInfoClicked(){
        
        
        performSegue(withIdentifier: "toCurrentVC", sender: nil)
        
        
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    
        let dayformatter = DateFormatter()
            
        dayformatter.dateFormat = "dd MMMM"
            
        dayformatter.string(from: date)
        
        
        
   

    }
    
    
    
    @IBAction func pastTripClicked(_ sender: Any) {
        
            
        
    }
    
    @IBAction func nextTripClicked(_ sender: Any) {
        
        
        
    }
    
    
    
}
