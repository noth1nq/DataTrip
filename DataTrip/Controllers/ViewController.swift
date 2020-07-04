
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
   
    @IBAction func createAccountClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toAccount", sender: nil)
        
        
    }
    
    
}
