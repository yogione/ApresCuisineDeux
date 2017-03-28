//
//  DishItemTableViewCell.swift
//  ApresCuisine
//
//  Created by Srini Motheram on 3/27/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit

class DishItemTableViewCell: UITableViewCell {
    @IBOutlet var dishName     :UITextView!
    @IBOutlet var rating      :UITextView!
    @IBOutlet var reviewText      :UITextView!
    @IBOutlet var dateEaten     :UILabel!
    
    @IBOutlet var dishImageView :UIImageView!
}
