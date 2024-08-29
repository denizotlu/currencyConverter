//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Deniz Otlu on 26.08.2024.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
    
 
    
    //var service = apiFetch()
    
    let label = UILabel()
    let textField = UITextField()
    let pickerView = UIPickerView()

    var currenyy: [String] = []
    var valuee: [Double] = []
    var activeCurreny = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        
        resultLabel()
        view.addSubview(label)

        textFieldFunc()
        view.addSubview(textField)
        textField.addTarget(self, action: #selector(updateViews), for: .editingChanged)

        pickerSettings()
        apiReq()
        
    }
    
    func resultLabel(){
        label.frame = CGRect(x: 200, y: 500, width: 200, height: 50)
        label.center = CGPoint(x: 200, y: 200)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "How Much USD?"
        label.textColor = .systemGray2
        label.backgroundColor = .white
    }
    
    func textFieldFunc(){
        textField.frame = CGRect(x: 200, y: 550, width: 285, height: 40)
        textField.center = CGPoint(x: 200, y: 550)
        textField.placeholder = " Enter Amount:"
        textField.backgroundColor = .lightText
        textField.layer.masksToBounds = false
        textField.layer.shadowRadius = 3
        textField.layer.shadowColor = UIColor.systemBackground.cgColor
        textField.layer.shadowOffset = CGSize(width: 0, height: 0)
        textField.layer.shadowOpacity = 1.0
        textField.borderStyle = .line
    }
    
    
    func pickerSettings(){
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
        pickerView.frame = CGRect(x: 0, y: 600, width: 400, height: 250)
        pickerView.backgroundColor = .systemGreen
        
    
    }
    
    @objc func updateViews(input: Double){
        guard let amountText = textField.text, let theAmountText = Double(amountText) else {return}
        if textField.text != "" {
            let total = theAmountText * activeCurreny
            label.text = String(format: "%.2f", total)
        }
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currenyy.count

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currenyy[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurreny = valuee[row]
        updateViews(input: activeCurreny)
    }
   
    
    func apiReq(){
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/4b03210806f8690668621f48/latest/USD") else{return}
        
        URLSession.shared.dataTask(with: url) { [self] data, response, error in
            if error != nil{
                print("error not nil")
                return
            }
            
            guard let safeData = data else {return}
            
            do{
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
     
               currenyy.append(contentsOf: results.self.conversionRates.keys)
               valuee.append(contentsOf: results.self.conversionRates.values)
                DispatchQueue.main.async {
                    self.pickerView.reloadAllComponents()
                }
            }catch{
                print("cath")
            }
        
        }.resume()
        
    }
    


}
#Preview{
    ViewController()
}
