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

enum shouldAcceptReload {
  case yes
  case no
}

class AddCurrencyPairViewController: UIViewController {
  
  @IBOutlet weak var addCurrencyRateTableView: UITableView!
  

   var reload = shouldAcceptReload.yes
   var reloadMode = ReloadMode.full
   var activeIndexPath : IndexPath!
   var currencyModel : CurrencyViewModel!
   var exchangeModel : ExChangeViewModel!
   var emptyTableView: EmptyTableUIView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
      addCurrencyRateTableView.delegate = self
      addCurrencyRateTableView.dataSource = self
     
      emptyTableView = EmptyTableUIView(parentView: view)
      emptyTableView.delegate = self
      
      
      currencyModel = CurrencyViewModel()
      exchangeModel =  ExChangeViewModel()
      
      self.reloadMode = .full
     // self.addCurrencyRateTableView.reloadData()
      //self.showEmptyState()
       exchangeModel.update = {
        print("reload mode \(self.reloadMode)")
        //self.addCurrencyRateTableView.reloadData()
      //  self.showEmptyState()
        self.reloadLogic()

       // self.addCurrencyRateTableView.reloadData()
       // self.showEmptyState()
      
    
        
        
       
        
       /** switch self.reload {
          case .yes :
          switch self.reloadMode {
          case .partial:
            self.smartTableviewReload()
          case .full:
            self.addCurrencyRateTableView.reloadData()
          }
           self.showEmptyState()
          break
        case .no :   self.smartTableviewReload() ; self.showEmptyState()
          break
        }
        **/
      }
      
    
        exchangeModel.errorNotify = { error in
        NotificationBanner(parentView: self, title: "Error", message: error ,bannerType: .error).show()
        }
      
      
    
      
      
    }

  
  override func viewDidAppear(_ animated: Bool) {
       exchangeModel.infinityRateFetcher()
    
    self.addCurrencyRateTableView.setEditing(true, animated: true)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    exchangeModel.timer.invalidate()
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
  }
 
    
  }





extension AddCurrencyPairViewController: UITableViewDelegate,UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    if self.exchangeModel.xchangeRates.count == 0 {
      return 0
    }else{
      return 2
    }
    
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return 1
      
    }else if section == 0 && self.exchangeModel.xchangeRates.count == 0 {
      return 0
    }else{
      return self.exchangeModel.xchangeRates.count
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
      let cell = (tableView.dequeueReusableCell(withIdentifier: Constant.AddCurrencyPairStaticCell_ID) as! AddCurrencyPairStaticCell)
      return cell
    }
    
    
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.section {
    case 0:
      
      presentCurrencyRateView()
      
      break
      
    default: break
      
    }
    
  }
  
  
  /**func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let item = self.exchangeModel.xchangeRates [indexPath.item]
    
    let deleteAction = UITableViewRowAction(style: .default, title: "Swipe to delete", handler: { (action, indexPath) in
   
      main {
        tableView.beginUpdates()
        
        //self.exchangeModel.repo.remove(pair: item.pairedValue)
        self.exchangeModel.xchangeRates.remove(at: indexPath.row)
     
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.reloadData()
         tableView.endUpdates()
      }
     
    })
   
    deleteAction.backgroundColor = UIColor.red
   return [deleteAction]
  }**/
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      print("Deleted")
      
      let item = self.exchangeModel.xchangeRates [indexPath.item]
      self.exchangeModel.pairsHandler = .delete
      self.reloadMode = .none
      self.exchangeModel.repo.remove(pair: item.pairedValue)
      self.exchangeModel.xchangeRates.remove(at: indexPath.row)
      self.addCurrencyRateTableView.beginUpdates()
     // self.addCurrencyRateTableView.deleteRows(at: [indexPath], with: .automatic)
      let indexPath = IndexPath(item: indexPath.row, section: 1)
      self.addCurrencyRateTableView.deleteRows(at: [indexPath], with: .fade)
      self.addCurrencyRateTableView.endUpdates()
     //
     // tableView.endUpdates()
    }
  }
  
  


  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if indexPath.section == 0 {
      return false
      }
    return true
  }
  func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    
      self.reloadMode = .partial
      self.activeIndexPath = indexPath
    
      print(self.exchangeModel.xchangeRates.count)
   //   self.exchangeModel.timer.invalidate()
   
  }
  func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
     self.reloadMode = .full
     self.reload = .yes
    
    //self.exchangeModel.timer.fire()//
    
  }
  
  func showEmptyState(){
    if self.exchangeModel.xchangeRates.count == 0 {
      self.addCurrencyRateTableView.backgroundView = emptyTableView
    }else{
      self.addCurrencyRateTableView.backgroundView = nil
    }
  }
  func smartTableviewReload(){
    
    
    print("data source count : \(self.exchangeModel.xchangeRates.count)")
      print("data source count : \(self.addCurrencyRateTableView.numberOfRows(inSection: 1))")
    
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
      
      print("From Pair : \(self.exchangeModel.pair)")
      print("Pair : \(self.exchangeModel.pairs)")
        view.dismiss(animated: true, completion: nil)
    
      })
  
    return viewController
  
}
  
}
  

