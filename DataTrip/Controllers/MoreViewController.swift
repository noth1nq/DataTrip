

import UIKit
import Firebase

class MoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var moretableViewArray = ["Compare Trips" , "Notes" , "Wishlist" , "Settings","LogOut"]
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return moretableViewArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel!.text = moretableViewArray[indexPath.row]
        
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if moretableViewArray[indexPath.row] == "LogOut"{
            
            performSegue(withIdentifier: "toLogout", sender: nil)
            
        }
        
        
    }
    
}
