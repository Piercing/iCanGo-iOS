
import UIKit
import RxSwift

class ServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var loginInProgress: Bool!
    
    var isLoaded = false
    let cellId = "serviceCell"
    let nibId = "ServiceCellView"
    let titleView = "All Services"
    
    private var services: [Service]?
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "ServicesView", bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCell()

        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        
        self.loginInProgress = false
        self.services = [Service]()
        
        setupUIAllServices()
        // do api call
        loadDataFromApi("")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    // MARK: Methods
    
    func setupUIAllServices() -> Void {
    
        searchBar.resignFirstResponder()
        let title = Appearance.setupUI(self.view, title: self.titleView)
        self.title = title
        Appearance.tabBarColor(self.tabBarController!)
        Appearance.customizeAppearance(self.view)
        servicesCollectionView.fadeOut(duration: 0.0)

    }
    
    // MARK: Cell registration
    
    func registerCustomCell() {
        servicesCollectionView.registerNib(UINib(nibName: nibId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: Data validation
    
    func validateData() -> Void {
        
    }
    
    // MARK: Api call
    
    func loadDataFromApi(stringToFind: String) -> Void {
        
        loginInProgress = actionStarted(activityIndicatorView)
        let session = Session.iCanGoSession()
        // TODO: Parameter Rows pendin
        let _ = session.getServices(1, rows: rowsPerPage)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                
                self?.loginInProgress = actionFinished(self!.activityIndicatorView)
                switch event {
                case let .Next(services):
                    self?.services = services
                    self?.servicesCollectionView.reloadData()
                    self?.servicesCollectionView.fadeIn(duration: 0.3)
                    break
                case .Error (let error):
                    //self!.loginNoSuccess(error as? SessionError)
                    print(error)
                default:
                    break
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
        loadDataFromApi(searchBar.text!)
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        servicesCollectionView.fadeOut(duration: 0.3)
        return true
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        servicesCollectionView.fadeIn(duration: 0.3)
        searchBar.showsCancelButton = false
        if (searchBar.text == "") {
            //loadDataFromApi("")
        }
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        deActivateSearchBar()
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
}

extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let index = indexPath.row % services!.count
        showModal(index)
    }
    
    func showModal(index: Int) {
        
        let detailServiceViewController = DetailServiceViewController()
        
        self.navigationController?.pushViewController(detailServiceViewController, animated: true)
        //self.presentViewController(detailServiceViewController, animated: true, completion: nil)
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.services?.count)!
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellId, forIndexPath: indexPath) as! ServiceCell
        
        
        let index = indexPath.row % services!.count
        let service = services![index]
        //cell.serviceImage?.image = UIImage(named: service.mainImage!)
        cell.commentLabel?.text = service.name
        
        // load the image asynchronous
        if service.mainImage != nil {
            loadImage(service.mainImage!, imageView: cell.imageService)
        }
        
        if service.ownerImage != nil {
            loadImage(service.ownerImage!, imageView: cell.imageUser)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 170, height: 190)
    }
}




















