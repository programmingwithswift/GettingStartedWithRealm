//
//  ViewController.swift
//  GettingStartedWithRealm
//
//  Created by ProgrammingWithSwift on 2020/04/02.
//  Copyright © 2020 ProgrammingWithSwift. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.write()
        self.read()
        self.update()
        self.read()
        self.delete()
    }
    
    private func write() {
        let table = Furniture.create(withName: "table")
        let chair = Furniture.create(withName: "chair")
        let store = Store.create(withName: "Test Store",
                                 furniture: [table, chair])
        
        // Write to Realm
        print("Write to Realm")
        try! realm.write {
            realm.add(table)
            realm.add(chair)
            realm.add(store)
        }
    }
    
    private func read() {
        // Read from Realm
        print("Read from Realm")
        let data = realm.objects(Store.self)
        print(data)
    }
    
    private func update() {
        // Update data
        if let table = realm.objects(Furniture.self).first {
            try! realm.write {
                table.name = "New Table Name"
            }

            print(realm.objects(Furniture.self).first)
        }
    }
    
    private func delete() {
        // Delete data
        print("Delete Data")
        if let tableToDelete = realm.objects(Furniture.self).first {
            try! realm.write {
                realm.delete(tableToDelete)
            }

            print(realm.objects(Furniture.self).first)
            print(realm.objects(Store.self).first)
        }
    }
}

class Furniture: Object {
    @objc dynamic var name = ""
    
    static func create(withName name: String) -> Furniture {
        let furniture = Furniture()
        furniture.name = name
        
        return furniture
    }
}

class Store: Object {
    @objc dynamic var name = ""
    var furniture = List<Furniture>()
    
    static func create(withName name: String,
                       furniture: [Furniture]) -> Store {
        let store = Store()
        store.name = name
        store.furniture.append(objectsIn: furniture)
        
        return store
    }
}
