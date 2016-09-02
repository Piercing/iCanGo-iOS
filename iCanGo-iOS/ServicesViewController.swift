import UIKit
import RxSwift

class ServicesViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var requestDataInProgress: Bool = false
    private var currentPage: UInt = 1
    private var services: [Service]?
    
    
    // MARK: - Constants
    let cellId = "serviceCell"
    let nibId = "ServiceCellView"
    
    
    // MARK: - Init
    convenience init() {

        self.init(nibName: "ServicesView", bundle: nil)
        
        // Add as observer
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ServicesViewController.refreshServiceList(_:)),
                                                         name: notificationKeyServicesChange,
                                                         object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: notificationKeyServicesChange, object: nil)
    }
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Register Nib Cells.
        registerCustomCell()
        
        // Configure collection views.
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        
        // Initialize variables.
        self.services = [Service]()
        
        // Setup UI.
        setupUIAllServices()

        // Get data from API.
        getDataFromApi("", page: self.currentPage)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: Notification Methods
    func refreshServiceList(notification: NSNotification) {

        currentPage = 1
        services?.removeAll()
        servicesCollectionView.reloadData()
        getDataFromApi("", page: self.currentPage)
    }

    
    // MARK: Private Methods
    private func registerCustomCell() {
        servicesCollectionView.registerNib(UINib(nibName: nibId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    private func setupUIAllServices() -> Void {
        
        self.title = Appearance.setupUI(self.view, title: servicesListVC)
        searchBar.resignFirstResponder()
        Appearance.tabBarColor(self.tabBarController!)
        Appearance.customizeAppearance(self.view)
        servicesCollectionView.fadeOut(duration: 0.0)
    }
    
    private func getDataFromApi(stringToFind: String, page: UInt) -> Void {
        
        if !isConnectedToNetwork() {
            showAlert(noConnectionTitle, message: noConnectionMessage, controller: self)
            return
        }
        
        if requestDataInProgress {
            return
        }

        actionStarted(activityIndicatorView)
        requestDataInProgress = true
        let session = Session.iCanGoSession()
        let _ = session.getServices(nil, longitude: nil, distance: nil, searchText: stringToFind, page: page, rows: rowsPerPage)
                    
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                        
                actionFinished(self!.activityIndicatorView)
                        
                switch event {
                case let .Next(services):
                    self?.requestDataInProgress = false
                    if services.count > 0 {
                        self?.services?.appendContentsOf(services)
                        self?.servicesCollectionView.reloadData()
                        self?.servicesCollectionView.fadeIn(duration: 0.3)
                        self?.currentPage += 1
                    } else {
                        showAlert(serviceSearchNoTitle, message: serviceSearchNoMessage, controller: self!)
                    }
                            
                case .Error (let error):
                    self?.requestDataInProgress = false
                    print(error)
                            
                default:
                    self?.requestDataInProgress = false
                }
        }
    }
}


// MARK: - Extensions - Collection view delegates and datasource
extension ServicesViewController: UISearchBarDelegate {
    
    func textFieldShouldReturn(searchBar: UISearchBar) -> Bool {
        
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        searchBar.endEditing(true)
        currentPage = 1
        services?.removeAll()
        servicesCollectionView.reloadData()
        getDataFromApi(searchBar.text!, page: self.currentPage)
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.showsCancelButton = true
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        
        deActivateSearchBar()
        currentPage = 1
        services?.removeAll()
        servicesCollectionView.reloadData()
        searchBar.text = ""
        getDataFromApi("", page: self.currentPage)
    }
    
    func deActivateSearchBar() {
        
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        for ob: UIView in ((searchBar.subviews[0] )).subviews {
            
            if let z = ob as? UIButton {
                let btn: UIButton = z
                btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            }
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if services?.count != 0 {
            services?.removeAll()
            servicesCollectionView.reloadData()
        }
    }
}

extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let index = indexPath.row % services!.count
        showModal(index)
    }
    
    func showModal(index: Int) {
        
        let detailServiceViewController = DetailServiceViewController(service: services![index])
        detailServiceViewController.delegate = self
        self.navigationController?.pushViewController(detailServiceViewController, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.services?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ServiceCell
        Appearance.setupCellUI(cell)
        cell.service = services![indexPath.row % services!.count]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        // return CGSize(width: 170, height: 190)
        return CGSizeMake((UIScreen.mainScreen().bounds.width)/2.2, 190)
        
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        if totalRows == self.services?.count {
            return
        }
        
        if (indexPath.row == (self.services?.count)! - 2) {
            
            let servicesInList = (self.services?.count)! % Int(rowsPerPage)
            if (servicesInList == 0) {
                getDataFromApi(searchBar.text!, page: self.currentPage)
            }
        }
    }
}

extension ServicesViewController: DetailServiceProtocolDelegate {
    
    func goBackAfterDeleteService(service: Service) {
        
        // Search service in array of services.
        let deletedServicesID = service.id
        var index: Int = 0
        for service in services! {
            if service.id == deletedServicesID {
                services?.removeAtIndex(index)
                self.servicesCollectionView.reloadData()
                break
            }
            index += 1
        }
    }
}
