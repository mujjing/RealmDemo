//
//  ViewController.swift
//  RealmAndJson
//
//  Created by Jh's Macbook Pro on 2020/09/09.
//  Copyright © 2020 전지훈. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var heros = [HeroStats]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://api.opendota.com/api/heroStats")
               URLSession.shared.dataTask(with: url!){ (data, response, error) in
                   
                   if error == nil{
                       do{
                       self.heros = try JSONDecoder().decode([HeroStats].self, from: data!)
                       }catch{
                           print("error")
                       }
                       DispatchQueue.main.sync {
                           print(self.heros.count)
                           self.tableView.reloadData()
                       }
                   }
                   
               }.resume()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(heros[indexPath.row].id ?? 0)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HeroViewController") as! HeroViewController
        vc.param1 = "\(heros[indexPath.row].id ?? 0)"
        vc.param2 = "\(heros[indexPath.row].localized_name ?? "")"
        vc.param3 = "\(heros[indexPath.row].base_health ?? 0)"
        vc.param4 = "\(heros[indexPath.row].attack_type ?? "")"
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
