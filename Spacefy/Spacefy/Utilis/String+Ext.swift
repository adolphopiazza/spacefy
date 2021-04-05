//
//  String+Ext.swift
//  Spacefy
//
//  Created by Adolpho Piazza on 15/03/21.
//

import Foundation

extension String {
    
    var formatToNewsDate: String {
        let df = DateFormatter()
        df.dateFormat = DateFormats.newsFormat
        guard let date = df.date(from: self) else { return self }
        df.dateFormat = "MMM d yyyy, h:mm a"
        
        return df.string(from: date)
    }
    
    var formatToLaunchesDate: String {
        let df = DateFormatter()
        df.dateFormat = DateFormats.launchesFormat
        guard let date = df.date(from: self) else { return self }
        df.dateFormat = "MMM d yyyy, h:mm a"
        
        return df.string(from: date)
    }
    
}
