//
//  WaterConsuptionAllRecords.swift
//  hydrationTracking
//
//  Created by Aniket Chintawar on 18/06/24.
//

import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var imgwater: UIImageView!
    @IBOutlet weak var lbltime: UILabel!
    @IBOutlet weak var lblwater: UILabel!
}

class WaterConsuptionAllRecords: UITableViewController {
     
    var sections: [String: [consuption]] = [:]
    @IBOutlet var tableData: UITableView!
    var sortedDates: [String] = []
    var consumptions: [consuption] = []
    var utiels = Utiles()
    var waterConsuptionVM = WaterConsuptionAllRecordsVM()
    var startDate : String = ""
    var endDate : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableData.dataSource = self
        tableData.delegate = self
        loadData()
        
    }
    
    func loadData() {
        consumptions = waterConsuptionVM.getAllRecords(MemberId: utiels.GetValueInUserDefault(key: "memberId"), StartDate: startDate, EndDate: endDate) ?? []
        for consumption in consumptions {
            let date = consumption.date
            if sections[date] == nil {
                sections[date] = []
                sortedDates.append(date)
            }
            sections[date]?.append(consumption)
        }
        sortedDates.sort()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = sortedDates[section]
        return sections[date]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedDates[section]
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        
        // Configure the cell...
        let date = sortedDates[indexPath.section]
        if let consumption = sections[date]?[indexPath.row] {
            cell.lbltime?.text = "\(consumption.time)"
            cell.lblwater?.text = "\(consumption.litre) 🥤"
        }
        
        return cell
    }
    
    // MARK: - Swipe actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, completionHandler) in
            self.handleEdit(at: indexPath)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue

        
        let configuration = UISwipeActionsConfiguration(actions: [editAction])
        return configuration
    }
    private func handleEdit(at indexPath: IndexPath) {
        let date = sortedDates[indexPath.section]
        if let consumption = sections[date]?[indexPath.row] {
            let alert = UIAlertController(title: "Edit Consumption", message: "Enter new value", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.text = consumption.litre
            }
            let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
                guard let self = self else { return }
                if let newValue = alert.textFields?.first?.text, !newValue.isEmpty {
                    self.updateConsumption(newValue: newValue, at: indexPath)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
    }
    
    private func updateConsumption(newValue: String, at indexPath: IndexPath) {
        let date = sortedDates[indexPath.section]
        if var consumption = sections[date]?[indexPath.row] {
            consumption.litre = newValue
            var result = waterConsuptionVM.UpdateData(cosumption: consumption)
            if result {
                
                sections[date]?[indexPath.row] = consumption
                if let overallIndex = consumptions.firstIndex(where: { $0.date == date && $0.time == consumption.time }) {
                    consumptions[overallIndex].litre = newValue
                }
                tableData.reloadData()
            }else{
                self.showAlert(title: "Error", message: "Record Not Updated")
            }
        }
    }
    
}
