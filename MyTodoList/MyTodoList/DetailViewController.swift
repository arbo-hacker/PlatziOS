//
//  DetailViewController.swift
//  MyTodoList
//
//  Created by Alejandro Barreto on 13/12/15.
//  Copyright © 2015 Arbo Corporation. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item : String? = ""
    static let FORMAT_DATE = "dd/MM/yyyy HH:mm"

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBAction func dateSelected(sender: UIDatePicker) {
        dateLabel.text = formatDate(sender.date)
    }
    @IBAction func addNotification(sender: UIBarButtonItem) {
        if let dateString = dateLabel.text, date = parseDate(dateString ) {
            scheduleNotificaiton(item!, date: date)
        }
    }
    
    @IBAction func addImage(sender: UIBarButtonItem) {
    }
    func scheduleNotificaiton(message: String, date: NSDate) {
        let localNotification = UILocalNotification()
        localNotification.fireDate = date
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        localNotification.alertTitle = "Recuerda esta tarea:"
        localNotification.alertBody = message
        localNotification.applicationIconBadgeNumber = 1
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func formatDate(date: NSDate) -> String{
        let formatter = NSDateFormatter()
        formatter.dateFormat = DetailViewController.FORMAT_DATE
        return formatter.stringFromDate(date)
    }
    
    
    
    func parseDate(date: String) -> NSDate? {
        let parser = NSDateFormatter()
        parser.dateFormat = DetailViewController.FORMAT_DATE
        return parser.dateFromString(date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = item
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
