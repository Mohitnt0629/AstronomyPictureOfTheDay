//
//  FavouriteListTV.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import UIKit


class FavouriteListTVDataSource: NSObject, UITableViewDataSource {
    
    //MARK: - IBOUTLET's
    private let arrFavList: [AstronomyDetailsModel]!
    
    //MARK: - INITIALIZER
    init(arr: [AstronomyDetailsModel]) { self.arrFavList = arr }
    
    //MARK: - UITableView DataSource Method
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFavList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteListTVC") as! FavouriteListTVC
        cell.setData(objAstronomyData: arrFavList[indexPath.row])
        return cell
    }
    
}
class FavouriteListTVDelegate: NSObject, UITableViewDelegate,UIScrollViewDelegate {
    
    //MARK: - UITableView Delegate Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 150
        return UITableView.automaticDimension
    }

}
