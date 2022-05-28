//
//  EditViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/05.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit
import NCMB
import UITextView_Placeholder
import KRProgressHUD
import Kingfisher

class EditViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var objectId : String!
    
    var selectedCategory : Int!
    
    var colorNumber : Int!
    
    let placeholderImage = UIImage(named: "clothes-placeholder-icon@2x.png")
    
    var resizedImage : UIImage!
    
    var datePicker: UIDatePicker = UIDatePicker()

    var imageUrl : String!
    var brandName : String!
    var buyDate : String!
    var price : String!
    var comment : String!
    
    @IBOutlet var clothesImageView : UIImageView!
    
    @IBOutlet var brandNameTextField : UITextField!
    
    @IBOutlet var buyDateTextField : UITextField!
    
    @IBOutlet var priceTextField : UITextField!
    
    @IBOutlet var commentTextView : UITextView!
    
    @IBOutlet var colorCategoryLabel : UILabel!
    
    @IBOutlet var editButton : UIButton!
    
    @IBOutlet var selectImageButton : UIButton!
    
    @IBOutlet var blackButton : UIButton!
    @IBOutlet var whiteButton : UIButton!
    @IBOutlet var brownButton : UIButton!
    @IBOutlet var beigeButton : UIButton!
    @IBOutlet var orangeButton : UIButton!
    @IBOutlet var yellowButton : UIButton!
    @IBOutlet var redButton : UIButton!
    @IBOutlet var blueButton : UIButton!
    @IBOutlet var greenButton : UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        print(selectedCategory!)
        
        editButton.isEnabled = false
        
        selectImageButton.layer.cornerRadius = 10
       
        brandNameTextField.delegate = self
        buyDateTextField.delegate = self
        priceTextField.delegate = self
        
        
        commentTextView.placeholder = "服に関する情報を記入しよう！（どこに保存したか、注意点など）"
        commentTextView.delegate = self
        commentTextView.layer.borderColor = UIColor.gray.cgColor
        commentTextView.layer.borderWidth = 0.5
        commentTextView.layer.cornerRadius = 10
        
        //色指定ボタンを丸く
        blackButton.layer.cornerRadius = 10
        whiteButton.layer.cornerRadius = 10
        brownButton.layer.cornerRadius = 10
        beigeButton.layer.cornerRadius = 10
        orangeButton.layer.cornerRadius = 10
        yellowButton.layer.cornerRadius = 10
        redButton.layer.cornerRadius = 10
        blueButton.layer.cornerRadius = 10
        greenButton.layer.cornerRadius = 10
        
        
       // 送られたデータを表示
        clothesImageView.kf.setImage(with: URL(string: imageUrl))
        
        brandNameTextField.text = brandName
        
        buyDateTextField.text = buyDate
        
        priceTextField.text = price
        
        commentTextView.text = comment
        
        // カラーナンバーを反映
        if colorNumber == 0 {
            colorCategoryLabel.text = "ブラック"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 1 {
            colorCategoryLabel.text = "ホワイト"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 2 {
            colorCategoryLabel.text = "ブラウン"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 3 {
            colorCategoryLabel.text = "ベージュ"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 4 {
            colorCategoryLabel.text = "オレンジ"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 5 {
            colorCategoryLabel.text = "イエロー"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 6 {
            colorCategoryLabel.text = "レッド"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 7 {
            colorCategoryLabel.text = "ブルー"
            colorCategoryLabel.textColor = UIColor.black
        }
        if colorNumber == 8 {
            colorCategoryLabel.text = "グリーン"
            colorCategoryLabel.textColor = UIColor.black
        }
        
        //  購入日のシステム
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.locale = Locale.current
        buyDateTextField.inputView = datePicker
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        
        buyDateTextField.inputView = datePicker
        buyDateTextField.inputAccessoryView = toolbar
      
    }
    
    //  購入日の決定ボタン
    @objc func done() {
        buyDateTextField.endEditing(true)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        buyDateTextField.text = "\(formatter.string(from: datePicker.date))"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        confirmContents()
        return true
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        confirmContents()
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
    // 選択された画像の表示
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
    // 画像のサイズ変更
     resizedImage = selectedImage.scale(byFactor: 0.2)
     clothesImageView.image = resizedImage
     picker.dismiss(animated: true, completion: nil)
     
    // 確認
     confirmContents()
    }
    
    
    
    @IBAction func selectImage () {
    let alertController = UIAlertController(title: "画像の選択", message: "服の画像を選択してください", preferredStyle: .actionSheet)
    let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
          alertController.dismiss(animated: true, completion: nil)
        }
    let cameraAction = UIAlertAction(title: "カメラで撮影", style: .default) { (action) in
         // もしカメラ起動可能なら
        if UIImagePickerController.isSourceTypeAvailable(.camera) == true {
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
        } else {
            let alert = UIAlertController(title: "エラー", message: "この機種ではカメラは使用できません", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
         }
        }
    let photoLibraryAction = UIAlertAction(title: "フォトライブラリから選択", style: .default) { (action) in
        // フォトライブラリが使えるなら
       if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) == true {
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            self.present(picker,animated: true,completion: nil)
        } else {
            let alert = UIAlertController(title: "エラー", message: "この機種ではフォトライブラリは使用できません", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert,animated: true,completion: nil)
        }
       }
        alertController.addAction(cancelAction)
        alertController.addAction(cameraAction)
        alertController.addAction(photoLibraryAction)
        self.present(alertController,animated: true,completion: nil)
    }
    
    // 編集ボタンが押されたら
    @IBAction func edit () {
         KRProgressHUD.show()
        // もし写真に変更が加えられていない場合は
        if resizedImage == nil {
            resizedImage = clothesImageView.image
        }
        
        // 撮影した画像をデータ化したときに右に90度回転してしまう問題の解消
        UIGraphicsBeginImageContext(resizedImage.size)
        let rect = CGRect(x: 0, y: 0, width: resizedImage.size.width, height: resizedImage.size.height)
        resizedImage.draw(in: rect)
        resizedImage = UIGraphicsGetImageFromCurrentImageContext()
               UIGraphicsEndImageContext()
               
        let data = UIImage.pngData(resizedImage)
        
        // まず画像の保存
        let file = NCMBFile.file(with: data()) as! NCMBFile
           file.saveInBackground({ (error) in
            // アップロード失敗したら
            if error != nil {
               KRProgressHUD.dismiss()
               let alert = UIAlertController(title: "画像アップロードエラー", message: error?.localizedDescription, preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    
                }
                alert.addAction(okAction)
                self.present(alert,animated: true,completion: nil)
                    
            } else {
                // 画像アップロード成功して
                // 長袖トップス（0）なら
                if self.selectedCategory == 0 {
                    let query = NCMBQuery(className: "longTops")
                    query?.getObjectInBackground(withId: self.objectId, block: { (result, error) in
                        if error != nil {
                            print(error)
                        } else {
                            result?.setObject(self.brandNameTextField.text!, forKey: "brandName")
                            result?.setObject(self.buyDateTextField.text!, forKey: "buyDate")
                            result?.setObject(self.priceTextField.text!, forKey: "price")
                            result?.setObject(self.commentTextView.text!, forKey: "comment")
                            result?.setObject(self.colorNumber, forKey: "colorNumber")
                            
                            // imageのURLをlongTopsClass内に送信
                            let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/PkVR29FgqOp7BtkZ/publicFiles/" + file.name
                            result?.setObject(url, forKey: "imageUrl")
                            result?.saveInBackground({ (error) in
                              if error != nil {
                               KRProgressHUD.showError()
                                  
                              } else {
                                  // 保存後は追加画面を初期化（さらの状態に）
                                  KRProgressHUD.dismiss()
                                  self.clothesImageView.image = nil
                                  self.clothesImageView.image = UIImage(named: "clothes-placeholder-icon@2x.png")
                                  self.brandNameTextField.text = nil
                                  self.buyDateTextField.text = nil
                                  self.priceTextField.text = nil
                                  self.commentTextView.text = nil
                                  // 画面を閉じる
                                  self.dismiss(animated: true, completion: nil)
                              }
                            })
                        }
                    })
                }  else if self.selectedCategory == 1 {
                    let query = NCMBQuery(className: "shortTops")
                    query?.getObjectInBackground(withId: self.objectId, block: { (result, error) in
                        if error != nil {
                            print(error)
                        } else {
                            result?.setObject(self.brandNameTextField.text!, forKey: "brandName")
                            result?.setObject(self.buyDateTextField.text!, forKey: "buyDate")
                            result?.setObject(self.priceTextField.text!, forKey: "price")
                            result?.setObject(self.commentTextView.text!, forKey: "comment")
                            result?.setObject(self.colorNumber, forKey: "colorNumber")
                            
                            // imageのURLをClass内に送信
                            let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/PkVR29FgqOp7BtkZ/publicFiles/" + file.name
                            result?.setObject(url, forKey: "imageUrl")
                            result?.saveInBackground({ (error) in
                              if error != nil {
                               KRProgressHUD.showError()
                                  
                              } else {
                                  // 保存後は追加画面を初期化（さらの状態に）
                                  KRProgressHUD.dismiss()
                                  self.clothesImageView.image = nil
                                  self.clothesImageView.image = UIImage(named: "clothes-placeholder-icon@2x.png")
                                  self.brandNameTextField.text = nil
                                  self.buyDateTextField.text = nil
                                  self.priceTextField.text = nil
                                  self.commentTextView.text = nil
                                  // 画面を閉じる
                                  self.dismiss(animated: true, completion: nil)
                              }
                            })
                        }
                    })
                    // もしカテゴリナンバ２（ボトムスの時）
                }  else if self.selectedCategory == 2 {
                    let query = NCMBQuery(className: "bottoms")
                    query?.getObjectInBackground(withId: self.objectId, block: { (result, error) in
                        if error != nil {
                            print(error)
                        } else {
                            result?.setObject(self.brandNameTextField.text!, forKey: "brandName")
                            result?.setObject(self.buyDateTextField.text!, forKey: "buyDate")
                            result?.setObject(self.priceTextField.text!, forKey: "price")
                            result?.setObject(self.commentTextView.text!, forKey: "comment")
                            result?.setObject(self.colorNumber, forKey: "colorNumber")
                            
                            // imageのURLをClass内に送信
                            let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/PkVR29FgqOp7BtkZ/publicFiles/" + file.name
                            result?.setObject(url, forKey: "imageUrl")
                            result?.saveInBackground({ (error) in
                              if error != nil {
                               KRProgressHUD.showError()
                                  
                              } else {
                                  // 保存後は追加画面を初期化（さらの状態に）
                                  KRProgressHUD.dismiss()
                                  self.clothesImageView.image = nil
                                  self.clothesImageView.image = UIImage(named: "clothes-placeholder-icon@2x.png")
                                  self.brandNameTextField.text = nil
                                  self.buyDateTextField.text = nil
                                  self.priceTextField.text = nil
                                  self.commentTextView.text = nil
                                  // 画面を閉じる
                                  self.dismiss(animated: true, completion: nil)
                              }
                            })
                        }
                    })
                } else if self.selectedCategory == 3 {
                    let query = NCMBQuery(className: "shoes")
                    query?.getObjectInBackground(withId: self.objectId, block: { (result, error) in
                        if error != nil {
                            print(error)
                        } else {
                            result?.setObject(self.brandNameTextField.text!, forKey: "brandName")
                            result?.setObject(self.buyDateTextField.text!, forKey: "buyDate")
                            result?.setObject(self.priceTextField.text!, forKey: "price")
                            result?.setObject(self.commentTextView.text!, forKey: "comment")
                            result?.setObject(self.colorNumber, forKey: "colorNumber")
                            
                            // imageのURLをClass内に送信
                            let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/PkVR29FgqOp7BtkZ/publicFiles/" + file.name
                            result?.setObject(url, forKey: "imageUrl")
                            result?.saveInBackground({ (error) in
                              if error != nil {
                               KRProgressHUD.showError()
                                  
                              } else {
                                  // 保存後は追加画面を初期化（さらの状態に）
                                  KRProgressHUD.dismiss()
                                  self.clothesImageView.image = nil
                                  self.clothesImageView.image = UIImage(named: "clothes-placeholder-icon@2x.png")
                                  self.brandNameTextField.text = nil
                                  self.buyDateTextField.text = nil
                                  self.priceTextField.text = nil
                                  self.commentTextView.text = nil
                                  // 画面を閉じる
                                  self.dismiss(animated: true, completion: nil)
                              }
                            })
                        }
                    })
                    // もしカテゴリナンバが４（その他なら
                }  else if self.selectedCategory == 4 {
                    let query = NCMBQuery(className: "theOthers")
                    query?.getObjectInBackground(withId: self.objectId, block: { (result, error) in
                        if error != nil {
                            print(error)
                        } else {
                            result?.setObject(self.brandNameTextField.text!, forKey: "brandName")
                            result?.setObject(self.buyDateTextField.text!, forKey: "buyDate")
                            result?.setObject(self.priceTextField.text!, forKey: "price")
                            result?.setObject(self.commentTextView.text!, forKey: "comment")
                            result?.setObject(self.colorNumber, forKey: "colorNumber")
                            
                            // imageのURLをClass内に送信
                            let url = "https://mbaas.api.nifcloud.com/2013-09-01/applications/PkVR29FgqOp7BtkZ/publicFiles/" + file.name
                            result?.setObject(url, forKey: "imageUrl")
                            result?.saveInBackground({ (error) in
                              if error != nil {
                               KRProgressHUD.showError()
                                  
                              } else {
                                  // 保存後は追加画面を初期化（さらの状態に）
                                  KRProgressHUD.dismiss()
                                  self.clothesImageView.image = nil
                                  self.clothesImageView.image = UIImage(named: "clothes-placeholder-icon@2x.png")
                                  self.brandNameTextField.text = nil
                                  self.buyDateTextField.text = nil
                                  self.priceTextField.text = nil
                                  self.commentTextView.text = nil
                                  // 画面を閉じる
                                  self.dismiss(animated: true, completion: nil)
                              }
                            })
                        }
                    })
                }
            }
        })
    }
    
    
    // カラーの選択
    @IBAction func black () {
        colorNumber = 0
        colorCategoryLabel.text = "ブラック"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func white () {
        colorNumber = 1
        colorCategoryLabel.text = "ホワイト"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func brown () {
        colorNumber = 2
        colorCategoryLabel.text = "ブラウン"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func beige () {
        colorNumber = 3
        colorCategoryLabel.text = "ベージュ"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func orange () {
        colorNumber = 4
        colorCategoryLabel.text = "オレンジ"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func yellow () {
        colorNumber = 5
        colorCategoryLabel.text = "イエロー"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func red () {
        colorNumber = 6
        colorCategoryLabel.text = "レッド"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func blue () {
        colorNumber = 7
        colorCategoryLabel.text = "ブルー"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    @IBAction func green () {
        colorNumber = 8
        colorCategoryLabel.text = "グリーン"
        colorCategoryLabel.textColor = UIColor.black
        confirmContents()
    }
    
    
    //項目の確認 ちゃんと入ってたら
    func confirmContents () {
        if clothesImageView.image != placeholderImage
            && brandNameTextField.text!.count > 0
            && buyDateTextField.text!.count > 0
            && priceTextField.text!.count > 0
            && commentTextView.text!.count > 0
            // カラーナンバーがnilじゃないとき
            && colorNumber != nil     {
            editButton.isEnabled = true
        } else {
            editButton.isEnabled = false
        }
    }
    
    
    
    @IBAction func cancel () {
        let alert = UIAlertController(title: "変更内容の破棄", message: "行った変更内容は破棄されます。よろしいですか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert,animated: true,completion: nil)
    }

}
