//
//  CellDetailsController.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 16.12.20.
//

import UIKit

class CellDetailsController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var idLoadForDriver: SingleLoads?
    var loadId : Int?
    var indexCellRow : Int!
    var cell : StopsTableViewCell!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var driverText: UILabel!
    @IBOutlet weak var customerLoadTxt: UILabel!
    @IBOutlet weak var brokerTxt: UILabel!
    @IBOutlet weak var temperatureTxt: UILabel!
    @IBOutlet weak var emptyMilesTxt: UILabel!
    @IBOutlet weak var truckTxt: UILabel!
    @IBOutlet weak var trailerTxt: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLoadById(loadId: loadId!){(idLoadForDriver,nil) in
            DispatchQueue.main.async {
                self.idLoadForDriver = idLoadForDriver
                self.title = String(self.loadId!)
                
                self.tableView.register(TopDetailsStopsCell.nib(), forCellReuseIdentifier: TopDetailsStopsCell.identifier)
                self.tableView.register(StopsTableViewCell.nib(), forCellReuseIdentifier: StopsTableViewCell.identifier)
                
                self.tableView.allowsSelection = false
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func fetchLoadById(loadId: Int,completionHandler completion: @escaping (SingleLoads, Error?) -> Void){
        // Prepare URL
        let url = URL(string: "dummyURL.com")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
//
//
        //HTTP Headers
        request.setValue("Bearer \(User.userToken)", forHTTPHeaderField:"Authorization")        // Set HTTP Request Body
        // Perform HTTP Request
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let idLoadForDriver = try? JSONDecoder().decode(SingleLoads.self, from: data!)
                    completion(idLoadForDriver!,nil)
                    
                }
            }
        }
        task.resume()
    }
    
    func getCurrentCellIndexPath(_ sender: UIButton) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        if let indexPath: IndexPath = tableView.indexPathForRow(at: buttonPosition) {
            return indexPath
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idLoadForDriver?.loadStops?.loadStop!.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let topCell = tableView.dequeueReusableCell(withIdentifier: TopDetailsStopsCell.identifier,for: indexPath) as? TopDetailsStopsCell
            
            topCell?.customerLoadTxt.text = idLoadForDriver?.customerLoad ?? ""
            topCell?.brokerTxt.text = idLoadForDriver?.customer?.companyName ?? ""
            topCell?.driverText.text = "\(idLoadForDriver?.driver?.firstName ?? "") \(idLoadForDriver?.driver?.lastName ?? "")"
            topCell?.driver2.text = "\(idLoadForDriver?.driver2?.firstName ?? "") \(idLoadForDriver?.driver2?.lastName ?? "")"
            topCell?.trailerTxt.text = idLoadForDriver?.trailer?.unitNumber ?? ""
            topCell?.truckTxt.text = idLoadForDriver?.truck?.unitNumber ?? ""
            topCell?.emptyMilesTxt.text = "\(String(idLoadForDriver?.emptyMiles ?? 0))/\(String(idLoadForDriver?.loadedMiles ?? 0))"
            topCell?.temperatureTxt.text = String(idLoadForDriver?.temperature ?? 0)
            
            return topCell!
        }
        
        cell = tableView.dequeueReusableCell(withIdentifier: StopsTableViewCell.identifier,for: indexPath) as? StopsTableViewCell
        cell.arriveButton.tag = indexPath.row
        cell.loadedButton.tag = indexPath.row
        cell.arriveButton.addTarget(self, action:#selector(didTapArriveButton), for: .touchUpInside)
        cell.loadedButton.addTarget(self, action:#selector(didTapLoadedButton), for: .touchUpInside)

        cell.stopTypeLabel.text = idLoadForDriver?.loadStops?.loadStop?[indexPath.row].stopType
        cell.cityLabel.text = idLoadForDriver?.loadStops?.loadStop?[indexPath.row].city
        cell.streetLabel.text = idLoadForDriver?.loadStops?.loadStop?[indexPath.row].street
        cell.stateLabel.text = idLoadForDriver?.loadStops?.loadStop?[indexPath.row].state
        cell.zipLabel.text = idLoadForDriver?.loadStops?.loadStop?[indexPath.row].zip
        
        
        if indexPath.row == 0{
            cell.loadedButton.setTitle("Loaded", for: .normal)
        }
        
        if idLoadForDriver?.loadStops?.loadStop?[indexPath.row].status == 1 {
            cell.arriveButton.setTitleColor(UIColor.white, for: .normal)
            cell.arriveButton.backgroundColor = UIColor.green
            cell.arriveButton.isEnabled = false
        } else if (idLoadForDriver?.loadStops?.loadStop?[indexPath.row].status == 2) {
            cell.arriveButton.isEnabled = false
            cell.loadedButton.isEnabled = false
            cell.arriveButton.setTitleColor(UIColor.white, for: .normal)
            cell.loadedButton.setTitleColor(UIColor.white, for: .normal)
            cell.arriveButton.backgroundColor = UIColor.green
            cell.loadedButton.backgroundColor = UIColor.green
        }
        
        return cell
    }
    
    @objc private func didTapArriveButton(sender: UIButton) {
        showAlerForPerormButtonAction(loadStatusInt:1,button: sender,rowId: sender.tag)

    }
    
    @objc private func didTapLoadedButton(sender: UIButton) {
        self.showAlerForPerormButtonAction(loadStatusInt: 2, button: sender, rowId: sender.tag)
    }

    func showAlerForPerormButtonAction(loadStatusInt : Int,button: UIButton,rowId : Int) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to perform this action?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in
                                        switch action.style{
                                        case .default:
                                            print("default")
                                            self.performUpdateLoadStatus(statusCode: loadStatusInt, rowId: rowId, button: button)
                                        case .cancel:
                                            print("cancel")
                                            
                                        case .destructive:
                                            print("destructive")
                                            
                                            
                                        @unknown default:
                                            fatalError()
                                        }}))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { action in
                                        switch action.style{
                                        case .default:
                                            print("default")
                                            
                                            
                                        case .cancel:
                                            print("cancel")
                                            
                                            
                                        case .destructive:
                                            print("destructive")
                                            
                                            
                                        @unknown default:
                                            fatalError()
                                        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    func performUpdateLoadStatus(statusCode : Int, rowId : Int, button : UIButton){
        // Prepare URL
        let url = URL(string: "dummyURL/\(String(self.loadId!))/stop/\(String((self.idLoadForDriver?.loadStops?.loadStop?[rowId].id)!))/status/\(String(statusCode))")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        //HTTP Headers
        request.setValue("Bearer \(User.userToken)", forHTTPHeaderField:"Authorization")        // Set HTTP Request Body
        // Perform HTTP Request
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    // handle response
                    DispatchQueue.main.async {
                        if(statusCode == 2){
                            let arriveButton = self.view.viewWithTag(button.tag) as? UIButton
                            arriveButton?.setTitleColor(UIColor.white, for: .normal)
                            arriveButton?.backgroundColor = UIColor.green
                            arriveButton?.isEnabled = false
                            
                            button.setTitleColor(UIColor.white, for: .normal)
                            button.backgroundColor = UIColor.green
                            button.isEnabled = false
                        }
                        button.setTitleColor(UIColor.white, for: .normal)
                        button.backgroundColor = UIColor.green
                        button.isEnabled = false
                    }
                } else {
                    //handle error
                }
            }
        }
        task.resume()
    }

}
