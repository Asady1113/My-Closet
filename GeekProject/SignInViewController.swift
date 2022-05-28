//
//  SignInViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/09/22.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit
import NCMB


class SignInViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var userIdTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var loginButton : UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
 
        userIdTextField.delegate = self
        passwordTextField.delegate = self
        
        loginButton.layer.cornerRadius = 10
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.resignFirstResponder()
           return true
       }
    
    @IBAction func signIn() {
        // ちゃんとIDとパスワードが入っていたら
        if userIdTextField.text!.count > 0 && passwordTextField.text!.count > 0 {
        NCMBUser.logInWithUsername(inBackground: userIdTextField.text, password: passwordTextField.text) { (user, error) in
                   if error != nil {
                       let alert = UIAlertController(title: "ログインエラー", message: "ログインに失敗しました。再度お試しください。", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                           alert.dismiss(animated: true, completion: nil)
                       }
                       alert.addAction(okAction)
                       self.present(alert,animated: true,completion: nil)
                   } else {
                    // ログインできたら
                   let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                   let rootViewController = storyboard.instantiateViewController(identifier: "RootTabBarController")
                   UIApplication.shared.keyWindow?.rootViewController = rootViewController
                    
                    // ログイン状態の保持
                    let ud = UserDefaults.standard
                    ud.set(true, forKey: "isLogin")
                    ud.synchronize()
                   }
                }
           }
       }
       
      
           
           
       
    
    

}
