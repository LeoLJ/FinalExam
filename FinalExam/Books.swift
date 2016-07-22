//
//  Books.swift
//  FinalExam
//
//  Created by Leo on 7/22/16.
//  Copyright © 2016 Leo. All rights reserved.
//

import UIKit

class Books: NSObject {
    
    var bookName: String?
    var bookSummary: String?
    var storeAddre: String?
    var storeWeb: String?
    var storeTel: String?
    var bookImage: UIImage?
    
    init(bookName: String?, bookSummary: String?, storeAddre: String?, storeWeb: String?, storeTel: String?, bookImage: UIImage?){
        
        self.bookName = bookName
        self.bookSummary = bookSummary
        self.storeAddre = storeAddre
        self.storeWeb = storeWeb
        self.storeTel = storeTel
        self.bookImage = bookImage
                
        }
    }