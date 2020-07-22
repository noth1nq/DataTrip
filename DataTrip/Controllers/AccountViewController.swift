

import UIKit
import Firebase

class AccountViewController: UIViewController {
    
    @IBOutlet var emailLabel: UITextField!
    
    @IBOutlet var passwordLabel: UITextField!
    
    @IBOutlet var nameLabel: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    

    @IBAction func accountCreated(_ sender: Any) {
        
        let user = Auth.auth()
        
        user.createUser(withEmail: emailLabel.text!, password: passwordLabel.text!) { (result, error) in
            if error != nil {
                
                self.alertFuntion(insertAlert: "USERNAME/PASSWORD!" , messageAlert: error?.localizedDescription ?? "ERROR!")
                
            } else {
                
                let dataBase = Firestore.firestore()
                      
                   let tripArray : [String : Any] = ["email" : self.emailLabel.text! , "id" : result?.user.uid, "name" : self.nameLabel.text!]
                           
                dataBase.collection("Trip").document("info").setData(tripArray) { (error) in
                    
                    if error != nil {
                        
                        print(error?.localizedDescription)
                        
                    }
                    
                    
                }
                
                
                self.performSegue(withIdentifier: "toMainPage", sender: nil)
                
            
            }
            
            
        }
        
    }
    
    func alertFuntion (insertAlert : String , messageAlert : String) {
        
        
        let alert = UIAlertController(title: insertAlert, message: messageAlert, preferredStyle: UIAlertController.Style.alert)
        let button = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(button)
        
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
}
