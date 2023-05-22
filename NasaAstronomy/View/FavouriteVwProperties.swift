//
//  FavouriteVwProperties.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import UIKit

class FavouriteVwProperties: UIView {
    
    //MARK: - IBOUTLET
    @IBOutlet weak private var fvrtTV: UITableView!
    
    //MARK: - OBJECT OF TABLE DATA SOURCE AND DELEGATE
    private var objFavouriteListTVDataSource: FavouriteListTVDataSource!,
        objFavouriteListTVDelegate: FavouriteListTVDelegate!
    
    //MARK: - RELOAD THE TABLE DATA
    func reloadTableData(arrList: [AstronomyDetailsModel]) {
        objFavouriteListTVDataSource = FavouriteListTVDataSource(arr: arrList)
        fvrtTV.delegate = objFavouriteListTVDelegate
        fvrtTV.dataSource = objFavouriteListTVDataSource
        fvrtTV.reloadData()
    }
    
}
