import UIKit
import MBProgressHUD

class BeerListViewController: UITableViewController {
    let beerManager = BeerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = AppConstants.appTitle
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(updateBeers))
        
        self.updateBeers()
    }
    
    @objc func updateBeers() {
        let progressHUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressHUD.removeFromSuperViewOnHide = true
        
        self.beerManager.getBeers { (success) in
            self.tableView.reloadData()
            if success {
                progressHUD.hide(animated: true)
            } else {
                progressHUD.mode = .text
                progressHUD.label.numberOfLines = 2
                progressHUD.label.text = AppConstants.loadingErrorMessage
                progressHUD.hide(animated: true, afterDelay: 3)
            }
        }
    }
        
    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == AppConstants.showBeerDetailSegue {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = segue.destination as! DetailViewController
                controller.beer = BeerViewModel(beer: self.beerManager.beerList[indexPath.row])
                self.tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
            }
        }
    }
    
    // MARK: - Table View
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return BeerListCell.cellHeight
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beerManager.beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerListCell.cellReuseIdentifier, for: indexPath) as! BeerListCell
        let beerViewModel = BeerViewModel(beer: self.beerManager.beerList[indexPath.row])
        cell.fill(with: beerViewModel)
        return cell
    }
}
