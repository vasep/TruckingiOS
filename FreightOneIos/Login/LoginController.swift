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
    
    override func viewDidAppear(_ animated: Bool) {
        User.userToken = UserDefaults.standard.string(forKey:"userToken") ?? ""
        //
        if(!(User.userToken.isEmpty)){
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "login_segue", sender: nil)
        }
    }
    
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
    
    func animateErrorLabel(txtMessage: String){
        UIView.transition(with: self.errorLabel,
                      duration: 0.25,
                       options: .transitionCrossDissolve,
                    animations: { [weak self] in
                        self?.self.errorLabel.text = txtMessage
                 }, completion: nil)
    }
    
    func outlineErrorTxtField(field: UITextField){
        field.layer.borderWidth = 1.0
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.red.cgColor
    }
    
    func checkAndDisplayError(){
        if(userName.text?.isEmpty ?? true ){
            outlineErrorTxtField(field: userName)
            animateErrorLabel(txtMessage: "Please enter username")
        } else if (password.text?.isEmpty ?? true ){
            userName.layer.borderWidth = 0
            outlineErrorTxtField(field: password)
            animateErrorLabel(txtMessage:"Please enter password")
            
        } else {
            userName.layer.borderWidth = 0
            password.layer.borderWidth = 0

            performLogin(passwordString: password.text!,usernameString: userName.text!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    func performLogin(passwordString: String, usernameString: String){
        
        
        let json: [String: Any] = ["username": usernameString,
                                   "password":passwordString]
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        // Prepare URL
        let url = URL(string: "dummyURL.com")
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
                        self.outlineErrorTxtField(field: self.userName)
                        self.outlineErrorTxtField(field: self.password)
                        self.animateErrorLabel(txtMessage: "Wrong password or email")
                    }
                }
                
                if httpResponse.statusCode == 200 {
                    let responseJSON = try? JSONSerialization.jsonObject(with: data!, options: [])
                    if let responseJ = responseJSON as? [String: Any] {
                        
                        DispatchQueue.main.async {
                            self.errorLabel.isHidden = true
                            self.userName.layer.borderWidth = 0
                            self.password.layer.borderWidth = 0
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
