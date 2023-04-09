//
//  ArrayExtension.swift
//  ToptanPiyasa
//
//  Created by Murat Emre Aygün on 24.10.2022.
//

import Foundation

extension Array
{
    func findFirst(predicate: (Element) -> Bool) -> Element?
    {
        let foundElements = self.filter(predicate)
        return foundElements.first
    }
}
