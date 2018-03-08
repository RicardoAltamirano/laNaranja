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


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        usuarioTextField.resignFirstResponder()
        contraTextField.becomeFirstResponder()
        return(true)
    }


}
