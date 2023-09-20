//
//  PickerViewController.swift
//  NewsApp
//
//  Created by Tuba Nur  on 18.09.2023.
//

import UIKit



protocol PickerViewControllerDelegate {
    func didSelectContactType(_ type: String)
}

extension PickerViewControllerDelegate {
    func didSelectContactType(_ type: String) {}
}

class PickerViewController: UIViewController {
    let defaultLocalizer = LocalizeUtils.defaultLocalizer
    var list: [String] = ["en", "tr"]

    @IBOutlet weak var languagePicker: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    @IBOutlet weak var filterPickerView: UIPickerView!
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func onClickConfirmButton(_ sender: Any) {
        delegate?.didSelectContactType(selectedLanguage ?? "")
        dismiss(animated: true)
    }
    
    private var selectedLanguage: String?
    var delegate: PickerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterPickerView.delegate = self
        filterPickerView.dataSource = self
        selectedLanguage = list[0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let localizedCancel = defaultLocalizer.stringForKey(key:  "cancelButton")
        cancelButton.setTitle(localizedCancel, for: .normal)
        
        let localizedConfirm = defaultLocalizer.stringForKey(key:  "confirmButton")
        confirmButton.setTitle(localizedConfirm, for: .normal)
        languagePicker.text = defaultLocalizer.stringForKey(key:  "languagePicker")
    }
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = list[row]
    }
}


