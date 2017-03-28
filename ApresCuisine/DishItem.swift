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
        @NSManaged var imageFileName    :String!
    
        @NSManaged var lat    :String!
        @NSManaged var long    :String!
    
        
    convenience init(dishname: String, rating: Int, review: String, imageFileName: String, lat: String, long: String){
            self.init()
            self.dishName = dishname
            self.dateEaten = NSDate() as Date
            self.rating = rating
            self.reviewText = review
            self.imageFileName = imageFileName
            self.lat = lat
            self.long = long
            
        }
        
    static func parseClassName() -> String {
        
            return "DishItem"
        }
        
    }


