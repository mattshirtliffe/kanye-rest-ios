//
//  ViewController.swift
//  Kanye Rest
//
//  Created by Matthew Shirtliffe on 08/05/2019.
//  Copyright © 2019 Space Labs Digital. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController {
    
    let URL = "https://api.kanye.rest";

    @IBOutlet var button: UIButton!
    @IBOutlet var label: UILabel!
    
    var quote: Quote = Quote()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getQuote()
    }
    
    func getQuote(){
        SVProgressHUD.show()
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON{
            response in
            if response.result.isSuccess {
                
                let statusCode: Int = (response.response?.statusCode ?? 400)
                if statusCode == 200 {
                    SVProgressHUD.dismiss()
                    let responseJSON: JSON = JSON(response.result.value!)
                    self.quote.quote = responseJSON["quote"].stringValue
                    self.updateUI()
                }else{
                    SVProgressHUD.dismiss()
                    let errorJSON: JSON = JSON(response.result.value!)
                    
                }
                
            }else{
                SVProgressHUD.dismiss()
                let failure = response.result.error!
            }
        }
    }
    
    func updateUI() {
        label.text = quote.quote
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        getQuote()
    }
    
}

