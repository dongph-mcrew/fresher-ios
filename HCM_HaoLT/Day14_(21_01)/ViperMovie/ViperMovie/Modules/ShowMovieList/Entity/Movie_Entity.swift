//
//  Movie_Entity.swift
//  ViperMovie
//
//  Created by Hao Lam on 1/20/22.
//

import UIKit

//struct MovieList_ResponseModel : Decodable {
//    //recieve raw data from api
//    var results: [Movie]?
//}


struct Movie : Codable {
    
    let userId: Int
    let id: Int
    let title: String
    let body: String

}
