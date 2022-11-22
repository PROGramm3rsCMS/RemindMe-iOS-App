//
//  CalenderViewController.swift
//  RemindMe
//
//  Created by Chaquira Moreno on 11/22/22.
//

import UIKit

class CalenderViewController: UIViewController {

    @IBOutlet weak var dateTF: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var taskTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())


        
        dateTF.inputView = datePicker
        dateTF.text = formatDate(date: Date())
    }
    
    @objc func dateChange(datePicker: UIDatePicker)
    {
        dateTF.text = formatDate(date: datePicker.date)
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy"
        return formatter.string(from: date)
    }
    
}
