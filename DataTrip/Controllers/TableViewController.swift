

import UIKit
import MapKit

class TableViewController: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var matchingItems : [MKMapItem] = []
    var mapView : MKMapView? = nil
    
    var handleMapSearchDelegate : HandleMapSearch? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.delegate = self
        tableView.dataSource = self
        
            
        
}
    
    
}

extension TableViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let mapView = mapView ,
              
                  let searchBarText = searchController.searchBar.text  else {
                      
                      return
                  }
                  
              let request = MKLocalSearch.Request()
              
              request.naturalLanguageQuery = searchBarText
              
              request.region = mapView.region
        
              
              let search = MKLocalSearch(request: request)
              
              search.start { (response, error) in
                  guard let response = response  else{
                      
                      return
                      
                  }
                  self.matchingItems = response.mapItems
                  
                  self.tableView.reloadData()
                  
              }
    
    }
   
    }


extension TableViewController {
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return matchingItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                let selectedItem = matchingItems[indexPath.row].placemark
                cell.textLabel?.text = selectedItem.name
                let address = "\(selectedItem.thoroughfare ?? ""), \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
                cell.detailTextLabel?.text = address
            
                return cell
            }
        }

extension TableViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let selectedItem = matchingItems[indexPath.row].placemark
            handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
            dismiss(animated: true, completion: nil)
    }
               
            }
        





