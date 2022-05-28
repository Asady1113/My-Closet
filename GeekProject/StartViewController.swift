//
//  StartViewController.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/24.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet var titleImageView : UIImageView!
    @IBOutlet var haveAccountButton : UIButton!
    @IBOutlet var haveNoAccountButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        haveAccountButton.layer.cornerRadius = 10
        haveNoAccountButton.layer.cornerRadius = 10
        titleImageView.layer.cornerRadius = 30
        
    }
    

    

}
