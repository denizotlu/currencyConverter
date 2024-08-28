//
//  File.swift
//  CurrencyConverter
//
//  Created by Deniz Otlu on 26.08.2024.
//

import Foundation
/*
class apiFetch{
    
    func apiReq(){
        
        guard let url = URL(string: "https://v6.exchangerate-api.com/v6/4b03210806f8690668621f48/latest/USD") else{return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil{
                print("error not nil")
                return
            }
            
            guard let safeData = data else {return}
            
            do{
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                print(results.conversionRates)
            }catch{
                print("cath")
            }
            
            
            
        }.resume()
        
    }
} */
