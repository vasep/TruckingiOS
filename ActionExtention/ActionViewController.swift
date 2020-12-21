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
                if(itemProvider.hasItemConformingToTypeIdentifier(kUTTypePDF as String) || itemProvider.hasItemConformingToTypeIdentifier(kUTTypePlainText as String) || itemProvider.hasItemConformingToTypeIdentifier("com.microsoft.word.doc")){
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
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "FreightOne-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    func setPickedFile(file: NSSecureCoding){
        if let fileURL = file as? URL{
            createRequest(fileUrl: fileURL)
        }
    }
    
    func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
        var status = false
        if #available(iOS 10.0, *) {
            do {
                let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
                for url in contents {
                    if url.description.contains("FreightOne-\(fileName).pdf") {
                        status = true
                    }
                }
            } catch {
                print("could not locate pdf file !!!!!!!")
            }
        }
        return status
    }
    
    func createRequest(fileUrl : URL){
        
        let url = URL(string:"http://truckingnew-env.eba-q2gns4ca.us-east-1.elasticbeanstalk.com/api/v1/trucking/file/upload/pdf/0")
        guard let requestUrl = url else { fatalError() }
        
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        
        let session = URLSession.shared
        
        // Prepare URL Request Object
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        let token = "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJzb2ZlciIsInJvbGVzIjoiUk9MRV9EUklWRVIiLCJpYXQiOjE2MDgwOTc1MTV9.eo3tjsfZcDOzkqRpBlMQ_7wI3nG1lsVI-bc_xLTqTV8"
        
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
