//
//  ViewController.swift
//  Online-Medical-App
//
//  Created by Srinath Gopal on 14/10/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().backgroundColor = .green
    }
    
    
    @IBAction func onClickResetButton(_ sender: Any) {
        self.userNameTextField.text = ""
        self.passwordTextField.text = ""
    }
    
    @IBAction func onClickLogin(_ sender: Any) {
        let mainStoryboard : UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let landingScreenVC : LandingScreenViewController = mainStoryboard.instantiateViewController(withIdentifier: "LandingScreenViewController") as! LandingScreenViewController
        if validateUserName() && validatePassword(){
            self.navigationController?.pushViewController(landingScreenVC, animated: true)
        } else {
            let alert: UIAlertController = UIAlertController.init(title: "Invalid input", message: "Please check your username and password", preferredStyle: UIAlertController.Style.alert)
            let ok: UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(ok)
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func validateUserName() -> Bool {
        return !((self.userNameTextField.text?.isEmpty)!)
    }
    
    func validatePassword() -> Bool {
        return !((self.passwordTextField.text?.isEmpty)!)
    }
    
}

