//
//  Post.swift
//  InformationJsonApp
//
//  Created by  Łukasz Wojtarowicz on 19.02.2018.
//  Copyright © 2018  Łukasz Wojtarowicz. All rights reserved.
//

import Foundation

struct Post: Decodable{
    let  userId: Int
    let id: Int
    let title: String
    let body: String
}
