//
//  ViewController.swift
//  BlindEats
//
//  Created by Matt Wyrick on 11/14/17.
//  Copyright © 2017 A290 Fall 2017 - matwyric. All rights reserved.
//

import UIKit
import paper_onboarding

class ViewController: UIViewController, PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    
    //Onboarding Framework View
    @IBOutlet weak var onboardingView: OnboardingView!
    
    // Main Page Items
    @IBOutlet weak var mainTitle: UILabel!
    
    @IBOutlet weak var restName: UILabel!
    @IBOutlet weak var restAddr: UILabel!
    @IBOutlet weak var restRating: UILabel!
    @IBOutlet weak var restCost: UILabel!
    
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var findFoodButton: UIButton!
    
    
    //Settings Page Items
    @IBOutlet weak var prefTitle: UILabel!
    
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var milesNumber: UILabel!
    @IBOutlet weak var milesSlider: UISlider!
    
    @IBOutlet weak var costSwitch1: UISwitch!
    @IBOutlet weak var costSwitch2: UISwitch!
    @IBOutlet weak var costSwitch3: UISwitch!
    @IBOutlet weak var costSwitch4: UISwitch!
    
    @IBOutlet weak var costLabel1: UILabel!
    @IBOutlet weak var costLabel2: UILabel!
    @IBOutlet weak var costLabel3: UILabel!
    @IBOutlet weak var costLabel4: UILabel!
    
    @IBOutlet weak var cuisineLabel: UILabel!
    
    @IBOutlet weak var anySwitch: UISwitch!
    @IBOutlet weak var americanSwitch: UISwitch!
    @IBOutlet weak var asianSwitch: UISwitch!
    @IBOutlet weak var italianSwitch: UISwitch!
    
    @IBOutlet weak var anyLabel: UILabel!
    @IBOutlet weak var americanLabel: UILabel!
    @IBOutlet weak var asianLabel: UILabel!
    @IBOutlet weak var italianLabel: UILabel!
    
    
    //Item Lists
    var mainItems : [UIView]? = nil
    var prefItems : [UIView]? = nil
    
    let food : FoodModel = FoodModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onboardingView.dataSource = self
        onboardingView.delegate = self
        
        mainItems = [mainTitle, restName, restAddr, restRating,
                     restCost, getDirectionsButton, findFoodButton]
        
        prefItems = [prefTitle, milesLabel, milesNumber, milesSlider,
                     costSwitch1, costSwitch2, costSwitch3, costSwitch4,
                     costLabel1, costLabel2, costLabel3, costLabel4,
                     cuisineLabel, anySwitch, americanSwitch, asianSwitch,
                     italianSwitch, anyLabel, americanLabel, asianLabel,
                     italianLabel]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Main Page Actions
    @IBAction func getDirections(_ sender: Any) {
        return //TODO Implement Directions
    }
    
    @IBAction func findFood(_ sender: Any) {
        let restaurant : Restaurant = food.get_restuarant()
        self.restName.text = restaurant.name
        self.restAddr.text = restaurant.address
        self.restRating.text = restaurant.rating
        self.restCost.text = restaurant.cost
    }
    
    
    //Pref Page Actions
    @IBAction func changeMiles(_ sender: Any) {
        food.update_radius(rad: Int(milesSlider.value))
        milesNumber.text = String(Int(milesSlider.value))
    }
    
    @IBAction func clickCost1(_ sender: Any) {
        food.update_costs(amount: "$", remove: !(costSwitch1.isOn))
    }
    
    @IBAction func clickCost2(_ sender: Any) {
        food.update_costs(amount: "$$", remove: !(costSwitch2.isOn))
    }
    
    @IBAction func clickCost3(_ sender: Any) {
        food.update_costs(amount: "$$$", remove: !(costSwitch3.isOn))
    }
    
    @IBAction func clickCost4(_ sender: Any) {
        food.update_costs(amount: "$$$$", remove: !(costSwitch4.isOn))
    }
    
    @IBAction func clickAny(_ sender: Any) {
        food.update_cuisine(food: "Any", remove: !(anySwitch.isOn))
    }
    @IBAction func clickAmerican(_ sender: Any) {
        food.update_cuisine(food: "American", remove: !(americanSwitch.isOn))
    }
    @IBAction func clickAsian(_ sender: Any) {
        food.update_cuisine(food: "Asian", remove: !(asianSwitch.isOn))
    }
    @IBAction func clickItalian(_ sender: Any) {
        food.update_cuisine(food: "Italian", remove: !(italianSwitch.isOn))
    }
    
    
    // 3rd Party Tab View Framework Code Below
    func onboardingItemsCount() -> Int {
        return 2
    }
    
    func onboardingItemAtIndex(_ index: Int) -> OnboardingItemInfo {
        let backgroundPref = UIColor(red: 230/255, green: 72/255, blue: 72/255, alpha: 1)
        let backgroundMain = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        let font = UIFont(name: "Noteworthy", size: 24)!
        
        let mainView = ("", "", "", "", backgroundMain, UIColor.white, UIColor.blue, font, font)
        let prefView = ("", "", "", "", backgroundPref, UIColor.white, UIColor.blue, font, font)
        
        return [prefView, mainView][index]
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        var mainVisibility : CGFloat = 0
        var prefVisibility: CGFloat = 0
        
        if index == 0 {
            mainVisibility = 1
        }
        
        if index == 1 {
            prefVisibility = 1
        }
        
        for item in self.mainItems! {
            UIView.animate(withDuration: 0.3, animations: {
                item.alpha = mainVisibility
            })
        }
        
        for item in self.prefItems! {
            UIView.animate(withDuration: 0.3, animations: {
                item.alpha = prefVisibility
            })
        }
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        
    }
    
    



}

