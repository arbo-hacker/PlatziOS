//
//  API.swift
//  MyTodoList
//
//  Created by Alejandro Barreto on 14/12/15.
//  Copyright © 2015 Arbo Corporation. All rights reserved.
//

import UIKit

class API{
    
    class func uniqueUserName() -> String{
        if let username = NSUserDefaults.standardUserDefaults().objectForKey("username") as? String{
            return username
        }else{
            let newUsername = generateUsername()
            NSUserDefaults.standardUserDefaults().setObject(newUsername, forKey: "username")
            return newUsername
        }
    }
    class func generateUsername() -> String{
        let uuid = NSUUID().UUIDString as? NSString
        return uuid!.substringToIndex(5)
    }
    
    
    class func save(item: TodoItem, todoList: TodoList, responseBlock: (NSError?) -> Void ) {
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: "https://pendientesapp.herokuapp.com/todo")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        var dictionary: Dictionary<String, AnyObject> = ["message": item.todo!, "user": self.uniqueUserName()]
        if let date = item.dueDate {
            let formatter = NSDateFormatter()
            formatter.dateFormat = DetailViewController.FORMAT_DATE
            dictionary["dueDate"] = formatter.stringFromDate(date)
        }
        if let identifier = item.id {
            dictionary["id"] = NSNumber(longLong: identifier)
        }
        let data = try! NSJSONSerialization.dataWithJSONObject(dictionary, options: .PrettyPrinted)
        request.HTTPBody = data
        
        
        let task = session.dataTaskWithRequest(request){
            (data, response, error) -> Void in
            if let err = error {
                responseBlock(err)
            }else{
                if let d = data {
                    let result = try! NSJSONSerialization.JSONObjectWithData(d, options: .AllowFragments)
                    print("Response: \(result)")
                    if let id = result["id"] as? Int64{
                        item.id = id
                        todoList.saveItems()
                    }
                }
            }
        }
        task.resume()
    }
    
}