//
//  SelectCityViewController.swift
//  Weather App
//
//  Created by V L S RAVI on 15/05/21.
//

import UIKit

protocol SelectCityDelegate {
    
    func citySelected(name : String)
    
}

class SelectCityViewController: UIViewController {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getWeatherBtn: UIButton!
    
    var delegate : SelectCityDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
        
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let city : String = cityTextField.text!
        delegate?.citySelected(name: city)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
