//
//  String+Ext.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 15/03/21.
//

import Foundation

extension String {
    
    var formatToBRLDate: String {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000'Z"
        guard let date = df.date(from: self) else { return self }
        df.dateFormat = "MMM d yyyy, h:mm a"
        
        return df.string(from: date)
    }
    
}
