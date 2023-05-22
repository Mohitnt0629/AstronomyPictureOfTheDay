//
//  ExtensionHomeVC.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import Foundation

extension HomeVC: HomeVwDelegateMethod {
    
    //MARK: - DELEGATE METHOD FOR CHANGE DATE
    func changeDate(date: String) {
        checkConnection(date: date)
    }
    
    //MARK: - CheckConnection
    func checkConnection(date: String) {
        if InternetConnection.isConnectedToNetwork() {
            callApiMethod(date: date)
        } else {
            CommonMethod.shared.alertMessageWithActionOk(title: AppInfo.alertTitle, message: AppInfo.noInternet, view: self) {
                self.setData(date: date)
            }
        }
    }
    
    //MARK: - DELEGATE METHOD FOR FAVOURITE POD
    func favDetail(date: String, isFav: Bool) {
        CoreData.shared.updateAstrononyDetailInDB(date,favourite: isFav) {
            
        }
    }
    //MARK: - CALL API FOR GET DATA
    func callApiMethod(date: String) {
        objHomeVM.fatchData(date: date, view: self) {
            self.setData(date: date)
        }
    }
    
    //MARK: - SET DATA
    func setData(date: String) {
        CoreData.shared.getAstronomyListMethod() { astronomyListArr in
            DispatchQueue.main.async {
                self.baseVwProperties.setData(astronomyListArr.filter({$0.date == date}).first ?? AstronomyDetailsModel())
            }
        }
    }
    
}
