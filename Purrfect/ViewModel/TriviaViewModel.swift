//
//  TriviaViewModel.swift
//  tableview
//
//  Created by Caecario Wardana on 29/9/19.
//  Copyright © 2019 Vineet Bugtani. All rights reserved.
//

import Foundation

struct TriviaViewModel {
    
    let model = Trivia()
    
    func getTriviaArray() -> [String] {
        return model.triviaArray
    }
}
