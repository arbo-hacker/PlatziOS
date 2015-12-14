//
//  ViewController.swift
//  MyTodoList
//
//  Created by Alejandro Barreto on 10/12/15.
//  Copyright © 2015 Arbo Corporation. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var itemTextFiled : UITextField!
    @IBOutlet weak var tableView : UITableView!
    
    let todoList = TodoList()
    static let MAX_TEXT_SIZE = 35
    
    var selectedItem : String = ""
    
    @IBAction func addButtonPressed(sender: UIButton){
        if let item = itemTextFiled.text{
            print("Agregando un elemento a la lista: \(item)")
            todoList.addItem(item)
            itemTextFiled.text = ""
            tableView.reloadData()
            itemTextFiled!.resignFirstResponder()
        }else {
            print("No escribio ningun item")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.dataSource = todoList
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let detailViewController = segue.destinationViewController as? DetailViewController {
            detailViewController.item = self.selectedItem
        }
    }

    //MARK: Metodos del TextField Delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if let tareaString = textField.text as? NSString {
            let updateString = tareaString.stringByReplacingCharactersInRange(range, withString: string )
            return updateString.characters.count <= ViewController.MAX_TEXT_SIZE
        }else {
            return true
        }
        
    }
    
}

extension ViewController : UITableViewDelegate{
    //MARK: Metodos del tableView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        itemTextFiled!.resignFirstResponder()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedItem = todoList.getItem(indexPath.row)
        performSegueWithIdentifier("showItem", sender: self)
        
        /*
        let detailVC = DetailViewController()
        detailVC.item = selectedItem
        navigationController?.pushViewController(detailVC, animated: true)
        */
    }
}

