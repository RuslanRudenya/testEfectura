//
//  NetworkService.swift
//  TestEfectura
//
//  Created by Руслан on 06.12.2017.
//  Copyright © 2017 Руслан. All rights reserved.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    
    public func getData(completion: @escaping(Weather) ->()) {
        guard let url = URL(string: "http://api.apixu.com/v1/current.json?key=cd5b28ccd38c4adc8c983922170612&q=53.8686151049079,27.6016933058439") else {return}
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}
            do {
                let decoded = try JSONDecoder().decode(Weather.self, from: data)
                DispatchQueue.main.async {
                    completion(decoded)
                }
            } catch {
                print(error.localizedDescription)
            }
            }.resume()
    }
}
