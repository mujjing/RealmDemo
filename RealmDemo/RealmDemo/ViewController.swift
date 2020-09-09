//
//  ViewController.swift
//  RealmDemo
//
//  Created by Jh's Macbook Pro on 2020/09/02.
//  Copyright © 2020 전지훈. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    let realm = try! Realm()
    var names : Results<Example>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //data 추가
    @IBAction func addBtn(_ sender: UIButton) {
        let newName = Example()
        newName.name = textField.text!
        
        do{
            try realm.write{
                realm.add(newName)
            }
        }catch{
            print("saving error : \(error)")
        }
        tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = names?[indexPath.row].name ?? "no names added yet"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //data 업데이트
        let alert = UIAlertController(title: "update String", message: "", preferredStyle: .alert)
        var updateTextField = UITextField()
        alert.addTextField { (alertTF) in
            alertTF.placeholder = "Update names"
            updateTextField = alertTF
        }
        let alertA = UIAlertAction(title: "update name", style: .default) { (action) in
            if let name = self.names?[indexPath.row]{
            do{
                try self.realm.write{
                    name.name = updateTextField.text!
                    self.loadItems()
                }
            }catch{
                print("update error : \(error)")
            }
        }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (deleteAction) in
            if let name = self.names?[indexPath.row]{
                do{
                    try self.realm.write{
                        self.realm.delete(name)
                        self.loadItems()
                    }
                }catch{
                    print("delete error : \(error)")
                }
            }
        }
        alert.addAction(alertA)
        alert.addAction(cancel)
        alert.addAction(delete)
        present(alert, animated: true)
        tableView.reloadData()
    }
    func loadItems(){
        names = realm.objects(Example.self)
        tableView.reloadData()
    }
    
}
