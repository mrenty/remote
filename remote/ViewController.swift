//
//  ViewController.swift
//  remote
//
//  Created by Michiel Renty on 19/07/2017.
//  Copyright © 2017 Michiel Renty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad();
        button.backgroundColor = UIColor(red:0.33, green:0.42, blue:0.47, alpha:1.0);
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func sendRequest() {
        let request = NSMutableURLRequest(url: NSURL(string: "https://jsonplaceholder.typicode.com/posts")! as URL)
        let session = URLSession.shared
        request.httpMethod = "POST"
        
        let params = ["username":"username", "password":"password"] as Dictionary<String, String>
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {(data: Data?, response: URLResponse?,error: Error?) -> Void in
            if (error != nil) {
                let alert = UIAlertController(title: "Error", message: (error?.localizedDescription), preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                if let httpResponse = response as? HTTPURLResponse {
                    print(httpResponse);
                    print(httpResponse.statusCode);
                }
            }
        })
        
        task.resume()
    }

    @IBAction func buttonPressed(_ sender: Any) {
        self.sendRequest()
    }
}
