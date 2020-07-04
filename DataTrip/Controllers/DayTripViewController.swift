

import UIKit
import Firebase


class DayTripViewController: UIViewController {

    @IBOutlet var weatherimage: UIImageView!
    
    @IBOutlet var notesimage: UIImageView!
    
    @IBOutlet var showTripLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        navigationController?.isNavigationBarHidden = true
        
        weatherimage.isUserInteractionEnabled = true
        notesimage.isUserInteractionEnabled = true
        showTripLabel.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageGesture))
        let gesturenNotes = UITapGestureRecognizer(target: self, action: #selector(NotesClicked))
        let gestureTrip = UITapGestureRecognizer(target: self, action: #selector(TripShowClicked))
        
        
        notesimage.addGestureRecognizer(gesturenNotes)
        showTripLabel.addGestureRecognizer(gestureTrip)
        weatherimage.addGestureRecognizer(gestureRecognizer)
        
        
    }
    

   @objc func imageGesture () {
        
        performSegue(withIdentifier: "toWeatherVC", sender: nil)
        
        
        
    }
    
    @objc func NotesClicked() {
        
        performSegue(withIdentifier: "", sender: nil)
        
        
    }
    
    @objc func TripShowClicked () {
        
        
        performSegue(withIdentifier: "", sender: nil)
        
        
    }
    
}
