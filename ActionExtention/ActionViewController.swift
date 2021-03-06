//
//  ActionViewController.swift
//  ActionExtention
//
//  Created by Vasil Panov on 20.12.20.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {
    
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var resultIMage: UIImageView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var progressWidget: UIActivityIndicatorView!
    @IBOutlet weak var dissmissButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressWidget.startAnimating()
        processPickedFile()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func processPickedFile(){
        if(self.extensionContext!.inputItems.count > 0){
            let inputItem = self.extensionContext?.inputItems.first as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments!{
                let itemProvider = provider as! NSItemProvider
                if(itemProvider.hasItemConformingToTypeIdentifier(kUTTypePDF as String)){
                    itemProvider.loadItem(forTypeIdentifier: kUTTypePDF as String, options: nil, completionHandler: { (file, error) in
                        if(error == nil){
                            self.setPickedFile(file: file!)
                        }
                    })
                    break
                }
            }
        }
    }
    
    func setPickedFile(file: NSSecureCoding){
        if let fileURL = file as? URL{
            createRequest(fileUrl: fileURL)
        }
    }
    
    func createRequest(fileUrl : URL){
        
        let url = URL(string:"dummyURL.com")
        guard let requestUrl = url else { fatalError() }
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        let token = "dummyToken"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.setValue("Bearer \(token)", forHTTPHeaderField:"Authorization")        // Set HTTP Request Body
        
        //Create Data
        var body = Data()
        
        do{
            let data = try Data(contentsOf: fileUrl)
            body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(fileUrl.lastPathComponent)\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: application/pdf\r\n\r\n".data(using: .utf8)!)
            body.append(data)
            body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        } catch {
            
        }
        
        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: request, from: body, completionHandler: { responseData, response, error in
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async {
                        self.progressWidget.stopAnimating()
                        self.progressWidget.isHidden = true
                        self.resultIMage.isHidden = false
                        self.loadingLabel.textColor = UIColor.green
                        self.loadingLabel.text="Successful"
                        self.progressWidget.isHidden = true
                        self.dissmissButton.isHidden = false
                    }
                } else {
                    DispatchQueue.main.async {
                        self.progressWidget.stopAnimating()
                        self.progressWidget.isHidden = true
                        self.errorImageView.isHidden = false
                        self.loadingLabel.textColor = UIColor.red
                        self.loadingLabel.text="Failed"
                        self.progressWidget.isHidden = true
                        self.dissmissButton.isHidden = false
                    }
                }
            }
        }).resume()
    }
    
    @IBAction func dissmissButtonClicked(_ sender: Any) {
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }
}
