//
//  ViewController.swift
//  NasaAstronomy
//
//  Created by Mohit on 19/05/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: - IBOUTLET OF HOME VIEW PROPERTIES
    @IBOutlet var baseVwProperties: HomeViewProperties!
    
    //MARK: - CREATE OBJECT OF VIEW MODEL
    var objHomeVM = HomeVM()
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseVwProperties.delegateMethod = self
        self.checkConnection(date: CommonMethod.shared.getStringFromDate(date: Date(), needFormat: DateFormate.yymmdd))
        
    }
}

