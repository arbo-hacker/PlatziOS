//
//  TodoList.swift
//  MyTodoList
//
//  Created by Alejandro Barreto on 11/12/15.
//  Copyright © 2015 Arbo Corporation. All rights reserved.
//

import UIKit

class TodoList: NSObject {
    var items : [TodoItem] = []
    static let FILE_NAME = "todolist.plist"
    private var _fileURL : NSURL?
    
    override init() {
        super.init()
        loadItems()
    }
    
    private let fileURL : NSURL = {
        let fileManager = NSFileManager.defaultManager()
        let documentDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        let documentDirectoryURL = documentDirectoryURLs.first!
        return documentDirectoryURL.URLByAppendingPathComponent(TodoList.FILE_NAME)
    }()
    
    private var fileURL2 : NSURL  {
        get{
            if let _url = _fileURL{
                return _url
            }else{
                let fileManager = NSFileManager.defaultManager()
                let documentDirectoryURLs = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
                
                let documentDirectoryURL = documentDirectoryURLs.first!
                _fileURL = documentDirectoryURL.URLByAppendingPathComponent(TodoList.FILE_NAME)
                return _fileURL!
            }
        }
    }
    
    func saveItems(){
        let itemArray = items as NSArray
        
        //if itemArray.writeToURL(fileURL2, atomically: true){
        if NSKeyedArchiver.archiveRootObject(itemArray, toFile: self.fileURL2.path!){
            print("Se guardo con existo")
        }else{
            print("No se pudo guardar de manera correcta")
        }
    }
    
    func loadItems(){
        if let itemArray = NSKeyedUnarchiver.unarchiveObjectWithFile(self.fileURL2.path!) as? [TodoItem]{ //NSArray(contentsOfURL: fileURL2) as? [String] {
            self.items = itemArray
        }
    }
    
    func addItem(item : TodoItem){
        items.append(item)
        saveItems()
    }
    
    func getItem ( index : Int ) -> TodoItem {
        return items[index]
    }

}

extension TodoList : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let item = items[indexPath.row]
        
        if let etiqueta = cell.textLabel {
            etiqueta.text = item.todo
        }
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        items.removeAtIndex(indexPath.row)
        saveItems()
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Middle)
        tableView.endUpdates()
    }
}