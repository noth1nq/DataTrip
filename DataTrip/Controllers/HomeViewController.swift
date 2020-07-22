
import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet var messageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.isNavigationBarHidden = true
        
    }
    

    @IBAction func tripClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toAddTrip", sender: nil)
        
        
    }
    
}
