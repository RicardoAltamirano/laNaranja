//
//  LoginViewController.swift
//  LaNaranja
//
//  Created by Víctor Manuel Hernández Ramírez on 07/03/18.
//  Copyright © 2018 Ricardo Altamirano Cabrera. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contraTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usuarioTextField.delegate = self
        self.contraTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    @IBAction func Ingresar(_ sender: Any) {
        if usuarioTextField.text != "" && contraTextField.text != ""{
            if let url = URL(string: "http://socketpwr.com/lanaranja/api/login.php"){
                let request = NSMutableURLRequest(url:url)
                request.httpMethod = "POST";// Compose a query string
                let postString = "correo=\(self.usuarioTextField.text!)&pass=\(self.contraTextField.text!)"
                request.httpBody = postString.data(using: String.Encoding.utf8)
                let task = URLSession.shared.dataTask(with:request as URLRequest){
                    data, response, error in
                    
                    if error != nil{
                        print("1\(error!)")
                    }
                    else{
                        //let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                        //print("response string = \(responseString!)")
                    }
                    do {
                        
                        if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                            // Print out dictionary
                            //print(convertedJsonIntoDict)
                            
                            // Obtenemos el varlor por key de JSON
                            let usuario = (convertedJsonIntoDict[0] as! NSDictionary)["correo"] as? String
                            //let password = (convertedJsonIntoDict[0] as! NSDictionary)["password"] as? String
                            let estado = (convertedJsonIntoDict[0] as! NSDictionary)["estado"] as? Int64
                            //print("Valores: = \(usuario!),\(password!),\(estado!)")
                            let idUsuario = (convertedJsonIntoDict[0] as! NSDictionary)["idUsuario"] as? Int64
                            let nombre = (convertedJsonIntoDict[0] as! NSDictionary)["nombre"] as? String
                            
                            switch estado! {
                            case 0:
                                DispatchQueue.main.async {
                                    // Alert Controller Code Here
                                    let alertController = UIAlertController(title: "Error", message:
                                        "El usuario o contraseña son incorrectos", preferredStyle: UIAlertControllerStyle.alert)
                                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                                    self.present(alertController, animated: true, completion: nil)
                                }
                                break
                            case 1: //Sí se encontró
                                
                                DispatchQueue.main.async {
                                    
                                    //let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                                    let initialController = self.storyboard!.instantiateViewController(withIdentifier: "TabBar") as! TabBar
                                    
                                    //initialController.idFisio = usuario
                                    let alert = UIAlertController(title: "¡Bienvenido!", message: "Ahora puedes acceder a tu cuenta", preferredStyle: .alert)
                                    let action = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
                                        self.present(initialController, animated: true, completion: nil)
                                    }
                                    alert.addAction(action)
                                    
                                    self.present(alert, animated: true, completion: nil)
                                    //appDelegate.window?.rootViewController = initialController
                                    //appDelegate.window?.makeKeyAndVisible()
                                }
                                break
                            
                            default:
                                break
                            }
                        }
                        else{
                            print("error")
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
                }
                task.resume()
            }
        }else{
            let alertController = UIAlertController(title: "Campos incompletos", message:
                "Todos los campos son obligatorios", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usuarioTextField.resignFirstResponder()
        contraTextField.becomeFirstResponder()
        return(true)
    }


}
