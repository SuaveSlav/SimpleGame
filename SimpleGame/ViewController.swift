//
//  ViewController.swift
//  SimpleGame
//
//  Created by 90305539 on 9/21/18.
//  Copyright © 2018 Emir Sahbegovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ShopButton: UIButton!
    @IBOutlet weak var levelText: UILabel!
    var level = 1
    var rank = 0
    @IBOutlet weak var healthBar: UIProgressView!
    var percentHealth = 100
    @IBOutlet weak var mobClick: UIButton!
    @IBOutlet weak var goldValue: UILabel!
    var gold = 0
    @IBOutlet weak var slayValue: UILabel!
    var slay = 0
    var mobMaxHealth = 100.0
    var mobHealth = 100.0
    var damage = 10.0
    let enemyList = ["Plague Rat","Rabid Rabbit","Crazed Gecko","King Crab","Upset Alien"]
    
    
    @IBAction func mobClickNormal(_ sender: Any) { //Upon tapping the enemy
        mobHealth -= damage
        mobHealthUpdate()
    }
    
    func mobHealthUpdate() {
        if (mobHealth <= 0){                      //mob dies
            updateStats()// update stats & displays
            createNewMob()  // make new enemy
        } else {
            healthBar.progress = Float((mobHealth / mobMaxHealth))
        }
    }
    
    func createNewMob() {   //activates on Death
        var modifier = ""
        if (level <= 10){
            modifier = "Minor"
        } else if (level <= 20) {
            modifier = ""
        }  else if (level <= 30) {
            modifier = "Lesser"
        } else if (level <= 40) {
            modifier = "Greater"
        } else if (level <= 60) {
            modifier = "Large"
        } else if (level <= 70) {
            modifier = "Gargantuan"
        } else if (level <= 80) {
            modifier = "Legendary"
        } else if (level <= 90) {
            modifier = "Destroyer"
        } else {
            modifier = "Godly"
        }
        
        levelText.text = "Level " + String(level) + " " + String(modifier) + " " + enemyList[rank] //Sets Level text
        mobClick.setImage(UIImage(named: enemyList[rank]), for: .normal) //sets button image to appropriate image based on level
        mobMaxHealth += Double((level * 10))
        mobHealth = mobMaxHealth
        healthBar.progress = Float((mobHealth / mobMaxHealth))
    }
    
    //// updates Stats upon mob death
    func updateStats(){
        
        //update
        let random = (arc4random_uniform(5)+1)
        gold += (level * Int(random))
        slay += 1
        level += 1
        
        if(rank != 4) { //sets level to appropriate number
            rank+=1
        } else {
            rank = 0
        }
        
        //display
        ShopButton.setTitle("Buy 10 Damage for " + String(level) + " Gold", for: .normal)
        goldValue.text = String(gold)
        slayValue.text = String(slay)
    }
    
    @IBAction func shopTap(_ sender: Any) {
        let cost = level
        if (gold >= cost) {
            gold -= cost
            goldValue.text = String(gold)
            damage += 10
        } else {
            print("no")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
