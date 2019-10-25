//
//  CleanValueExtension.swift
//  Auto Layout Calculator
//
//  Created by DKU on 12/07/2018.
//  Copyright © 2018 dku. All rights reserved.
//

import Foundation


extension Double {
    var cleanValue: String {
        return self.truncatingRemainder(dividingBy: 1)  == 0 ? String(format: "%.000f", self) : String(format: "%.6f" , self)
    }

}


