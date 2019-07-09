//
//  AddCurrencyPairCell.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class AddCurrencyPairCell: UITableViewCell {
  
  
  @IBOutlet weak var amountLabel: UILabel!
  
  @IBOutlet weak var amountCurrencyLabel: UILabel!
  
  @IBOutlet weak var rateLabel: UILabel!
  
  @IBOutlet weak var rateCurrencyLabel: UILabel!
  

    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }

}
