//
//  HomeVM.swift
//  NasaAstronomy
//
//  Created by Mohit on 21/05/23.
//

import UIKit

class HomeVM {
    //MARK: - FETCH THE PICTURE OF THE DAY DATA
    func fatchData(date: String,view: UIViewController, completion:@escaping() -> Void) {
        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod?")!
        let parameters = [
            "api_key": NasaApiKey.apiKey,
            "date":date
        ]
        
        guard let url = baseURL.withQueries(parameters) else {
            CommonMethod.shared.showAlert(title: AppInfo.alertTitle, message: AppInfo.invalidUrl, view: view)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                CommonMethod.shared.showAlert(title: AppInfo.alertTitle, message: error.localizedDescription, view: view)
                return
            }
            
            guard let data = data else {
                CommonMethod.shared.showAlert(title: AppInfo.alertTitle, message: AppInfo.noData, view: view)
                return
            }
            
            do {
                if let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    let objAstronomyModel = AstronomyDetailsModel(
                        copyright: dictionary["copyright"] as? String ?? "",
                        date: dictionary["date"] as? String ?? "",
                        explanation: dictionary["explanation"] as? String ?? "",
                        hdurl: dictionary["hdurl"] as? String ?? "",
                        mediaType: dictionary["media_type"] as? String ?? "",
                        serviceVersion: dictionary["service_version"] as? String ?? "",
                        title: dictionary["title"] as? String ?? "",
                        url: dictionary["url"] as? String ?? ""
                    )
                    CoreData.shared.saveAstronomyDetailInDB(objAstronomyModel) {
                        completion()
                    }
                }
            } catch {
                CommonMethod.shared.showAlert(title: AppInfo.alertTitle, message: error.localizedDescription, view: view)
            }
        }
        
        task.resume()
    }
    
}
