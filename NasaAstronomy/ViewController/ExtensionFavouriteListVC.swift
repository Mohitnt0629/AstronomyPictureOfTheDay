//
//  ExtensionFavouriteListVC.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import Foundation

extension FavouriteListVC {
    
    //MARK: - CALL API FOR GET DATA
    func callApiMethod(date: String) {
        CoreData.shared.getAstronomyListMethod() { astronomyListArr in
            
        }
    }
}
