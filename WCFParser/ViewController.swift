//
//  ViewController.swift
//  WCFParser
//
//  Created by IOS Dev on 5/14/18.
//  Copyright © 2018 IOS Dev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // This goes on the Body of the POSTMAN
        let soapPayLoad = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\"><soapenv:Header><wsse:Security soapenv:mustUnderstand=\"1\" xmlns:wsse=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd\"><wsse:UsernameToken><wsse:Username>TestSitetraxau@ucg.com.au</wsse:Username><wsse:Password Type=\"http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText\">testsitetraxau1</wsse:Password></wsse:UsernameToken></wsse:Security></soapenv:Header><soapenv:Body><tem:HelloWorld><tem:name>It Works..! </tem:name></tem:HelloWorld></soapenv:Body></soapenv:Envelope>"
        
        // This goes on the Header of the POSTMAN (Key = SOAPAction) (Value = http://tempuri.org/IEnquiryProcess/HelloWorld)
        let soapAction = "http://tempuri.org/IEnquiryProcess/HelloWorld"
        
        postMethod(soapAction: soapAction, soapPayLoad: soapPayLoad)
        
        // In info.plist Add "App Transport Security Settings" - "Allow Arbitrary Loads" = YES
    }
    
    
    func postMethod(soapAction: String, soapPayLoad: String) {
        
        let url = URL(string: "https://onecallauuat.pelicancorp.com:8443/Mobile/OneCall.AU-B4-EN/EnquiryProcess.svc")
        var request = URLRequest(url: url!)
        
        request.httpMethod = "POST"
        request.httpBody = soapPayLoad.data(using: String.Encoding.utf8)
        request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.addValue(soapAction, forHTTPHeaderField: "SOAPAction")
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                
                print("Response: \(String(describing: response!))")
                
                let strData = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                
                print("Body: \(String(describing: strData!))")
                
                if err != nil
                {
                    print("Error: " + (err?.localizedDescription)!)
                }
            }
            }.resume()
        
        
    }


}

