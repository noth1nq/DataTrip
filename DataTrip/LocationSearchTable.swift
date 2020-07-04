
import UIKit
import MapKit


class LocationSearchTable: UITableViewController {
    
    

     var matchingItems : [MKMapItem] = []
     var mapView : MKMapView? = nil
    
     var handleMapSearchDelegate : HandleMapSearch? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        
        

    }

    // MARK: - Table view data source

}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let mapView = mapView ,
        
            let searchBarText = searchController.searchBar.text  else {
                
                return
        }
        
        let request = MKLocalSearch.Request()
        
        request.naturalLanguageQuery = searchBarText
        
        
        
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        
        search.start { (response, error) in
            guard let responses = response  else{
                
                return
                
            }
            
            self.matchingItems = responses.mapItems
            self.tableView.reloadData()
            
        }
        
    }
}

extension LocationSearchTable {
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        handleMapSearchDelegate?.dropPinZoomIn(placemark: selectedItem)
        dismiss(animated: true, completion: nil)
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
     func tableView( tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        let address = "\(selectedItem.thoroughfare ?? ""), \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
        cell.detailTextLabel?.text = address
    
        return cell
    }
}

