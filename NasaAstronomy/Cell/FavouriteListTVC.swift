//
//  FavouriteListTVC.swift
//  NasaAstronomy
//
//  Created by Mohit on 19/05/23.
//

import UIKit

class FavouriteListTVC: UITableViewCell {
    
    //MARK: - IBOUTLET'S
    @IBOutlet weak var imgVW: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblExplanation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: - SET DATA
    func setData(objAstronomyData: AstronomyDetailsModel) {
        if let imageUrl = URL(string: objAstronomyData.url ) {
            CommonMethod.shared.getImageFromURL(url: imageUrl) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.imgVW.image = image
                    }
                } else {
                    print("Error downloading image.")
                }
            }
        }
        lblTitle.text = objAstronomyData.title
        lblDate.text = objAstronomyData.date
        lblExplanation.text = objAstronomyData.explanation
    }
    
}
