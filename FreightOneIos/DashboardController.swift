//
//  DashboardController.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 14.12.20.
//

import UIKit

class DashboardController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogOutClicked(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Are you sure you want to Log Out?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Log Out", style: .default, handler: { action in
                                        switch action.style{
                                        case .default:
                                            print("default")
                                            UserDefaults.standard.removeObject(forKey: "userToken")
                                            self.performSegue(withIdentifier: "logout_segue", sender: nil)
                                          
                                        case .cancel:
                                            print("cancel")
                                            
                                        case .destructive:
                                            print("destructive")
                                            
                                            
                                        @unknown default:
                                            fatalError()
                                        }}))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
