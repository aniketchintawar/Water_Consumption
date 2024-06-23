//
//  AddWaterConsuptionDetails.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 18/06/24.
//

import UIKit

class AddWaterConsuptionDetails: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txtTime: UITextField!
    @IBOutlet weak var waterConsuptionStack: UIView!
    @IBOutlet weak var addWaterCusmptionDetails: UIButton!
    @IBOutlet weak var txtwaterConsuption: UITextField!
    @IBOutlet weak var waterStack: UIStackView!
    var timePicker: UIDatePicker?
    var pickerView: UIPickerView!
    var waterConsumptionValues: [String] = []
    var ObjwaterCusuption = waterConsuptionHelper()
    let userDefaults = UserDefaults.standard
    var labelTitleArray = ["1", "2", "3", "4","5","6","7","8","9","10"];
    var viewModel: WaterConsumptionVM!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = WaterConsumptionVM()
        debugPrint("Data base url \(getDocumentsDirectory())")
        for i in stride(from: 0.5, through: 5.0, by: 0.5) {
                        let emoji = i <= 2.0 ? "🥤" : "🍾"
                        waterConsumptionValues.append(String(format: "%@ %.1f liters", emoji, i))
                    }
        setupTimePicker()
        setupWaterConsumptionPicker()
        addLabelsToStackView(labelTitleArray)
    }
    private func setupTimePicker() {
            timePicker = UIDatePicker()
            timePicker?.datePickerMode = .time
            timePicker?.preferredDatePickerStyle = .wheels
            timePicker?.backgroundColor = .white
            timePicker?.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
            toolbar.setItems([doneButton], animated: true)
            
            txtTime.inputView = timePicker
            txtTime.inputAccessoryView = toolbar
            
            let currentTime = Date()
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            txtTime.text = formatter.string(from: currentTime)
        }
        
        private func setupWaterConsumptionPicker() {
            pickerView = UIPickerView()
            pickerView.delegate = self
            pickerView.dataSource = self
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped1))
            toolbar.setItems([doneButton], animated: true)
            
            txtwaterConsuption.inputView = pickerView
            txtwaterConsuption.inputAccessoryView = toolbar
        }
    @objc func timeChanged(_ sender: UIDatePicker) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            txtTime.text = formatter.string(from: sender.date)
        }
        
        @objc func doneTapped() {
            txtTime.resignFirstResponder()
        }
        
        @objc func doneTapped1() {
            txtwaterConsuption.resignFirstResponder()
        }
        

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

   
    @IBAction func SaveDetailsButton(_ sender: Any) {
        addWaterCusmptionDetails.isEnabled = false
        viewModel.saveDetails(txtTime: txtTime.text, txtWaterConsuption: txtwaterConsuption.text)
        self.showAlert(title: "Saved", message: "Record Updated Sucessfully")
        addWaterCusmptionDetails.isEnabled = true
    }
       
    
    func addLabelsToStackView(_ texts: [String]) {
        var waterCosuptionCount = viewModel.getwaterConsuptionDetails()
            for text in texts {
                let label = UILabel()
                label.textAlignment = .center
                if Double(text)! < waterCosuptionCount {
                    label.backgroundColor = .link
                    label.text = text
                    
                }else
                {
                    label.backgroundColor = .white
                }
                label.translatesAutoresizingMaskIntoConstraints = false
                
                // Add label to the stack view
                waterStack.addArrangedSubview(label)
                
                // Optionally add height constraint
                NSLayoutConstraint.activate([
                    label.heightAnchor.constraint(equalToConstant: 40)
                ])
            }
        }
    

}
extension AddWaterConsuptionDetails{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return waterConsumptionValues.count
        }
        
        // MARK: - UIPickerViewDelegate methods
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return waterConsumptionValues[row]
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            // Update the text field with the selected value
            txtwaterConsuption.text = waterConsumptionValues[row]
        }
}
