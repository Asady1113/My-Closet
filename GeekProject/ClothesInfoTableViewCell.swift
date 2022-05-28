//
//  ClothesInfoTableViewCell.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/09/21.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

protocol ClothesInfoTableViewCellDelegate {
    func didTapPutOnButton(tableViewCell: UITableViewCell,button: UIButton)
    func didTapCancelButton(tableViewCell: UITableViewCell,button: UIButton)
    func didTapEditButton(tableViewCell: UITableViewCell,button: UIButton)
 }

class ClothesInfoTableViewCell: UITableViewCell {
    
    var delegate : ClothesInfoTableViewCellDelegate?
    
    @IBOutlet var clothesImageView : UIImageView!
    
    @IBOutlet var brandNameLabel : UILabel!
    
    @IBOutlet var buyDateLabel : UILabel!
    
    @IBOutlet var priceLabel : UILabel!
    
    @IBOutlet var commentTextView : UITextView!
    
    @IBOutlet var putOnCountLabel : UILabel!
    
    @IBOutlet var putOnButton : UIButton!
    
    @IBOutlet var cancelButton : UIButton!
    
    @IBOutlet var editButton : UIButton!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // ボタンを丸くする
        putOnButton.layer.cornerRadius = 12
        // テキストびゅうも丸くする
        commentTextView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func putOn(button: UIButton) {
        self.delegate?.didTapPutOnButton(tableViewCell: self,button: button)
    }
    
    @IBAction func cancel(button: UIButton) {
        self.delegate?.didTapCancelButton(tableViewCell: self,button: button)
    }
    
    @IBAction func edit(button: UIButton){
        self.delegate?.didTapEditButton(tableViewCell: self,button: button)
    }
    
    
    /// ボタンを押したタイミングで呼ばれます。
       @IBAction func didTouchDownPutOnButton() {
           // ボタンを縮こませます
        UIView.animate(withDuration: 0.2, animations: {
               self.putOnButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           })
       }

       /// ボタンを押下途中で指から離れたタイミングで呼ばれます。
       /// NOTE: ボタンに指が触れたままボタン外の領域まで指を移動したままにするとボタンが縮こまったままになってしまうのを防ぐ処理です。
       @IBAction func didTouchDragExitPutOnButton() {
           // 縮こまったボタンをアニメーションで元のサイズに戻します
        UIView.animate(withDuration: 0.2, animations: {
               self.putOnButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
       }

       /// ボタンが指から離れたタイミングで呼ばれます。
       @IBAction func didTouchUpInsidePutOnButton() {
           // バウンド処理です
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 0.3,
                          initialSpringVelocity: 8,
                          options: .curveEaseOut,
                          animations: { () -> Void in

               self.putOnButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }, completion: nil)
       }
    
    
    /// ボタンを押したタイミングで呼ばれます。
       @IBAction func didTouchDownCancelButton() {
           // ボタンを縮こませます
        UIView.animate(withDuration: 0.2, animations: {
               self.cancelButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           })
       }

       /// ボタンを押下途中で指から離れたタイミングで呼ばれます。
       /// NOTE: ボタンに指が触れたままボタン外の領域まで指を移動したままにするとボタンが縮こまったままになってしまうのを防ぐ処理です。
       @IBAction func didTouchDragExitCancelButton() {
           // 縮こまったボタンをアニメーションで元のサイズに戻します
        UIView.animate(withDuration: 0.2, animations: {
               self.cancelButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           })
       }

       /// ボタンが指から離れたタイミングで呼ばれます。
       @IBAction func didTouchUpInsideCancelButton() {
           // バウンド処理です
           UIView.animate(withDuration: 0.5,
                          delay: 0.0,
                          usingSpringWithDamping: 0.3,
                          initialSpringVelocity: 8,
                          options: .curveEaseOut,
                          animations: { () -> Void in

               self.cancelButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
           }, completion: nil)
       }
    
    
    
}
