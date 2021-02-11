//
//  Die.swift
//  Yatzee
//
//  Created by App og Blog on 11/02/2021.
//

import Foundation

class Die: Codable {
    var dieNo: Int = 0
    var dieDots: Int = 0
    var stillRolling:Bool = true
    
    init(dieNo: Int, dieDots: Int){
        self.dieNo = dieNo
        self.dieDots = dieDots
        
    }
    
}
