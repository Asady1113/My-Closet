//
//  TheOthersListViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/06.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit
import NCMB
import KRProgressHUD
import Kingfisher


class TheOthersListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,ClothesInfoTableViewCellDelegate  {

    // カテゴリナンバを４にする
    let category : Int = 4
    
    var theOtherses = [TheOthers]()
    
    @IBOutlet var clothesListTableView : UITableView!
        

        override func viewDidLoad() {
            super.viewDidLoad()
            
            clothesListTableView.dataSource = self
            clothesListTableView.delegate = self
            
            clothesListTableView.backgroundColor = #colorLiteral(red: 0.9921784997, green: 0.8421893716, blue: 0.5883585811, alpha: 1)
            
            //カスタムセルの登録
            let nib = UINib(nibName: "ClothesInfoTableViewCell",bundle: Bundle.main)
            clothesListTableView.register(nib, forCellReuseIdentifier: "Cell")
            
            clothesListTableView.tableFooterView = UIView()
            
        }
        
        override func viewWillAppear(_ animated: Bool) {
            
            // ちゃんとログイン状態が保たれている時
            if let user = NCMBUser.current() {
                 loadtheOthers()
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
           // loadtheOthers()
        }
        

        
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return theOtherses.count
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = clothesListTableView.dequeueReusableCell(withIdentifier: "Cell") as! ClothesInfoTableViewCell
            // セルのボタンの動作のために必要
            cell.delegate = self
            
            // どのセルのボタンかを設定する
            let button = UIButton()
            button.addTarget(self, action: #selector(self.didTapPutOnButton(tableViewCell:button:)), for: UIControl.Event.touchUpInside)
            //タグの設定
            cell.putOnButton.tag = indexPath.row
            cell.cancelButton.tag = indexPath.row
            cell.editButton.tag = indexPath.row
            
            // セルに画像データをイメージに変換して表示
            let clothesImageView = cell.clothesImageView as! UIImageView
            let clothesImagePath = theOtherses[indexPath.row].imageUrl
            clothesImageView.kf.setImage(with: URL(string: clothesImagePath))
            //　他の情報を表示させる
            cell.brandNameLabel.text = theOtherses[indexPath.row].brandName
            cell.buyDateLabel.text = theOtherses[indexPath.row].buyDate
            cell.priceLabel.text = theOtherses[indexPath.row].price
            cell.commentTextView.text = theOtherses[indexPath.row].comment
            cell.putOnCountLabel.text = String(theOtherses[indexPath.row].putOnCount)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.performSegue(withIdentifier: "editTheOthers", sender: nil)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
       
        //着用ボタンが押された時(tableViewCellの情報とbuttonの情報(どのセルのボタンか、など）が与えられている
        @objc func didTapPutOnButton(tableViewCell: UITableViewCell,button: UIButton) {
        //buttonに、押されたボタンのタグ番号（イント）が保存されているので、longTopses配列のタグ番目の着用回数を扱う
            //データの取り出しと更新
            var putOnCount =  self.theOtherses[button.tag].putOnCount
            putOnCount = putOnCount + 1
            
            let query = NCMBQuery(className: "theOthers")
            query?.getObjectInBackground(withId: theOtherses[button.tag].objectId, block: { (result, error) in
                if error != nil {
                    KRProgressHUD.showError()
                } else {
                   result?.setObject(putOnCount, forKey: "putOnCount")
                    result?.saveInBackground({ (error) in
                        if error != nil {
                            KRProgressHUD.showError()
                        } else {
                            // セットが完了すれば
                            self.loadtheOthers()
                        }
                    })
                }
            })
        }
        
        //キャンセルボタンが押された時
        @objc func didTapCancelButton(tableViewCell: UITableViewCell, button: UIButton) {
            //buttonに、押されたボタンのタグ番号（イント）が保存されているので、longTopses配列のタグ番目の着用回数を扱う
            //データの取り出しと更新
            var putOnCount =  self.theOtherses[button.tag].putOnCount
            if putOnCount == 0 {
                putOnCount = 0
            } else {
                putOnCount = putOnCount - 1
                
                let query = NCMBQuery(className: "theOthers")
                query?.getObjectInBackground(withId: theOtherses[button.tag].objectId, block: { (result, error) in
                    if error != nil {
                        KRProgressHUD.showError()
                    } else {
                       result?.setObject(putOnCount, forKey: "putOnCount")
                        result?.saveInBackground({ (error) in
                            if error != nil {
                                KRProgressHUD.showError()
                            } else {
                                // セットが完了すれば
                                self.loadtheOthers()
                            }
                        })
                    }
                })
            }
        }
        
        //編集ボタンが押された時
        @objc func didTapEditButton(tableViewCell: UITableViewCell, button: UIButton) {
            let alertController = UIAlertController(title: "服を削除", message: "復元できません。削除しますか？", preferredStyle: .actionSheet)
            let deleteAction = UIAlertAction(title: "削除", style: .default) { (action) in
                //ボタンを押されたセルのデータを呼び出し
                let query = NCMBQuery(className: "theOthers")
                query?.getObjectInBackground(withId: self.theOtherses[button.tag].objectId, block: { (result, error) in
                    if error != nil {
                        KRProgressHUD.showError()
                    } else {
                        // データの削除
                        result?.deleteInBackground({ (error) in
                            if error != nil {
                                KRProgressHUD.showError()
                            } else {
                                print("success")
                                
                              self.loadtheOthers()
                              alertController.dismiss(animated: true, completion: nil)
                            }
                        })
                    }
                })
            }
            let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
                alertController.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(deleteAction)
            alertController.addAction(cancelAction)
            self.present(alertController,animated: true,completion: nil)
        }
        
        
        // 保存しているデータの読み込み
        func loadtheOthers () {
            let query = NCMBQuery(className: "theOthers")
            query?.includeKey("user")
            query?.whereKey("user", equalTo: NCMBUser.current())
            query?.findObjectsInBackground({ (result, error) in
                if error != nil  {
                    KRProgressHUD.showError()
                } else {
                    self.theOtherses = [TheOthers]()
                    
                    // 情報の取り出し
                    for addObject in result as! [NCMBObject] {
                      // ユーザー情報をUserクラスにセット
                       let user = addObject.object(forKey: "user") as! NCMBUser
                       let userModel = User(objectId: user.objectId, userName: user.userName)
                      
                      // 服の情報を取得
                        let imageUrl = addObject.object(forKey: "imageUrl") as! String
                        let brandName = addObject.object(forKey: "brandName") as! String
                        let buyDate = addObject.object(forKey: "buyDate") as! String
                        let comment = addObject.object(forKey: "comment") as! String
                        let price = addObject.object(forKey: "price") as! String
                        let putOnCount = addObject.object(forKey: "putOnCount") as! Int
                        let colorNumber = addObject.object(forKey: "colorNumber") as! Int
                      
                        
                      // 上の二つのデータを合わせてlongTopsクラスにセット
                        let theOthers = TheOthers(objectId: addObject.objectId, user: userModel, imageUrl: imageUrl, brandName: brandName, buyDate: buyDate, comment: comment, price: price,putOnCount: putOnCount,colorNumber: colorNumber)
                        
                      // 配列に加える
                        self.theOtherses.append(theOthers)
            // データの読み込みの方が時間がかかるので、データ読み込み後にテーブルをリロードする
                        self.clothesListTableView.reloadData()
                    }
                }
            })
        }
        
        
        // プラスボタンが押された時
        @IBAction func addClothes () {
            self.performSegue(withIdentifier: "theOthersSegue", sender: nil)
        }
        // カテゴリナンバーを送る
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // データの追加の場合
            if segue.identifier == "theOthersSegue" {
                let addClothesViewController = segue.destination as! AddClothesViewController
                addClothesViewController.selectedCategory = category
                // データの更新の場合
            } else if segue.identifier == "editTheOthers" {
                let editViewController = segue.destination as! EditViewController
                let selectedIndex = clothesListTableView.indexPathForSelectedRow!
                editViewController.objectId = theOtherses[selectedIndex.row].objectId
                editViewController.colorNumber = theOtherses[selectedIndex.row].colorNumber
                editViewController.imageUrl = theOtherses[selectedIndex.row].imageUrl
                editViewController.brandName = theOtherses[selectedIndex.row].brandName
                editViewController.buyDate = theOtherses[selectedIndex.row].buyDate
                editViewController.price = theOtherses[selectedIndex.row].price
                editViewController.comment = theOtherses[selectedIndex.row].comment
                editViewController.selectedCategory = category
            }
        }
        
    }
