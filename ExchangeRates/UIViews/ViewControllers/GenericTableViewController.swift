//
//  GenericTableViewController.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 05/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//


import UIKit
class GenericTableViewController<T, Cell: UITableViewCell>: UITableViewController {
  
  var items: [T]
  var configure: (Cell, T) -> Void
  var selectHandler: (_ model:T, _ view: UITableViewController) -> Void
  var titleString : String!
  var cancelButton : Bool!
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  init(_title: String = "", showCancelButton: Bool = false, items: [T], configure: @escaping (Cell, T) -> Void, selectHandler: @escaping (T, UIViewController) -> Void) {
    self.titleString =  _title
    self.cancelButton = showCancelButton
    self.items = items
    self.configure = configure
    self.selectHandler = selectHandler
    super.init(style: .plain)
    self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    self.tableView.separatorStyle = .none
    self.tableView.showsVerticalScrollIndicator = false
    self.tableView.showsHorizontalScrollIndicator = false

  }
  
  
  override func viewDidLoad() {
    self.title = titleString
    self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.003921568627, green: 0.4588235294, blue: 0.9215686275, alpha: 1)
 
    
    if cancelButton {
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancel))
      self.navigationItem.leftBarButtonItem  = cancelButton
        
    }
     
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60.0
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
    let item = items[indexPath.row]
    configure(cell, item)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let item = items[indexPath.row]
    selectHandler(item, self)
  }
  
  @objc func cancel(){
    self.dismiss(animated: true, completion: nil)
  }
  
 
  
  
}



