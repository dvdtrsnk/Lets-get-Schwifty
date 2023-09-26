//
//  String+SlashIfEmpty.swift
//  RickAndMorty-DTxAckee
//
//  Created by David Tresnak
//

import Foundation

extension String {
    func slashIfEmpty() -> String {
        if self.isEmpty {
            return "-"
        } else {
            return self
        }
    }
}
