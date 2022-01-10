//
//  String+Ext.swift
//  My Next Meal
//
//  Created by Antonio Vega on 1/7/22.
//

extension String {
    func isEmtpyWithBraces() -> Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
