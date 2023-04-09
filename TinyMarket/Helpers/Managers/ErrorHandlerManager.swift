//
//  ErrorHandlerManager.swift
//  TinyMarket
//
//  Created by Onur Sır on 07.04.2023.
//
import Foundation

open class ErrorModel
{
    var description: String = "Bir Hata Oluştu"
    
    init(error: Error?)
    {
        if let error = error
        {
            self.description = error.localizedDescription
        }
    }
}
