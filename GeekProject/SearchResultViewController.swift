//
//  SearchResultViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/13.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit
import NCMB
import Kingfisher
import KRProgressHUD

class SearchResultViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    // 選択された条件
    var selectedCategory : Int!
    var selectedColor : Int!
    
    var results = [Result]()
    
    @IBOutlet var clothesListTableView : UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        clothesListTableView.dataSource = self
        clothesListTableView.delegate = self
        
        clothesListTableView.backgroundColor = #colorLiteral(red: 0.9921784997, green: 0.8421893716, blue: 0.5883585811, alpha: 1)
        
        //カスタムセルの登録
        let nib = UINib(nibName: "ResultOfSearchTableViewCell",bundle: Bundle.main)
        clothesListTableView.register(nib, forCellReuseIdentifier: "ResultCell")
        
        clothesListTableView.tableFooterView = UIView()
        

        print(selectedCategory!)
        print(selectedColor!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // ちゃんとログイン状態が保たれている時
        if let user = NCMBUser.current() {
             loadResult()
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       let cell = clothesListTableView.dequeueReusableCell(withIdentifier: "ResultCell") as! ResultOfSearchTableViewCell
       let clothesImageView = cell.clothesImageView as! UIImageView
       let clothesImagePath = results[indexPath.row].imageUrl
        clothesImageView.kf.setImage(with: URL(string: clothesImagePath))
        //　他の情報を表示させる
        cell.brandNameLabel.text = results[indexPath.row].brandName
        cell.buyDateLabel.text = results[indexPath.row].buyDate
        cell.priceLabel.text = results[indexPath.row].price
        cell.commentTextView.text = results[indexPath.row].comment
        cell.putOnCountLabel.text = String(results[indexPath.row].putOnCount)
        
       return cell
    }
       
    

    
    //検索結果の読み込み
    func loadResult () {
        // もしロングトップスなら
        if selectedCategory == 0 {
          let query = NCMBQuery(className: "longTops")
          query?.includeKey("user")
          query?.whereKey("user", equalTo: NCMBUser.current())
          query?.whereKey("colorNumber", equalTo: selectedColor)
          query?.findObjectsInBackground({ (result, error) in
                if error != nil {
                    KRProgressHUD.showError()
                } else {
                    
                    self.results = [Result]()
                    
                    for object in result as! [NCMBObject] {
                    
                    // ユーザー情報をUserクラスにセット
                     let user = object.object(forKey: "user") as! NCMBUser
                     let userModel = User(objectId: user.objectId, userName: user.userName)
                    
                    // 服の情報を取得
                      let imageUrl = object.object(forKey: "imageUrl") as! String
                      let brandName = object.object(forKey: "brandName") as! String
                      let buyDate = object.object(forKey: "buyDate") as! String
                      let comment = object.object(forKey: "comment") as! String
                      let price = object.object(forKey: "price") as! String
                      let putOnCount = object.object(forKey: "putOnCount") as! Int
                        
                     // 取り出した情報をresult配列にappend
                      let result = Result(objectId: object.objectId, user: userModel, imageUrl: imageUrl, brandName: brandName, buyDate: buyDate, comment: comment, price: price,putOnCount: putOnCount)
                      self.results.append(result)
                     //データの読み込みの方が時間がかかるので、データ読み込み後にテーブルをリロードする
                        self.confirmContents ()
                     self.clothesListTableView.reloadData()
                    }
               }; self.confirmContents ()
            })
            // もし半袖トップスなら
        } else if selectedCategory == 1 {
            let query = NCMBQuery(className: "shortTops")
            query?.includeKey("user")
            query?.whereKey("user", equalTo: NCMBUser.current())
            // 選ばれたカラーナンバーと一致するものを
            query?.whereKey("colorNumber", equalTo: selectedColor)
            query?.findObjectsInBackground({ (result, error) in
                  if error != nil {
                     KRProgressHUD.showError()
                  } else {
                      
                      self.results = [Result]()
                      
                      for object in result as! [NCMBObject] {
                      
                      // ユーザー情報をUserクラスにセット
                       let user = object.object(forKey: "user") as! NCMBUser
                       let userModel = User(objectId: user.objectId, userName: user.userName)
                      
                      // 服の情報を取得
                        let imageUrl = object.object(forKey: "imageUrl") as! String
                        let brandName = object.object(forKey: "brandName") as! String
                        let buyDate = object.object(forKey: "buyDate") as! String
                        let comment = object.object(forKey: "comment") as! String
                        let price = object.object(forKey: "price") as! String
                        let putOnCount = object.object(forKey: "putOnCount") as! Int
                          
                        let result = Result(objectId: object.objectId, user: userModel, imageUrl: imageUrl, brandName: brandName, buyDate: buyDate, comment: comment, price: price,putOnCount: putOnCount)
                        self.results.append(result)
                       //データの読み込みの方が時間がかかるので、データ読み込み後にテーブルをリロードする
                       self.clothesListTableView.reloadData()
                      }
                  }; self.confirmContents ()
              })
           
        }   // もしボトムスなら
           else if selectedCategory == 2 {
            let query = NCMBQuery(className: "bottoms")
            query?.includeKey("user")
            query?.whereKey("user", equalTo: NCMBUser.current())
            query?.whereKey("colorNumber", equalTo: selectedColor)
            query?.findObjectsInBackground({ (result, error) in
                  if error != nil {
                      KRProgressHUD.showError()
                  } else {
                      
                      self.results = [Result]()
                      
                      for object in result as! [NCMBObject] {
                      
                      // ユーザー情報をUserクラスにセット
                       let user = object.object(forKey: "user") as! NCMBUser
                       let userModel = User(objectId: user.objectId, userName: user.userName)
                      
                      // 服の情報を取得
                        let imageUrl = object.object(forKey: "imageUrl") as! String
                        let brandName = object.object(forKey: "brandName") as! String
                        let buyDate = object.object(forKey: "buyDate") as! String
                        let comment = object.object(forKey: "comment") as! String
                        let price = object.object(forKey: "price") as! String
                        let putOnCount = object.object(forKey: "putOnCount") as! Int
                          
                        let result = Result(objectId: object.objectId, user: userModel, imageUrl: imageUrl, brandName: brandName, buyDate: buyDate, comment: comment, price: price,putOnCount: putOnCount)
                        self.results.append(result)
                       //データの読み込みの方が時間がかかるので、データ読み込み後にテーブルをリロードする
                       self.clothesListTableView.reloadData()
                      }
                  }; self.confirmContents ()
              })
        }  // もし靴・サンダルなら
           else if selectedCategory == 3 {
            let query = NCMBQuery(className: "shoes")
            query?.includeKey("user")
            query?.whereKey("user", equalTo: NCMBUser.current())
            query?.whereKey("colorNumber", equalTo: selectedColor)
            query?.findObjectsInBackground({ (result, error) in
                  if error != nil {
                      KRProgressHUD.showError()
                  } else {
                      
                      self.results = [Result]()
                      
                      for object in result as! [NCMBObject] {
                      
                      // ユーザー情報をUserクラスにセット
                       let user = object.object(forKey: "user") as! NCMBUser
                       let userModel = User(objectId: user.objectId, userName: user.userName)
                      
                      // 服の情報を取得
                        let imageUrl = object.object(forKey: "imageUrl") as! String
                        let brandName = object.object(forKey: "brandName") as! String
                        let buyDate = object.object(forKey: "buyDate") as! String
                        let comment = object.object(forKey: "comment") as! String
                        let price = object.object(forKey: "price") as! String
                        let putOnCount = object.object(forKey: "putOnCount") as! Int
                          
                        let result = Result(objectId: object.objectId, user: userModel, imageUrl: imageUrl, brandName: brandName, buyDate: buyDate, comment: comment, price: price,putOnCount: putOnCount)
                        self.results.append(result)
                       //データの読み込みの方が時間がかかるので、データ読み込み後にテーブルをリロードする
                       self.clothesListTableView.reloadData()
                      }
                  }; self.confirmContents ()
              })
        }  // もしその他なら
           else if selectedCategory == 4 {
            let query = NCMBQuery(className: "theOthers")
            query?.includeKey("user")
            query?.whereKey("user", equalTo: NCMBUser.current())
            query?.whereKey("colorNumber", equalTo: selectedColor)
            query?.findObjectsInBackground({ (result, error) in
                  if error != nil {
                      KRProgressHUD.showError()
                  } else {
                      
                      self.results = [Result]()
                      
                      for object in result as! [NCMBObject] {
                      
                      // ユーザー情報をUserクラスにセット
                       let user = object.object(forKey: "user") as! NCMBUser
                       let userModel = User(objectId: user.objectId, userName: user.userName)
                      
                      // 服の情報を取得
                        let imageUrl = object.object(forKey: "imageUrl") as! String
                        let brandName = object.object(forKey: "brandName") as! String
                        let buyDate = object.object(forKey: "buyDate") as! String
                        let comment = object.object(forKey: "comment") as! String
                        let price = object.object(forKey: "price") as! String
                        let putOnCount = object.object(forKey: "putOnCount") as! Int
                          
                        let result = Result(objectId: object.objectId, user: userModel, imageUrl: imageUrl, brandName: brandName, buyDate: buyDate, comment: comment, price: price,putOnCount: putOnCount)
                        self.results.append(result)
                       //データの読み込みの方が時間がかかるので、データ読み込み後にテーブルをリロードする
                       self.clothesListTableView.reloadData()
                      }
                  }; self.confirmContents ()
              })
        }
      }
    
    
    
    func confirmContents () {
        if results.count == 0 {
        let alert = UIAlertController(title: "検索結果０件", message: "お探しの服は見つかりませんでした。", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert,animated: true,completion: nil)
    }
    }
    
    
    
}
    
    


