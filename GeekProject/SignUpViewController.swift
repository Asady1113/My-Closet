//
//  SignUpViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/09/22.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit
import NCMB
import KRProgressHUD


class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var userIdTextField : UITextField!
    @IBOutlet var emailTextField : UITextField!
    @IBOutlet var passwordTextField : UITextField!
    @IBOutlet var confirmTextField : UITextField!
    @IBOutlet var signInButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        userIdTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmTextField.delegate = self
        
        signInButton.layer.cornerRadius = 10
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // エンターキーを押された時
        textField.resignFirstResponder()
        return true
    }
     
    //　新規登録ボタン
    @IBAction func signUp () {
        let user = NCMBUser()
        //　ユーザーIDが4文字以下の場合はreturnで終了
        if userIdTextField.text!.count < 4 {
            let alert = UIAlertController(title: "文字数が足りません。", message: "4文字以上のユーザーIDを入力してください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
            return
        }
        user.userName = userIdTextField.text!
        user.mailAddress = emailTextField.text!
        
        if passwordTextField.text == confirmTextField.text {
        // 確認用のパスワードが正しければ
            user.password = passwordTextField.text!
        } else {
            let alert = UIAlertController(title: "パスワードが正しくありません。", message: "パスワードを正しく入力してください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
        }
        
        user.signUpInBackground { (error) in
          if error != nil {
            //エラーが出た場合
            KRProgressHUD.showError()
           } else {
            // 登録完了
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
