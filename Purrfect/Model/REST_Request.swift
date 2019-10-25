//
//  REST_Request.swift
//  tableview
//
//  Created by Caecario Wardana on 27/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import Foundation

protocol Refresh {
    func updateUI()
}

class REST_Request {
    
    // Enables this class to send the data off somewhere after getting it
    var delegate: Refresh?
    
    var selectedBreedInfo = BreedInformation()
    
    // Swift API using singleton pattern as we only need one instance throughout the lifetime of the app
    // An object to make network/REST requests
    private let session = URLSession.shared
    
    // Convenience properties to helps us build the url
    private let base_url: String = "https://api.thecatapi.com/v1/images/search?"
    private let paramBreed: String = "breed_ids="
    
    
    // Functions that can be called by the ViewModel
    func getBreedInformation(withBreedID: String) {
        let url = base_url + paramBreed + withBreedID
        
        // Turn the above url into a valid url. If not, terminate early
        guard let escapedAddress = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            return
        }
        
        // Get Swift to create a URL object with the above url string
        if let url = URL(string: escapedAddress) {
            
            // This Swift API makes the network request
            let request = URLRequest(url: url)
            getData(request, element: "breeds")
        }
    }
    
    // This function executes the request and gets the data
    private func getData(_ request: URLRequest, element: String) {
        
        // Create the data task
        let task = session.dataTask(with: request, completionHandler: {data, response, downloadError in
            
            // Check if some kind of error comes back - print the error if something's gone wrong with the url request
            if let error = downloadError {
                print(error)
            } else {
                // If error does not occur
                // Create a variable into which we will pass the data response and try and convert using swift back to the data type we can use within swift
                var parsedResult: Any! = nil
                
                do {
                    
                    // Allows the Swift API to deal with a JSON response (both Array & Dictionary)
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                    
                } catch {print()}
                
                var breed: [[String: Any]] = [[:]]
                
                // Create variables to hold values we want to extract from JSON response
              let results = parsedResult as! [[String: Any]]
                
                // Unwrap JSON response to get the breed object containing dictionary
                for result in results {
                    breed = result["breeds"] as! [[String: Any]]
                }
                
                // Unwrap further and extract required elements from breed dictionary
                // Set elements into convenience variables
                for result in breed {
                    self.selectedBreedInfo.description = result["description"] as? String
                    self.selectedBreedInfo.origin = result["origin"] as? String
                    self.selectedBreedInfo.temperament = result["temperament"] as? String
                    self.selectedBreedInfo.lifeSpan = result["life_span"] as? String
                    
                }
                
                // Extract URL for image
                for result in results {
                    self.selectedBreedInfo.imageURL = result["url"] as? String
                }
                
                DispatchQueue.main.async {
                    // Update the UI
                    self.delegate?.updateUI()
                }
            }
        })
        
        task.resume()
    }
    
    private init(){}
    static let shared = REST_Request()
    
}
