//
//  FoodModel.swift
//  BlindEats
//
//  Created by Matt Wyrick on 11/14/17.
//  Copyright © 2017 A290 Fall 2017 - matwyric. All rights reserved.
//

import Foundation
//TODO import coreLocationg and Mapkit when using real data

class Restaurant {
    
    let name: String
    let type: String
    let address: String
    let cost: String
    let rating: String
    let location: [Double]
    
    
    init(name: String, address: String, cost: String,
         type: String, rating: String, location: [Double]) {
        self.name = name
        self.address = address
        self.type = type
        self.cost = cost
        self.rating = rating
        self.location = location
    }
    
}


class FoodModel {
    
    var radius: Int
    var cuisines: [String]
    var costs: [String]
    var rest_list: [Restaurant]
    var api_key: String
    let data_url: String
    var location: [Double]
    var iu_location: [Double]
    var make_query = true
    var old_query : [Restaurant] = []
    
    
    init() {
        self.radius = 25
        self.cuisines = ["Any"]
        self.costs = ["$", "$$", "$$$", "$$$$"]
        self.rest_list = []
        self.api_key = "4dccaf2b364e6e818e4915d5c884cb78"
        self.data_url = "https://developers.zomato.com/api/v2.1/geocode?"
        self.location = [0.0, 0.0]
        self.iu_location = [39.1761, -86.5131]
    }
    
    // update user costs preferences
    func update_costs(amount: String, remove: Bool) {
        if remove {
            if let i = self.costs.index(of: amount) {
                self.costs.remove(at: i)
            }
        }
        else {
            if !(self.costs.contains(amount)) {
                self.costs.append(amount)
            }
        }
    }
    
    // udate user radius preference
    func update_radius(rad: Int) {
        self.radius = rad
    }
    
    // update user food preferences
    func update_cuisine(food: String, remove: Bool) {
        if remove {
            if let i = self.cuisines.index(of: food) {
                self.cuisines.remove(at: i)
            }
        }
        else {
            if !(self.cuisines.contains(food)) {
                self.cuisines.append(food)
            }
        }
    }
    
    //TODO pull user location when using real data
    func update_location() {
        self.location = [80.0, 80.0]
    }
    
    //TODO save user preferences
    func save_preferences() {
        // save user preferences
    }
    
    
    // get a general list of restaurants from an API
    func find_restaurants(){
        if self.make_query {
            self.update_location()
            let results: [Restaurant] = self.query_api()
            self.rest_list = self.filter_data(input: results)
            self.make_query = false
        }
    }
    
    func query_api() -> [Restaurant] {
        // make_request with self.api_key and self.data_url
        let query = self.data_url + "apikey=\(self.api_key)&lat=\(self.iu_location[0])&lon=\(self.iu_location[1])"
        let request = URLRequest(url: NSURL(string: query)! as URL)
        do {
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
            let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
            if let json = jsonSerialized {
                var results : [Restaurant] = []
                for iter in json["nearby_restaurants"] as! [[String:AnyObject]] {
                    var item = iter["restaurant"] as! [String : AnyObject]
                    let name = item["name"] as! String
                    let address = item["location"]?["address"] as! String
                    var cost = "$"
                    if item["price_range"] as! Int == 2 {
                        cost = "$$"
                    }
                    if item["price_range"] as! Int == 3 {
                        cost = "$$$"
                    }
                    if item["price_range"] as! Int == 4 {
                        cost = "$$$$"
                    }
                    let type = item["cuisines"] as! String
                    let rating = item["user_rating"]?["aggregate_rating"] as! String
                    let location = [ Double(item["location"]?["latitude"] as! String), Double(item["location"]?["longitude"] as! String)] as! [Double]
                    
                    let restaurant = Restaurant(name: name, address: address, cost: cost, type: type, rating: rating, location: location)
                    results.append(restaurant)
                }
                return results
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }

        return []
    }
    
    
    //TODO remove first line when real data used
    func filter_data(input: [Restaurant]) -> [Restaurant] {
        
        self.rest_list =  [
            Restaurant(name: "McDonalds", address: "412 Street, Bloomington, IN", cost: "$", type: "American", rating: "2.5/5.0", location: [80.0, 80.0]),
            Restaurant(name: "Chili's", address: "123 Main St, Bloomington, IN", cost: "$$", type: "American", rating: "3.0/5.0", location: [100.0, 100.0]),
            Restaurant(name: "Olive Garden", address: "890 Main St, Bloomington, IN", cost: "$$$", type: "Italian", rating: "4.0/5.0", location: [90.0, 90.0]),
        ]
        
        var filtered_list: [Restaurant] = []
        
        for restaurant in self.rest_list {
            let type_check = (self.cuisines.contains(restaurant.type) || self.cuisines.contains("Any"))
            let cost_check = self.costs.contains(restaurant.cost)
            let dist_check = preferred_distance(rest: restaurant)
            if (type_check && cost_check && dist_check) {
                filtered_list.append(restaurant)
            }
        }
        return input
        return filtered_list
    }
    
    //TODO update when real data used
    func preferred_distance(rest: Restaurant) -> Bool {
        let x = (self.location[0] - rest.location[0])
        let x2 = Double(pow(Double(x),Double(2)))
        let y = (self.location[1] - rest.location[1])
        let y2 = Double(pow(Double(y),Double(2)))
        let dist = Double(pow((x2+y2), 0.5))
        let val = (dist<=Double(self.radius))
        return val
    }
    
    // Returns Random Restaurant
    func get_restuarant() -> Restaurant {
        self.find_restaurants()
        if self.rest_list.count < 1 {
            return Restaurant(name: "No Restaurants Found", address: "", cost: "$", type: "Any", rating: "0.0/5.0", location: self.location)
        }
        return self.rest_list[Int(arc4random_uniform(UInt32(self.rest_list.count)))]
    }
    
}
