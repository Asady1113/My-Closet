//
//  SelectCategoryViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/20.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    @IBOutlet var longTopsButton : UIButton!
    
    @IBOutlet var shortTopsButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        longTopsButton.layer.cornerRadius = 15
        shortTopsButton.layer.cornerRadius = 15
        
        longTopsButton.layer.shadowOffset = CGSize(width: 3, height: 3 )
        longTopsButton.layer.shadowOpacity = 0.5
        longTopsButton.layer.shadowRadius = 10
        longTopsButton.layer.shadowColor = UIColor.gray.cgColor
        
        shortTopsButton.layer.shadowOffset = CGSize(width: 3, height: 3 )
        shortTopsButton.layer.shadowOpacity = 0.5
        shortTopsButton.layer.shadowRadius = 10
        shortTopsButton.layer.shadowColor = UIColor.gray.cgColor
        
    }
    

    /// ボタンを押したタイミングで呼ばれます。
       @IBAction func didTouchDownLongTopsButton() {
           // ボタンを縮こませます
        UIView.animate(withDuration: 0.2, animations: {
               self.longTopsButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           })
       }

       /// ボタンを押下途中で指から離れたタイミングで呼ばれます。
       /// NOTE: ボタンに指が触れたままボタン外の領域まで指を移動したままにするとボタンが縮こまったままになってしまうのを防ぐ処理です。
       @IBAction func didTouchDragExitLongTopsButton() {
           // 縮こまったボタンをアニメーションで元のサイズに戻します
        UIView.animate(withDuration: 0.2, animations: {
               self.longTopsButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
       }

       /// ボタンが指から離れたタイミングで呼ばれます。
       @IBAction func didTouchUpInsideLongTopsButton() {
           // バウンド処理です
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 0.3,
                          initialSpringVelocity: 8,
                          options: .curveEaseOut,
                          animations: { () -> Void in

               self.longTopsButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }, completion: nil)
       }
    
    /// ボタンを押したタイミングで呼ばれます。
       @IBAction func didTouchDownShortTopsButton() {
           // ボタンを縮こませます
        UIView.animate(withDuration: 0.2, animations: {
               self.shortTopsButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           })
       }

       /// ボタンを押下途中で指から離れたタイミングで呼ばれます。
       /// NOTE: ボタンに指が触れたままボタン外の領域まで指を移動したままにするとボタンが縮こまったままになってしまうのを防ぐ処理です。
       @IBAction func didTouchDragExitShortTopsButton() {
           // 縮こまったボタンをアニメーションで元のサイズに戻します
        UIView.animate(withDuration: 0.2, animations: {
               self.shortTopsButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
       }

       /// ボタンが指から離れたタイミングで呼ばれます。
       @IBAction func didTouchUpInsideShortTopsButton() {
           // バウンド処理です
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 0.3,
                          initialSpringVelocity: 8,
                          options: .curveEaseOut,
                          animations: { () -> Void in

               self.shortTopsButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }, completion: nil)
       }
    
    
}
