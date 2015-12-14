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
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func dateSelected(sender: UIDatePicker) {
        dateLabel.text = formatDate(sender.date)
        toggleDatePicker()
    }
    @IBAction func addNotification(sender: UIBarButtonItem) {
        if let dateString = dateLabel.text, date = parseDate(dateString ) {
            scheduleNotificaiton(item!, date: date)
        }
    }
    func registerGestureRecognizer(){
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 1 // numero de toques en la pantalla
        tapGestureRecognizer.numberOfTouchesRequired = 1 // numero de dedos en la pantalla
        tapGestureRecognizer.addTarget(self, action: "toggleDatePicker")
        self.dateLabel.addGestureRecognizer(tapGestureRecognizer)
        self.dateLabel.userInteractionEnabled = true
    }
    func toggleDatePicker(){
        self.imageView.hidden = self.datePicker.hidden
        self.datePicker.hidden = !self.datePicker.hidden
    }
    @IBAction func addImage(sender: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .PhotoLibrary
        self.presentViewController(imagePickerController, animated: true, completion: nil)
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
        registerGestureRecognizer()
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

extension DetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = image
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
