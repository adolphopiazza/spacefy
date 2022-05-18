//
//  String+Ext.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 15/03/21.
//

import Foundation

extension String {
    
    func formatTo(date format: DateFormats) -> String {
        let df = DateFormatter()
        df.dateFormat = format.rawValue
        guard let date = df.date(from: self) else { return self }
        df.dateFormat = "MMM d yyyy, h:mm a"
        
        return df.string(from: date)
    }
    
}
