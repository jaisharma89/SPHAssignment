//
//  VolumeDataModal.swift
//  SPHAssignment
//
//  Created by Optimum  on 11/8/20.
//  Copyright © 2020 Jai. All rights reserved.
//

import UIKit

class VolumeDataModal: NSObject {
    
    var year : String
    var totalVolume : Double
    var q1Data : Double
    var q2Data : Double
    var q3Data : Double
    var q4Data : Double
    var isDrop = false
    required init? ( year : String , q1Data : String , q2Data : String , q3Data : String , q4Data : String)
    {
        
        self.year = year
        self.q1Data = Double(q1Data) ?? 0.0
        self.q2Data = Double(q2Data) ?? 0.0
        self.q3Data = Double(q3Data) ?? 0.0
        self.q4Data = Double(q4Data) ?? 0.0
        self.totalVolume = self.q1Data + self.q2Data + self.q3Data + self.q4Data
       
        if q1Data > q2Data || q2Data > q3Data || q3Data > q4Data
        {
            isDrop = true
        }
        
    }
    
}
