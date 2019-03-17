//
//  ChartData.swift
//  Telegram_charts
//
//  Created by Zherdeva Elena on 15/03/2019.
//  Copyright © 2019 Zherdeva Elena. All rights reserved.
//

import Foundation

typealias Strings = [String: String]
typealias Columns = [String: [Int]]

struct ChartData {
    let colors: Strings
    let columns: Columns
    let names: Strings
    let types: Strings
}

extension ChartData: Codable {
    init(from decoder: Decoder) throws {
        let meta = try decoder.container(keyedBy: CodingKeys.self)
        colors = try meta.decode(Strings.self, forKey: .colors)
        names = try meta.decode(Strings.self, forKey: .names)
        types = try meta.decode(Strings.self, forKey: .types)
        
        var columnsMeta = try meta.nestedUnkeyedContainer(forKey: .columns)
        var columns = Columns()
        
        while !columnsMeta.isAtEnd {
            var columnContainer = try columnsMeta.nestedUnkeyedContainer()
            let name = try columnContainer.decode(String.self)
            columns[name] = [Int]()
        
            while !columnContainer.isAtEnd {
                columns[name]?.append(try columnContainer.decode(Int.self))
            }
        }
        self.columns = columns
    }
}



