
import UIKit

class CurrentTripViewController: UIViewController {
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var savedPlacesLabel: UILabel!
    @IBOutlet var tripInfoLabel: UILabel!
    
    var transparentView = UIView()
    var tableView = UITableView()
    
    var height : CGFloat = 200
    var settingArray : [String] = ["Edit","Delete","Cancel"]
    
    
 
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.isScrollEnabled = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(customTableViewCell.self, forCellReuseIdentifier: "Cell")
       
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
        
              let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
              transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
              transparentView.frame = self.view.frame
              window?.addSubview(transparentView)
              
              let screenSize = UIScreen.main.bounds.size
              tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: height)
              window?.addSubview(tableView)
              
              let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onClickTransparentView))
              transparentView.addGestureRecognizer(tapGesture)
              
              transparentView.alpha = 0
              
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                  self.transparentView.alpha = 0.5
                  self.tableView.frame = CGRect(x: 0, y: screenSize.height - self.height, width: screenSize.width, height: self.height)
              }, completion: nil)
        
        
    }
    
    @objc func onClickTransparentView(){
        
        let screenSize = UIScreen.main.bounds.size

               UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                   self.transparentView.alpha = 0
                   self.tableView.frame = CGRect(x: 0, y: screenSize.height, width: screenSize.width, height: self.height)
               }, completion: nil)
           }
    }
    
extension CurrentTripViewController : UITableViewDelegate , UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? customTableViewCell
        cell?.lbl.text = settingArray[indexPath.row]
        cell?.settingImage.image = UIImage(named: "")
        
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return settingArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if settingArray[indexPath.row] == "delete" {
            
            
            
            
            
            
        }
        
        
    }
    
    
    
    
    
}


  
