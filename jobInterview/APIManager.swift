//
//  APIManager.swift
//  jobInterview
//
//  Created by Tom Ben Ari on 28/11/2016.
//  Copyright © 2016 Tom Ben Ari. All rights reserved.
//

import UIKit
import Alamofire

private let ombdURL = "https://www.omdbapi.com/"

typealias SearchCompletion = (_ array : [Item]?, _ error : Error?) -> Void

class APIManager: NSObject {
    static let manager = APIManager()
    
    func omdb(search term : String, type : Item.itemType? = nil, page : Int = 1, completion : @escaping SearchCompletion ) {
        
        var params : [String:Any] = [:]
        
        params["s"] = term
        params["page"] = page
        if let type = type{
            params["type"] = type.rawValue
        }
        
        Alamofire.request(ombdURL, parameters: params).responseJSON { (response) in
            guard let json = response.result.value as? [String:Any]
                else{
                    //error
                    completion(nil, response.result.error)
                    return
            }
            
            let rowArray = json["Search"] as? [[String:Any]] ?? []
            var finelArray : [Item] = []
            
            for dict in rowArray{
                finelArray.append(Item(dict))
            }
            
            completion(finelArray, nil)
            
        }
        
    }
}
