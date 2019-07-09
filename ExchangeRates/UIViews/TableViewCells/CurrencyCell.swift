//
//  CurrencyCell.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class CurrencyCell: UITableViewCell {
  
  
  //Factory methods
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setUpViews()
    
  }
   required init?(coder aDecoder: NSCoder) {
    fatalError("not caled")
    }
  
  
   func setUpViews(){
    
    
    
    addSubview(currencyCountryUIImage)
    addSubview(currencyUILabel)
    addSubview(currencyCountryUILabel)
    
    
    currencyCountryUIImage.leftAnchor.constraint(equalTo: leftAnchor,constant: 15).isActive = true
    currencyCountryUIImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    currencyCountryUIImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
    currencyCountryUIImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
    
    
    currencyUILabel.leftAnchor.constraint(equalTo: currencyCountryUIImage.rightAnchor,constant: 20).isActive = true
    currencyUILabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    currencyUILabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
    
    currencyCountryUILabel.leftAnchor.constraint(equalTo: currencyUILabel.rightAnchor,constant: 12).isActive = true
    currencyCountryUILabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    
  }
  
  
  lazy var currencyCountryUIImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.layer.cornerRadius = 20
    imageView.layer.borderColor = UIColor.lightGray.cgColor
    imageView.layer.borderWidth = 0.8
    imageView.clipsToBounds = true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  lazy var currencyUILabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
    label.textColor = UIColor.lightGray
    return label
  }()
  
  lazy var currencyCountryUILabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 18,weight: .regular)
    return label
  }()
  
  
  
}
