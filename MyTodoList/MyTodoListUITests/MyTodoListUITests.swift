//
//  MyTodoListUITests.swift
//  MyTodoListUITests
//
//  Created by Alejandro Barreto on 10/12/15.
//  Copyright © 2015 Arbo Corporation. All rights reserved.
//

import XCTest

class MyTodoListUITests: XCTestCase {
    
    //var app : XCUIApplication = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        //addTask(XCUIApplication())
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddTask(){
        let app = XCUIApplication()
        for _ in 1...20{
            let addTaskTextField = app.textFields["Add Task"]
            addTaskTextField.tap()
            let nombreTarea = randomId("comprar comida")
            addTaskTextField.typeText(nombreTarea)
            let boton = app.buttons["Save"]
            boton.tap()
        }
    }
    func testAgregarVariasTareas(){
        
        let app = XCUIApplication()
        let addTaskTextField = app.textFields["Add Task"]
        addTaskTextField.tap()
        addTaskTextField.typeText("hola")
        
        let saveButton = app.buttons["Save"]
        saveButton.tap()
        addTaskTextField.tap()
        addTaskTextField.typeText("como")
        saveButton.tap()
        addTaskTextField.tap()
        addTaskTextField.typeText("estas")
        saveButton.tap()
        addTaskTextField.tap()
        addTaskTextField.typeText("bien")
        saveButton.tap()
        addTaskTextField.tap()
        addTaskTextField.typeText("y")
        saveButton.tap()
        addTaskTextField.tap()
        addTaskTextField.typeText("tu")
        saveButton.tap()
        
    }
    
    func addTask(){
        print("HOLa")
    }
    
    func randomId(tarea: String ) -> String {
        let id = arc4random() % 20
        return "\(tarea) \(String(id))"
    }
    
}
