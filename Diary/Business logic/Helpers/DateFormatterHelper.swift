//
//  DateFormatterHelper.swift
//  Diary
//
//  Created by Карим Садыков on 23.04.2023.
//

import Foundation

final class DateFormatterHelper {
    static var shortDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()

    static var mainDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "H:mm"
        return dateFormatter
    }()
}
