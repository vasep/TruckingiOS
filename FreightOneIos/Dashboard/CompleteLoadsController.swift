//
//  CompleteLoadsController.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 15.12.20.
//

import UIKit

class CompleteLoadsController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var loadsForDriver: LoadsForDriver?
    var genericModel: [GenericModel]?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        fetchCompletedLoads(){(loadsForDriver,nil) in
            DispatchQueue.main.async {
                self.loadsForDriver = loadsForDriver
                self.genericModel = self.loadsForDriver?.genericModel
                self.tableView.delegate = self
                self.tableView.dataSource = self
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchCompletedLoads(completionHandler completion: @escaping (LoadsForDriver, Error?) -> Void){
        // Prepare URL
        let url = URL(string:"https://www.onecloudtms.com/mobile/drivers/loads/paginated?pageNumber=0&pageSize=20&status=Completed")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
//        let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzb2ZlciIsInJvbGVzIjoiUk9MRV9EUklWRVIiLCJpYXQiOjE2MDgwOTc1MTV9.eo3tjsfZcDOzkqRpBlMQ_7wI3nG1lsVI-bc_xLTqTV8"
        
//        print("tokenId >> \(User.userToken)")
        
        //HTTP Headers
        request.setValue("Bearer \(User.userToken)", forHTTPHeaderField:"Authorization")        // Set HTTP Request Body
        // Perform HTTP Request
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                        let loadsForDriver = try? JSONDecoder().decode(LoadsForDriver.self, from: data!)
                        completion(loadsForDriver!,nil)

                } else {
                    //handle error
                }
                
            }
        }
        task.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "completeCellDetailsSegue" {
            let cellDetailsVC = segue.destination as! CellDetailsController
            cellDetailsVC.loadId = self.genericModel![self.tableView.indexPathForSelectedRow!.row].id
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "completeCellDetailsSegue", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadsForDriver!.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loadCell", for: indexPath)
        let str:String = String(describing: self.genericModel![indexPath.row].id)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = str
        return cell
    }
}

