//
//  ResultOfSearchTableViewCell.swift
//  GeekProject
//
//  Created by 浅田智哉 on 2020/10/14.
//  Copyright © 2020 asadatomoya.com. All rights reserved.
//

import UIKit

class ResultOfSearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet var clothesImageView : UIImageView!
    
    @IBOutlet var brandNameLabel : UILabel!
    
    @IBOutlet var buyDateLabel : UILabel!
    
    @IBOutlet var priceLabel : UILabel!
    
    @IBOutlet var commentTextView : UITextView!
    
    @IBOutlet var putOnCountLabel : UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
       // テキストびゅうも丸くする
       commentTextView.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
