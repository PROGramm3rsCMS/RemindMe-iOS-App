//
//  LoginViewController.swift
//  RemindMe
//
//  Created by Sammy Torres II on 11/8/22.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var createUsernameField: UITextField!
    @IBOutlet weak var createPasswordField: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onConfirmLogin(_ sender: Any) {
        let username = usernameField.text!
        let password = passwordField.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password){
            (user, error) in
            if(user != nil) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Error:\(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func onCreateLogin(_ sender: Any) {
        let user = PFUser()
        user.username = createUsernameField.text
        user.password = createPasswordField.text
        user.email = emailAddressField.text
        
        user.signUpInBackground{success, error in
            if(success){
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            else {
                print("Error:\(error?.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
