//
//  AddCurrencyPairViewController.swift
//  ExchangeRates
//
//  Created by Engineer 144 on 04/07/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

enum ReloadMode {
  case partial
  case full
  case none
}

class AddCurrencyPairViewController: UIViewController {
  
  @IBOutlet weak var addCurrencyRateTableView: UITableView!
  
   var reloadMode = ReloadMode.full
   var activeIndexPath : IndexPath!
   var currencyModel : CurrencyViewModel!
   var exchangeModel : ExChangeViewModel!
   var emptyTableView: EmptyTableUIView!
   var fistTime = true
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
    addCurrencyRateTableView.delegate = self
    addCurrencyRateTableView.dataSource = self
    
    emptyTableView = EmptyTableUIView(parentView: view)
    emptyTableView.delegate = self
    
    currencyModel = CurrencyViewModel()
    exchangeModel =  ExChangeViewModel()
    
    self.reloadMode = .full
     exchangeModel.update = {
      self.reloadLogic()
    }
    exchangeModel.errorNotify = { error in
      NotificationBanner(parentView: self, title: "Error", message: error ,bannerType: .error).show()
      }

    print("data source count : \(self.exchangeModel.xchangeRates.count)")
    print("number rows in section 1 = \(self.addCurrencyRateTableView.numberOfRows(inSection: 1)) : Number of rows in section 0 = \(self.addCurrencyRateTableView.numberOfRows(inSection: 0))")
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
     swipeHelp()
  }
  override func viewDidAppear(_ animated: Bool) {
   
    exchangeModel.infinityRateFetcher()
  }
  override func viewWillDisappear(_ animated: Bool) {
    guard let timer = exchangeModel.timer else { return  }
     timer.invalidate()
}
  func reloadLogic(){

  switch reloadMode {
  case .full:
    self.addCurrencyRateTableView.reloadData()
    break
  case .partial:
    self.smartTableviewReload()
    break
  case .none:
    break
  }
  self.showEmptyState()

  print("reload mode  : \(self.reloadMode)")
  print("data source count : \(self.exchangeModel.xchangeRates.count)")
    print("number rows in section 1 = \(self.addCurrencyRateTableView.numberOfRows(inSection: 1)) : Number of rows in section 0 = \(self.addCurrencyRateTableView.numberOfRows(inSection: 0))")
}
 
  func swipeHelp(){
  
    if fistTime == true && self.exchangeModel.xchangeRates.count > 0 {
      NotificationBanner(parentView: self, title: "Help", message: "Swipe to remove Paired Currency" ,bannerType: .success).show()
      self.fistTime = false
    }
    
  }
  
  }


extension AddCurrencyPairViewController: UITableViewDelegate,UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    return 2
    
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
  switch section {
  case 0:
    if self.exchangeModel.xchangeRates.count == 0 {
      return 0
    }else {
    return 1
    }
  case 1:
    
    if self.exchangeModel.xchangeRates.count == 0 {
      return 0
    }else {
      return exchangeModel.xchangeRates.count
    }
  default:
    return 0
  }
}
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section{
    case 1:
      let item = self.exchangeModel.xchangeRates[indexPath.item]
      let cell = tableView.dequeueReusableCell(withIdentifier: Constant.AddCurrencyPairCell_ID) as! AddCurrencyPairCell
      cell.amountCurrencyLabel.text =  item.firstPairlocalisedCurrencyCode
      cell.amountLabel.text = item.exchangeAmountwithCode
      cell.rateCurrencyLabel.text = item.secondPairlocalisedCurrencyCode
      cell.rateLabel.attributedText =  item.attributedRate
      return cell
    case 0 :
      let cell = (tableView.dequeueReusableCell(withIdentifier: Constant.AddCurrencyPairStaticCell_ID) as! AddCurrencyPairStaticCell)
       return cell
    default:
      let cell = UITableViewCell()
      return cell
    }
    
    
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      guard let timer = exchangeModel.timer else { return  }
      timer.invalidate()
      presentCurrencyRateView()
      break
      
    default: break
      
    }
    
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
  if editingStyle == .delete {
    print("Deleted")
    
    let item = self.exchangeModel.xchangeRates [indexPath.item]
    self.exchangeModel.pairsHandler = .delete
    self.reloadMode = .none
    self.exchangeModel.activeModel = item
  
    
    self.exchangeModel.xchangeRates.remove(at: indexPath.row)
   self.exchangeModel.repo.remove(pair: item.pairedValue)
    
    
    self.addCurrencyRateTableView.beginUpdates()
    
    if self.exchangeModel.xchangeRates.count == 0 {
      
    
      
     //   self.addCurrencyRateTableView.deleteSections(NSIndexSet(index: 0) as IndexSet, with: .fade)
      //self.addCurrencyRateTableView.deleteSections(NSIndexSet(index: indexPath.section) as IndexSet, with: .fade)
      print("Dead : number rows in section 1 = \(self.addCurrencyRateTableView.numberOfRows(inSection: 1)) : Number of rows in section 0 = \(self.addCurrencyRateTableView.numberOfRows(inSection: 0))")
    }else{
      let indexPath = IndexPath(item: indexPath.row, section: 1)
      self.addCurrencyRateTableView.deleteRows(at: [indexPath], with: .fade)
    }
    
   
  
    self.addCurrencyRateTableView.endUpdates()

  }
}
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
  if indexPath.section == 0 {
    return false
    }
  return true
}
  func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    
   
      self.activeIndexPath = indexPath
    if self.exchangeModel.xchangeRates.count == 0  {
      self.reloadMode = .none
    }else {
      self.reloadMode = .partial
    }

   
  }
  func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
    
    if self.exchangeModel.xchangeRates.count == 0  {
      self.reloadMode = .none
    }else {
      self.reloadMode = .full
   
    }
    
  }
  func showEmptyState(){
  if self.exchangeModel.xchangeRates.count == 0 {
    self.addCurrencyRateTableView.backgroundView = emptyTableView
  }else{
    self.addCurrencyRateTableView.backgroundView = nil
  }
}
  func smartTableviewReload(){
  
    let indexPaths = addCurrencyRateTableView.visibleCells
      .compactMap { addCurrencyRateTableView.indexPath(for: $0) }
      .filter { $0.section == 1 }
    
    
     var allVisible = indexPaths
    if activeIndexPath != nil {
      allVisible = indexPaths.filter { $0.row != activeIndexPath.row }
      self.addCurrencyRateTableView.reloadRows(at: allVisible, with: .none)
    }else {
      self.addCurrencyRateTableView.reloadRows(at: allVisible, with: .none)
  
    }
    
  }
  
}

extension AddCurrencyPairViewController : EmptyTableUIViewDelegate {
    func presentCurrencyRateView() {
      let naviController = UINavigationController()
      let first = firstCurrencyView(viewModel: currencyModel.currencyModelList())
      naviController.viewControllers = [first]
     self.present(naviController, animated: true, completion: nil)
      
      }
    func firstCurrencyView(viewModel: [CurrencyModel]) -> UIViewController {
      let viewController = GenericTableViewController(_title: "Select Currency", showCancelButton: true, items: viewModel, configure: { (cell: CurrencyCell, currency) in
        cell.currencyCountryUIImage.image = currency.image
        cell.currencyCountryUILabel.text = currency.name
        cell.currencyUILabel.text = currency.code
          }, selectHandler: { (currency,view) in
          self.exchangeModel.pair = currency.code
          view.navigationController?.pushViewController(self.secondCurrencyView(viewModel: self.currencyModel.currencyModelList()), animated: true)
          })
       return viewController
     }
    func secondCurrencyView(viewModel: [CurrencyModel]) -> UIViewController {
        
      let viewController = GenericTableViewController(_title: "Compare  \(self.exchangeModel.pair), to ",items: viewModel, configure: { (cell: CurrencyCell, currency) in
        cell.currencyCountryUIImage.image = currency.image
        cell.currencyCountryUILabel.text = currency.name
        cell.currencyUILabel.text = currency.code
        
        if self.exchangeModel.shouldDisable(_pair: currency.code) {
          
          cell.isUserInteractionEnabled = false
          cell.isUserInteractionEnabled = false
          cell.currencyUILabel.isEnabled = false
          cell.currencyCountryUILabel.isEnabled = false
          cell.currencyCountryUIImage.tintAdjustmentMode = .dimmed
          
        }else{
          cell.isUserInteractionEnabled = true
          cell.isUserInteractionEnabled = true
          cell.currencyUILabel.isEnabled = true
          cell.currencyCountryUILabel.isEnabled = true
          
        }
    
      }, selectHandler: { (currency,view) in
      
      self.exchangeModel.pair.append(currency.code)
      self.exchangeModel.pairsHandler = .update
      self.exchangeModel.repo.insert(pair: self.exchangeModel.pair)
     
        view.dismiss(animated: true, completion: nil)
    
      })
  
    return viewController
  
}
  
}
  

