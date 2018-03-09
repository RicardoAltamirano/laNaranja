//
//  FirstViewController.swift
//  LaNaranja
//
//  Created by Ricardo Altamirano Cabrera on 16/02/18.
//  Copyright © 2018 Ricardo Altamirano Cabrera. All rights reserved.
//

import UIKit
import CoreData
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func consultar(){
        _ = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Usuario")
        
        do{
            let results = try getContext().fetch(fetchRequest)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    print(result.value(forKey: "nombre")!)
                    print(result.value(forKey: "correo")!)
                    print(result.value(forKey: "idUsuario")!)
                }
            }
        }catch{
            print("Error en cosulta")
        }
    }
    
    func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }


}

