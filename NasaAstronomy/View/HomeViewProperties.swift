//
//  HomeViewProperties.swift
//  NasaAstronomy
//
//  Created by Mohit on 19/05/23.
//

import UIKit

//MARK: - HOME DELEGATE METHODE
protocol HomeVwDelegateMethod {
    func changeDate(date: String)
    func favDetail(date: String,isFav: Bool)
}

class HomeViewProperties: UIView {
    
    //MARK: - IBOUTLET'S
    @IBOutlet weak private var tfDate: UITextField!
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var imgViewAstro: UIImageView!
    @IBOutlet weak private var lblExplanation: UILabel!
    @IBOutlet weak private var btnFav: UIButton!
    
    //MARK:  - DATE PICKER OBJECT
    var datePicker = UIDatePicker(),
        delegateMethod: HomeVwDelegateMethod?
    
    override func awakeFromNib() {
        tfDate.delegate = self
        tfDate.rightImage(image: UIImage(named: "edit") ?? UIImage(), imgW: 10, imgH: 10)
        tfDate.text = CommonMethod.shared.getStringFromDate(date: Date(), needFormat: DateFormate.yyyyMmmDd)
        setToolbarDoneAction()
    }
    
    //MARK: - SET DONE BUTTON TOOLBAR ON TEXTFILED
    func setToolbarDoneAction() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        toolbar.items = [UIBarButtonItem.flexibleSpace(), doneButton]
        tfDate.inputAccessoryView = toolbar
    }
    //MARK: - DONE ACTION
    @objc private func doneButtonTapped() {
        // Handle the "Done" button tap event
        tfDate.resignFirstResponder() // Dismiss the keyboard
    }
    
    //MARK: - SET THE DATA IN UI
    func setData(_ data: AstronomyDetailsModel) {

        if let imageUrl = URL(string: data.url ) {
            CommonMethod.shared.getImageFromURL(url: imageUrl) { image in
                if let image = image {
                    DispatchQueue.main.async {
                        self.imgViewAstro.image = image
                    }
                } else {
                    print("Error downloading image.")
                }
            }
        }
        lblExplanation.text = data.explanation
        lblTitle.text = data.title
        btnFav.isSelected = data.favourite
    }
    
    //MARK: - IBACTION
    @IBAction func favAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegateMethod?.favDetail(date: CommonMethod.shared.getStringFromDate(date: datePicker.date, needFormat: DateFormate.yymmdd),isFav: sender.isSelected)
    }
    
}

extension HomeViewProperties: UITextFieldDelegate {
    //MARK: - UITEXTFILED DELEGATE
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == tfDate {
            datePicker.datePickerMode = .date
            let maxDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
            datePicker.maximumDate = maxDate
            
            let minDate = Calendar.current.date(byAdding: .day, value: 10, to: Date())
            datePicker.minimumDate = minDate
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = DateFormate.ddMmYyyy
            
            if  let date = dateFormatter.date(from: "\(self.tfDate.text ?? "")") {
                datePicker.date = date
            }
            
            if #available(iOS 13.4, *) {
                datePicker.preferredDatePickerStyle = .wheels
            }
            tfDate.inputView = datePicker
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        tfDate.text = CommonMethod.shared.getStringFromDate(date: datePicker.date, needFormat: DateFormate.yyyyMmmDd)
        delegateMethod?.changeDate(date: CommonMethod.shared.getStringFromDate(date: datePicker.date, needFormat: DateFormate.yymmdd))
    }
}
