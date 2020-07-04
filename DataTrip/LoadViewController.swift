

import UIKit


class LoadViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
             
    }
     

    @IBAction func createAccountClicked(_ sender: Any) {
        
        performSegue(withIdentifier: "toAccount", sender: nil)
        
    }
    
}
