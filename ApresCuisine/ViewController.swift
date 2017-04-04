//
//  ViewController.swift
//  ApresCuisine
//
//  Created by Srini Motheram on 2/26/17.
//  Copyright © 2017 Srini Motheram. All rights reserved.
//

import UIKit
import AVFoundation
import Parse

class ViewController: UIViewController {
    
    @IBOutlet var dishNameTextField    :UITextField!
    @IBOutlet var ratingTextField     :UITextField!
    @IBOutlet var reviewTextField       :UITextField!
    
    @IBOutlet var dishTableView         :UITableView!
    
    var dishArray = [DishItem]()
    var selectedDish    :DishItem?
    
    func fetchToDos(){
        let query = PFQuery(className: "DishItem")
        query.limit = 1000
        query.order(byAscending: "dishName")
        query.order(byDescending: "rating")
        query.findObjectsInBackground { (results, error) in
            if let error = error {
                print ("got error\(error.localizedDescription)")
                
            } else {
                self.dishArray = results as! [DishItem]
                print("count: \(self.dishArray.count)")
                self.dishTableView.reloadData()
                
            }
        }
        
    }
    
    @IBAction func fetchToDosPressed(button: UIBarButtonItem){
        
        fetchToDos()
    }
    
    
    //MARK: - TEST METHODS
    func testParse(){
        let testObject = PFObject(className: "TestObject")
        testObject["foo"] = "bar"
        testObject.saveInBackground { (success, error) in
            print("obj was saved")
        }
    }
    
   /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEdit" {
            let indexPath = dishTableView.indexPathForSelectedRow!
            let currentDish = dishArray[indexPath.row]
            let destVC = segue.destination as! DetailViewController
            destVC.selectedDish = currentDish
            dishTableView.deselectRow(at: indexPath, animated: true)
        }
        
    }*/
    
    //MARK: - Interactivity Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToEdit" {
        let indexPath = dishTableView.indexPathForSelectedRow!
        let currentDish = dishArray[indexPath.row]
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.selectedDish = currentDish
        dishTableView.deselectRow(at: indexPath, animated: true)
        }
    } 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //testParse()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    //MARK :- Table View Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DishItemTableViewCell
        let currentDishItem = dishArray[indexPath.row]
        cell.dishNameLabel.text = currentDishItem.dishName
        cell.ratingLabel.text = "\(currentDishItem.rating)"
        cell.reviewTextLabel.text = currentDishItem.reviewText
        cell.dateEatenLabel.text = "\(currentDishItem.dateEaten!)"
        
        return cell
    }
    
    /* func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedDish = dishArray[indexPath.row]
        dishNameTextField.text = selectedDish!.dishName
        ratingTextField.text = "\(selectedDish!.rating)"
        
        print("Row: \(indexPath.row) \(currentMuseumItem.museumName)")
    } */
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("About to delte")
            let todoToDelete = dishArray[indexPath.row]
            todoToDelete.deleteInBackground(block: { (success, error) in
                print("deleted")
                self.fetchToDos()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
}
