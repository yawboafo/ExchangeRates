//
//  EmptyTableUIView.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 04/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit


protocol EmptyTableUIViewDelegate {
    func presentCurrencyRateView()
}


class EmptyTableUIView: UIView {

    var parentView: UIView = UIView()
    var delegate: EmptyTableUIViewDelegate!
  
  
  lazy var plusUIImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "plusImage"))
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  
  lazy var addCurrencyUIButton: UIButton = {
    let button = UIButton(type: .custom)
    button.setTitle("Add currency pair", for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.003921568627, green: 0.4588235294, blue: 0.9215686275, alpha: 1), for: .normal)
    button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .highlighted)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 20,weight: .medium)
    button.isUserInteractionEnabled = true
    button.addTarget(self, action: #selector(addCurrencyPair), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  lazy var messageTitleUILabel: UILabel = {
    let label = UILabel()
    label.text = "Choose a currency pair to compare their live rates"
    label.textColor = UIColor.lightGray
    label.numberOfLines = 0
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 17,weight: .thin)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  
  
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    init(parentView: UIView,frame: CGRect = .zero) {
        
        super.init(frame: parentView.frame)
        self.parentView = parentView
        setUpViews()
    }
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
          setUpViews()
      }
    func setUpViews(){
        addSubview(plusUIImageView)
        addSubview(addCurrencyUIButton)
        addSubview(messageTitleUILabel)
      
      
        plusUIImageView.topAnchor.constraint(equalTo: topAnchor,constant: self.frame.height / 3 ).isActive = true
        plusUIImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        plusUIImageView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        plusUIImageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        addCurrencyUIButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addCurrencyUIButton.topAnchor.constraint(equalTo: plusUIImageView.bottomAnchor,constant: 8).isActive = true
        
        messageTitleUILabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        messageTitleUILabel.topAnchor.constraint(equalTo: addCurrencyUIButton.bottomAnchor,constant: 5).isActive = true
        
        messageTitleUILabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 28).isActive = true
        messageTitleUILabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -28).isActive = true
      
        

    }
    @objc func addCurrencyPair() {
      
        guard let delegated = delegate else { return  }
        delegated.presentCurrencyRateView()
      
    }
    
}
