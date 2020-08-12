//
//  WebError.swift
//  CAssignment
//
//  Copyright © 2020 Jai. All rights reserved.
//

import UIKit

public enum WebError: Error   {
   
    
    
    case noInternetConnection
    case custom(Error)
    case unauthorized
    case other
}
