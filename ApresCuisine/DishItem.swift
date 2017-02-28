//
//  DishItem.swift
//  ApresCuisine
//
//  Created by Srini Motheram on 2/26/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import Foundation
import Parse

class DishItem:PFObject, PFSubclassing {
        
        @NSManaged var dishName         :String!
        @NSManaged var dateEaten          :Date?
        @NSManaged var rating       :Int
        @NSManaged var reviewText    :String!
    
        
    convenience init(dishname: String, rating: Int){
            self.init()
            self.dishName = dishname
            self.dateEaten = NSDate() as Date
            self.rating = rating
            self.reviewText = "not bad"
            
        }
        
        static func parseClassName() -> String {
            
            return "DishItem"
        }
        
    }


