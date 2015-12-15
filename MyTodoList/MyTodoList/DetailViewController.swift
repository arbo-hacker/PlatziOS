//
//  DetailViewController.swift
//  MyTodoList
//
//  Created by Alejandro Barreto on 13/12/15.
//  Copyright © 2015 Arbo Corporation. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var item : TodoItem?
    var todoList : TodoList?
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
            self.item!.dueDate = date
            self.todoList?.saveItems()
            scheduleNotificaiton(item!.todo!, date: date)
            var volver : Bool = true
            API.save(item!, todoList: todoList!, responseBlock: { (error) -> Void in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if let err = error {
                        print(err)
                        volver = false
                        self.showError()
                    }
                })
            })
            if volver {
                self.navigationController?.popViewControllerAnimated(true)
            }
        }
    }
    func showError(){
        let alert = UIAlertController(title: "Oops", message: "No pudimos guardar tus cambios, revista tu conexion a internet", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default) { _ in
            self.navigationController?.popViewControllerAnimated(true)
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
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
        //self.imageView.hidden = self.datePicker.hidden
        //self.datePicker.hidden = !self.datePicker.hidden
        if self.datePicker.hidden{
            self.fadeInDatePicker()
        }else{
            self.fadeOutDatePicker()
        }
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
        showItem()
        
        registerGestureRecognizer()
        addRegisterGestureRecognizerToImage()
        // Do any additional setup after loading the view.
    }
    func addRegisterGestureRecognizerToImage(){
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.numberOfTapsRequired = 1 // numero de toques en la pantalla
        tapGestureRecognizer.numberOfTouchesRequired = 1 // numero de dedos en la pantalla
        tapGestureRecognizer.addTarget(self, action: "rotate")
        self.imageView.addGestureRecognizer(tapGestureRecognizer)
        self.imageView.userInteractionEnabled = true

    }
    func rotate(){
        let animation = CABasicAnimation()
        animation.keyPath = "transform.rotation.x" // or y or z
        animation.toValue = M_PI * 2.0
        animation.duration = 1
        animation.repeatCount = 2
        self.imageView.layer.addAnimation(animation, forKey: "rotateAnimation")
    }

    func showItem(){
        descriptionLabel.text = self.item!.todo
        if let date = self.item?.dueDate{
            let formatter = NSDateFormatter()
            formatter.dateFormat = DetailViewController.FORMAT_DATE
            dateLabel.text = formatter.stringFromDate(date)
        }
        if let img = item!.image {
            self.imageView.image = img
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: ANIMACIONES
    func fadeInDatePicker(){
        self.datePicker.alpha = 0
        self.datePicker.hidden = false
        UIView.animateWithDuration(1){ () -> Void in
            self.datePicker.alpha = 1
            self.imageView.alpha = 0
        }
    }
    func fadeOutDatePicker(){
        self.datePicker.alpha = 1
        self.datePicker.hidden = false
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.datePicker.alpha = 0
            self.imageView.alpha = 1
            }) { (completed) -> Void in
                if completed {
                    self.datePicker.hidden = true
                }
        }
    }

}

extension DetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.imageView.image = image
            self.item!.image = image
            self.todoList!.saveItems()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
