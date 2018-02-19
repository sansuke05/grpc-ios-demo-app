//
//  ViewController.swift
//  GrpcMobileDemo
//
//  Created by LiCTiA user on 2018/02/19.
//  Copyright © 2018年 sansuke05. All rights reserved.
//

import Foundation
import UIKit
import RemoteClient


class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    let host = "localhost:50051"
    
    @IBAction func sendMessage() {
        if let msg = textField.text {
            GRPCCall.useInsecureConnections(forHost: host)
            
            // Call RPC
            let request = HLWHelloRequest()
            request.name = msg
            
            let client = HLWGreeter(host: host)
            client.sayHello(with: request, handler: { responce, error in
                // response is HLWHelloReply
                if let responce = responce {
                    self.textView.text = "Responce: \(responce.message!)"
                } else {
                    self.textView.text = "Error: \(error!)"
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

