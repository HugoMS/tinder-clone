/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController {

    var signupMode = true
    //MARK: Properties
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBOutlet weak var changeSignupModeButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    //MARK: Actions
    
    @IBAction func signupOrLogin(_ sender: AnyObject) {
        
        let user = PFUser()
        if signupMode {
            user.username = usernameField.text
            user.password = passwordField.text
            
            user.signUpInBackground { (success, error) in
                
                if error != nil {
                    
                    var errorMessage = "Sign Up Failed - please try again"
                    
                    if let parseError  = (error! as NSError).userInfo["error"] as? String {
                        
                        errorMessage = parseError
                    }
                    
                    self.errorLabel.text = errorMessage
                } else{
                    
                    print("Sign Up")
                    
                }
            }
        }
        else{
            
            PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!, block: { (user, error) in
                
                if error != nil {
                    
                    var errorMessage = "Sign Up Failed - please try again"
                    
                    if let parseError  = (error! as NSError).userInfo["error"] as? String {
                        
                        errorMessage = parseError
                    }
                    
                    self.errorLabel.text = errorMessage
                } else{
                    
                    print("Logged In")
                    
                }
            })
                
            
        }
        
    }
    
    @IBAction func changeSignup(_ sender: AnyObject) {
        
        if signupMode{
            
            signupMode = false
            
            signupOrLoginButton.setTitle("Log In", for: [])
            
            changeSignupModeButton.setTitle("Sing Up", for: [])
            
        } else {
            
            signupMode = true

            
            signupOrLoginButton.setTitle("Sign Up", for: [])
            
            changeSignupModeButton.setTitle("Log In ", for: [])
            
        }
        
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let testObject = PFObject(className: "TestObject2")
        
        testObject["foo"] = "bar"
        
        testObject.saveInBackground { (success, error) -> Void in
            
            // added test for success 11th July 2016
            
            if success {
                
                print("Object has been saved.")
                
            } else {
                
                if error != nil {
                    
                    print (error)
                    
                } else {
                    
                    print ("Error")
                }
                
            }
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
