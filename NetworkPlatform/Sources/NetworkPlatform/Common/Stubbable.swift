//
//  Stubbable.swift
//  
//
//  Created by Rokon Uddin on 11/17/22.
//

import Foundation

protocol Stubbable {
    
}

extension Stubbable {
    
    func stubbedResponse(_ filename: String) -> Data! {
        let bundlePath = Bundle.main.path(forResource: "Stub", ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let path = bundle?.path(forResource: filename, ofType: "json")
        return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
    }
    
}
