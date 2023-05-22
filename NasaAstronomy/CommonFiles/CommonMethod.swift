//
//  WebServices.swift
//  NasaAstronomy
//
//  Created by Mohit on 19/05/23.
//

import UIKit


class CommonMethod {
    
    static var shared: CommonMethod {
        return CommonMethod()
    }
    
    fileprivate init() {}
    
    
    //MARK: - DOWNLOAD THE IMAGE FROM URL
    func getImageFromURL(url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }
    
    //MARK: - Get String From Date Method
    func getStringFromDate(date: Date,needFormat: String) -> String {
        var dateStr = String()
        if needFormat != "" {
            let formatter = DateFormatter()
            formatter.dateFormat = needFormat
            let locale = Locale.current
            formatter.locale = locale
            dateStr = formatter.string(from: date)
        }
        return dateStr
    }
    
    //MARK: - SHOW ALTER TITLE
    func showAlert(title: String, message: String, view: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: AppInfo.ok, style: .default) { _ in
        }
        alertController.addAction(okAction)
        view.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - ALERT WITH OKAY ACTION
    func alertMessageWithActionOk(title: String, message: String,view: UIViewController,action:@escaping ()->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: AppInfo.ok, style: .default) {  (result : UIAlertAction) -> Void in
            action()
        }
        alert.addAction(action)
        view.present(alert, animated: true, completion: nil)
    }
    
    
    
}

//MARK: - CREATE EXTENSION ADD QUERIES IN URL
extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
}

//MARK: - CREATE EXTENSION FOR GIVING RIGHT IMAGE TO TEXTFIELD
extension UITextField {
    func rightImage(image:UIImage,imgW:Int,imgH:Int)  {
        let iconView = UIImageView(frame: CGRect(x: 8, y: 0, width: imgW, height: imgW))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 8, y: 0, width: imgW + 8, height: imgW))
        iconContainerView.addSubview(iconView)
        rightView = iconContainerView
        rightViewMode = .always
    }
}
