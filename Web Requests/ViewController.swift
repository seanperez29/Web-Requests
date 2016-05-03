//
//  ViewController.swift
//  Web Requests
//
//  Created by Sean Perez on 5/2/16.
//  Copyright © 2016 Awsome. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "http://swapi.co/api/people/1/"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlStr)!
        
        session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            if let data = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    
                    if let dict = json as? Dictionary<String, AnyObject> {
                        
                        if let name = dict["name"] as? String, let height = dict["height"] as? String, let birth = dict["birth_year"] as? String, let hair = dict["hair_color"] as? String {
                            
                            let person = SWPerson(name: name, height: height, birthYear: birth, hairColor: hair)
                            
                            print(person.name)
                            print(person.height)
                            print(person.hairColor)
                            print(person.birthYear)
                            
                            if let films = dict["films"] as? [String] {
                                for film in films {
                                    print(film)
                                }
                            }
                            
                        }
                    }
                    
                } catch {
                    print("Could no serialize")
                }
            }
        }.resume()
    }
}
