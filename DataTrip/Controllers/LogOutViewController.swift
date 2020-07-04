
import UIKit
import Firebase

class LogOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func logOutClicked(_ sender: Any) {
        
        let user = Auth.auth()
        
        do {
            
        try user.signOut()
               
            
        }
        catch {
            
            print("ERROR!")
            
        }
        
        performSegue(withIdentifier: "toFirstPage", sender: nil)
        
       
        
    }
    
}
