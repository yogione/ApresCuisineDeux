//
//  DetailViewController.swift
//  ApresCuisine
//
//  Created by Srini Motheram on 2/27/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {
    
    @IBOutlet var dishNameTextField    :UITextField!
    @IBOutlet var ratingTextField     :UITextField!
    @IBOutlet var reviewTextField       :UITextField!
    
     var selectedDish    :DishItem?
    
    //MARK: PARSE METHODS
    @IBAction func addToDo(button: UIButton){
        let dish = DishItem(dishname: dishNameTextField.text!, rating: Int(ratingTextField.text!)!)
        save(dish: dish)
    }
    
    @IBAction func updateToDo(button: UIButton){
        guard let dish = selectedDish else {
            return
        }
        dish.dishName = dishNameTextField.text!
        dish.rating = Int(ratingTextField.text!)!
        dish.reviewText = reviewTextField.text!
        
        save(dish: dish)
        
    }
    @IBAction func save(dish: DishItem){
        dish.saveInBackground { (success, error) in
            print("obj saved")
           // self.fetchToDos()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
}
