//
//  FavouriteListViewController.swift
//  NasaAstronomy
//
//  Created by Mohit on 19/05/23.
//

import UIKit

class FavouriteListVC: UIViewController {

    //MARK: - IBOUTLETS
    @IBOutlet var baseVwProperties: FavouriteVwProperties!
    
    //MARK: - VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CoreData.shared.getAstronomyListMethod() { astronomyListArr in
            self.baseVwProperties.reloadTableData(arrList: astronomyListArr.filter({$0.favourite}))
        }
    }
}
