//
//  HowToUseViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/29.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

class HowToUseViewController: UIViewController {
    
    @IBOutlet var backButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

       //検索ボタンのデザイン
              backButton.layer.cornerRadius = 15
              
              backButton.layer.shadowOffset = CGSize(width: 3, height: 3 )
              backButton.layer.shadowOpacity = 0.5
              backButton.layer.shadowRadius = 10
              backButton.layer.shadowColor = UIColor.gray.cgColor
        
    }
    
    
    @IBAction func back () {
        self.dismiss(animated: true, completion: nil)
        
    }

}
