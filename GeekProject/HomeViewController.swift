//
//  HomeViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/09/22.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit
import NCMB
import KRProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var titleImagwView : UIImageView!
    
    
    @IBOutlet var searchButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
       // self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background-image.JPG")!)
        titleImagwView.layer.cornerRadius = 30
        
        
        // ちゃんとログイン状態が保たれている時
        if let user = NCMBUser.current() {
            self.navigationItem.title = user.userName as! String
        } else {
            let alert = UIAlertController(title: "ログインタイムアウト", message: "ログインがタイムアウトしました。再度ログインしてください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // NCMBUser.current()がnilだった場合
                          let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                          let rootViewController = storyboard.instantiateViewController(identifier: "RootNavigationController")
                          UIApplication.shared.keyWindow?.rootViewController = rootViewController
                                             
                           // ログイン状態の解除
                          let ud = UserDefaults.standard
                          ud.set(false, forKey: "isLogin")
                          ud.synchronize()
                       }
              alert.addAction(okAction)
              self.present(alert,animated: true,completion: nil)
            }
        
        
        // アニメーション
        UIView.animate(withDuration: 2.0) {
            self.titleLabel.frame = CGRect(x: 94, y: 155, width: Int(self.titleLabel.bounds.width), height: Int(self.titleLabel.bounds.height))


        }
        
        //検索ボタンのデザイン
        searchButton.layer.cornerRadius = 15
        
        searchButton.layer.shadowOffset = CGSize(width: 3, height: 3 )
        searchButton.layer.shadowOpacity = 0.5
        searchButton.layer.shadowRadius = 10
        searchButton.layer.shadowColor = UIColor.gray.cgColor 
        
         
       // loadDate()
      }
    
    
    
  
    /// ボタンを押したタイミングで呼ばれます。
       @IBAction func didTouchDownButton() {
           // ボタンを縮こませます
        UIView.animate(withDuration: 0.2, animations: {
               self.searchButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           })
       }

       /// ボタンを押下途中で指から離れたタイミングで呼ばれます。
       /// NOTE: ボタンに指が触れたままボタン外の領域まで指を移動したままにするとボタンが縮こまったままになってしまうのを防ぐ処理です。
       @IBAction func didTouchDragExitButton() {
           // 縮こまったボタンをアニメーションで元のサイズに戻します
        UIView.animate(withDuration: 0.2, animations: {
               self.searchButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
       }

       /// ボタンが指から離れたタイミングで呼ばれます。
       @IBAction func didTouchUpInsideButton() {
           // バウンド処理です
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 0.3,
                          initialSpringVelocity: 8,
                          options: .curveEaseOut,
                          animations: { () -> Void in

               self.searchButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }, completion: nil)
       }
    
    
    
    
    @IBAction func showMenu () {
        // ログイン状態が保たれていたら
        if let user = NCMBUser.current() {
            let alertController = UIAlertController(title: "メニュー", message: "メニューを選択してください。", preferredStyle: .actionSheet)
            let signOutAction = UIAlertAction(title: "ログアウト", style: .default)
            {(action) in
                    // ログアウト
                NCMBUser.logOutInBackground { (error) in
                    if error != nil {
                        KRProgressHUD.showError()
                    } else {
                    // サインインのページに移動
                    let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                    let rootViewController = storyboard.instantiateViewController(identifier: "RootNavigationController")
                    UIApplication.shared.keyWindow?.rootViewController = rootViewController
                           
                    // ログイン状態の解除
                        let ud = UserDefaults.standard
                        ud.set(false, forKey: "isLogin")
                        ud.synchronize()
                       }
                   }
               }
               let deleteAccount = UIAlertAction(title: "退会", style: .default) { (action) in
                   //現在使用しているアカウントを消去
                   let user = NCMBUser.current()
                   user?.deleteInBackground({ (error) in
                       if error != nil {
                          KRProgressHUD.showError()
                       } else {
                           // サインインのページに移動
                        let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                        let rootViewController = storyboard.instantiateViewController(identifier: "RootNavigationController")
                        UIApplication.shared.keyWindow?.rootViewController = rootViewController
                           
                        // ログイン状態の解除
                        let ud = UserDefaults.standard
                        ud.set(false, forKey: "isLogin")
                        ud.synchronize()
                       }
                   })
               }
              
               let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel)
               {(action) in
                   alertController.dismiss(animated: true, completion: nil)
               }
               alertController.addAction(signOutAction)
               alertController.addAction(deleteAccount)
               alertController.addAction(cancelAction)
               
               self.present(alertController,animated: true,completion: nil)
        } else {
            let alert = UIAlertController(title: "ログインタイムアウト", message: "ログインがタイムアウトしました。再度ログインしてください。", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // NCMBUser.current()がnilだった場合
                          let storyboard = UIStoryboard(name: "SignIn", bundle: Bundle.main)
                          let rootViewController = storyboard.instantiateViewController(identifier: "RootNavigationController")
                          UIApplication.shared.keyWindow?.rootViewController = rootViewController
                                             
                           // ログイン状態の解除
                          let ud = UserDefaults.standard
                          ud.set(false, forKey: "isLogin")
                          ud.synchronize()
                       }
              alert.addAction(okAction)
              self.present(alert,animated: true,completion: nil)
        }
    }
    

   

}
