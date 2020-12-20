//
//  LoginController.swift
//  FreightOneIos
//
//  Created by Vasil Panov on 14.12.20.
//

import UIKit

class LoginController: UIViewController {
    
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        // Do any additional setup after loading the view.
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func loginPressed(_ sender: Any) {
        checkAndDisplayError()
    }
    
    func checkAndDisplayError(){
        //        if(userName.text?.count ?? 0 > 1){
        //            errorLabel.text = "Please enter username"
        //            userName.layer.borderColor = UIColor.red.cgColor
        //        } else if (userName.text?.count ?? 0 > 1){
        //            errorLabel.text = "Please enter password"
        //        } else {
        //        }
        
        performLogin(passwordString: password.text!,usernameString: userName.text!)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func performLogin(passwordString: String, usernameString: String){
        
        
        let json: [String: Any] = ["username": usernameString,
                                   "password":passwordString]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        // Prepare URL
        let url = URL(string: "http://truckingnew-env.eba-q2gns4ca.us-east-1.elasticbeanstalk.com/token/generate-token")
        guard let requestUrl = url else { fatalError() }
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        // HTTP Request Parameters which will be sent in HTTP Request Body
        request.httpBody = jsonData
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        // Set HTTP Request Body
        // Perform HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("Loging server response  \(httpResponse.statusCode)")
                
                if httpResponse.statusCode == 500 {
                    DispatchQueue.main.async {
                        // set error label
                    }
                }
                
                if httpResponse.statusCode == 200 {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                    if let responseJ = responseJSON as? [String: Any] {
                        
                        DispatchQueue.main.async {
                            User.userToken = (responseJ["token"] as! String?)!
                            UserDefaults.standard.set(User.userToken, forKey: "userToken")
                            self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "login_segue", sender: nil)
                            
                        }
                        
                    }
                }
            }
        }
        task.resume()
    }
}
