
import UIKit

class CurrentTripViewController: UIViewController {
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var savedPlacesLabel: UILabel!
    @IBOutlet var tripInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.modalPresentationStyle = .fullScreen
        
        
        weatherImage.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showWeather))
        
        weatherImage.addGestureRecognizer(gesture)
    }
    

    
    @objc func showWeather(){
        
        performSegue(withIdentifier: "toWeatherVC", sender: nil)
        
        
        
    }
    
    @objc func editTrip() {
        
        
        
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
       let selectedBarItem =  storyboard.instantiateViewController(withIdentifier: "tabBar") as? UITabBarController
        
        
        selectedBarItem?.selectedIndex = 1
        selectedBarItem?.modalPresentationStyle = .fullScreen
        
        
        self.present(selectedBarItem!, animated: true, completion: nil)
        
        
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        
        
    }
}
