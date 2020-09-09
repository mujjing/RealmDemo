//
//  HeroViewController.swift
//  RealmAndJson
//
//  Created by Jh's Macbook Pro on 2020/09/09.
//  Copyright © 2020 전지훈. All rights reserved.
//

import UIKit
import RealmSwift

class HeroViewController: UIViewController {
    
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    
    var param1 : String?
    var param2 : String?
    var param3 : String?
    var param4 : String?
    
    var heroData : HeroDB?
    
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.lbl1.text = param1
        self.lbl2.text = param2
        self.lbl3.text = param3
        self.lbl4.text = param4
        addHeroData()
    }
    func addHeroData(){
        heroData = HeroDB()
        heroData = inputDataToHeroData(db: heroData!)
        try? realm.write{
            realm.add(heroData!)
        }
    }
    func inputDataToHeroData(db : HeroDB) -> HeroDB{
        if let id = param1{
            db.id = Int(id)!
        }
        if let name = param2{
            db.localized_name = name
        }
        if let attack = param3{
            db.attack_type = attack
        }

        return db
    }
}
