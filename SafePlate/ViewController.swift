//
//  ViewController.swift
//  SafePlate
//
//  Created by Hannah Cole on 5/19/18.
//  Copyright © 2018 Hannah Cole. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DietaryTextField: UITextField!
    
    @IBOutlet weak var LocationTextField: UITextField!
    
    @IBAction func GoButtonPressed(_ sender: Any) {
        //let url = URL(string: "https://developers.zomato.com/api/v2.1/cities?q=\(LocationTextField.text!)&count=1")!
        let url = URL(string: "https://developers.zomato.com/api/v2.1/search?&lat=42.358028&lon=-71.060417")!
        let config = URLSessionConfiguration.default
        
        config.httpAdditionalHeaders = [
            "Accept": "application/json",
            "user_key": "5a09d3163cae30a2535e6a940c956fee"
        ]
        
        let urlSession = URLSession(configuration: config)
        
        DispatchQueue.main.async {
            // add UI related changes here
            let myQuery = urlSession.dataTask(with: url, completionHandler: {
                data, response, error -> Void in
                if error == nil {
                    let httpResponse = response as! HTTPURLResponse!
                    
                    if httpResponse!.statusCode == 200 {
                        do {
                            if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                if let restaurants = json["restaurants"] as? [NSDictionary] {
                                    for rest in restaurants {
                                        var searchResult = [String:AnyObject?]()
                                        let restaurant = rest["restaurant"] as! NSDictionary
                                        print(restaurant["id"] as? NSString)
                                        print(restaurant["average_cost_for_two"] as? NSNumber)
                                        print(restaurant["cuisines"] as? String)
                                        print(restaurant["url"] as? String)
                                        print(restaurant["thumb"] as? String)
                                        if let location = restaurant["location"] as? NSDictionary {
                                            print(location["address"] as? String)
                                            print(location["city"] as? String)
                                        }
                                        print(restaurant["menu_url"] as? String)
                                        print(restaurant["name"] as? String )
                                        print(restaurant["phone_numbers"] as? String)
                                        if let user_rating = restaurant["user_rating"] as? NSDictionary {
                                            print(user_rating["aggregate_rating"] as? NSString)
                                            print(user_rating["rating_color"] as? String)
                                        }
                                    }
                                }
                            }
                            
                        } catch {
                            print(error)
                        }
                    }
                }
            })
            myQuery.resume()
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
    
    func findCityID() {
        
    }


}

