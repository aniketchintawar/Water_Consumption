//
//  indexVC.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 19/06/24.
//

import UIKit

class indexVC: UIViewController {

    @IBOutlet weak var indexPageLog: UIImageView!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
       
    @IBOutlet weak var btnSearchRecords: UIButton!
    @IBOutlet weak var btnAddWaterdetails: UIButton!
    var datePicker: UIDatePicker?
    var activeTextField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()

           makeCircular(imageView: indexPageLog)
        
                datePicker = UIDatePicker()
                datePicker?.datePickerMode = .date
                datePicker?.preferredDatePickerStyle = .wheels
                datePicker?.backgroundColor = .white
                datePicker?.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
                
                // Add a toolbar with a done button
                let toolbar = UIToolbar()
                toolbar.sizeToFit()
                let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
                toolbar.setItems([doneButton], animated: true)
                
                // Set the date picker as the input view and toolbar as the input accessory view for both text fields
                startDateTextField.inputView = datePicker
                startDateTextField.inputAccessoryView = toolbar
                endDateTextField.inputView = datePicker
                endDateTextField.inputAccessoryView = toolbar
                
                // Add editing began listeners to the text fields to keep track of the active text field
                startDateTextField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)
                endDateTextField.addTarget(self, action: #selector(textFieldEditingDidBegin(_:)), for: .editingDidBegin)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        startDateTextField.text = getDateInDDMMYYYYFormat()
        endDateTextField.text = getDateInDDMMYYYYFormat()
    }
    @IBAction func addWaterConsuption(_ sender: Any) {
        btnAddWaterdetails.isEnabled = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailViewController = storyboard.instantiateViewController(withIdentifier: "AddWaterConsuptionDetails") as? AddWaterConsuptionDetails {
                    
                    self.navigationController?.pushViewController(detailViewController, animated: true)
                }
        btnAddWaterdetails.isEnabled = true
    }
    
    @IBAction func searchButton(_ sender: Any) {
        btnSearchRecords.isEnabled = false
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "WaterConsuptionAllRecords") as? WaterConsuptionAllRecords {
            vc.startDate = startDateTextField.text ?? getDateInDDMMYYYYFormat()
            vc.endDate = endDateTextField.text ?? getDateInDDMMYYYYFormat()
            btnSearchRecords.isEnabled = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    func getDateInDDMMYYYYFormat() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: currentDate)
    }
    
    
    @objc func textFieldEditingDidBegin(_ textField: UITextField) {
            activeTextField = textField
            // Optionally, set the date picker to the current date of the text field
            if let dateText = textField.text, let date = DateFormatter().date(from: dateText) {
                datePicker?.date = date
            }
        }
        
        @objc func dateChanged(_ sender: UIDatePicker) {
            // Format the date selected
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            formatter.dateFormat = "dd/MM/yyyy"
            
            // Update the active text field with the selected date
            activeTextField?.text = formatter.string(from: sender.date)
        }
        
        @objc func doneTapped() {
            // Dismiss the date picker
            activeTextField?.resignFirstResponder()
        }

    func makeCircular(imageView: UIImageView) {
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = UIColor.white.cgColor
        }
    

}
