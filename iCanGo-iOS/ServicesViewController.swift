//
//  ServicesViewController.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 4/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit
import RxSwift

class ServicesViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var favouritesBtn: UIButton!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    
    private var isLoaded = false
    private let cellId = "serviceCell"
    
    private var services: [Service]?
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: "ServicesView", bundle: nil)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCustomCell()
        
        self.services = [Service]()
        
        // do api call
        loadServices()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    @IBAction func btnFilter(sender: AnyObject) {
        // TODO: Filter services
        print("Prees button Filter")
    }
    
    @IBAction func btnFavourites(sender: AnyObject) {
        // TODO: check favourites
        print("Prees button Favourites")
    }
    
    // MARK: Methods
    
    func setupUI() -> Void {
        
        servicesCollectionView.delegate = self
        servicesCollectionView.dataSource = self
        searchBar.resignFirstResponder()
        
        self.title = "All Services"
        Appearance.tabBarColor(self.tabBarController!)
        Appearance.customizeAppearance(self.view)
    }
    
    // MARK: Cell registration
    
    func registerCustomCell() {
        servicesCollectionView.registerNib(UINib(nibName: "ServiceCellView", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    // MARK: Data validation
    
    func validateData() -> Void {
        
    }
    
    // MARK: Api call
    
    func loadServices() -> Void {
        //loginInProgressRequest()
        
        let session = Session.iCanGoSession()
        // TODO: Parameter Rows pendin
        let _ = session.getServices(1, rows: rowsPerPage)
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                switch event {
                case let .Next(services):
                    self!.services = services
                    self?.servicesCollectionView.reloadData()
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
}

extension ServicesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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




















