//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let cadena: String = "Mi Ca\u{301}dena"
let cadena2 = "Mi Cádena"

cadena.characters.count
cadena2.characters.count

cadena.unicodeScalars.count
cadena2.unicodeScalars.count

for index in cadena.characters.indices {
    print("\(cadena[index])", terminator: "")
}

if cadena == cadena2 {
    print("\nSon iguales")
}

print("El valor maximo de Int8 es \(Int8.max)")

let y: Int8 = 120
// let z = y + 10 // da error porque hace overflow

let z = y &+ 10 // hace la suma hasta donde pueda, perdiendose datos en el camino

let d1  = 1.1
let d2: Double = 1.1
let f1: Float = 100.3

print("d1 + 0.1 es \(d1 + 0.1)")

if d1 + 0.1 == 1.2  {
    print("son iguales")
}

let codigoError1 = (404 , "Not found")
let codigoError2 = (codigo: 404, descripcion: "Not found")
codigoError2.descripcion

// pattern machine
let (codigo , _) = codigoError2
codigo

for i in 1...3{ //rango
    print(i)
}

for i in 1..<3{
    print(i)
}

print("\ncomienzafor")
var unNumero = 1
for var i = 1 ; i < 5 ; ++i{
    unNumero *= i
    print(unNumero)
}

var bandera = 1
while bandera == 0 {
    print ("hola")
}

var multiplica = 1
unNumero = 1

repeat {
print ("hola")
multiplica += 1
} while multiplica <= 3

let personaje = "Lobo Estepario"
switch personaje {
    case "Caballero":
    print ("El personaje \(personaje) es un Caballero")
    case "Mago":
        print ("El personaje \(personaje) es un Mago")
    case let unPersonaje where personaje.hasPrefix("Lobo"):
        print ("El personaje \(personaje) es un Lobo, \(unPersonaje)")
    default:
        print ("Este no es un personaje de la historia")
}

var otroNumero = 15
switch otroNumero{
case 0...5:
    print("Esta entre cero y cinco")
    ++otroNumero
    fallthrough
case 6..<10:
        print("Entre 6 y 9")
    ++otroNumero
    break
case 11:
    break
default:
    print(otroNumero++)
}

let x : Int? = 2

if let opc = x {
    print("opcional es \(opc)")
}else {
    print("no tiene valor")
}

let numeros = [2,4,31,3,56,42,14]

let mappedNumbers = numeros.map({
    (i: Int) -> Int in
    return i * 3
})

mappedNumbers[1]

func miFuncion() throws {

}

do {
    try miFuncion()
}catch{
    print("error")
}

var librosFavoritos: [String] = ["Aprende swift en 3 segundos", "Elm para principiantes", "Crea sitios increibles con elixir"]

librosFavoritos.count
librosFavoritos.first

if let libro = librosFavoritos.first{
    print (libro.lowercaseString)
}

print(librosFavoritos.last!)

librosFavoritos[1]

librosFavoritos.append("Code complete")
librosFavoritos[2] = "Pragmatic programmer"

let libroBorrado = librosFavoritos.removeAtIndex(3)
print(libroBorrado)

librosFavoritos.appendContentsOf(["Joel on Software", "LOL-Driven devlopment"])

librosFavoritos

for libro in librosFavoritos{
    print(libro)
}
for (indice, libro) in librosFavoritos.enumerate(){
    print("\(indice) : \(libro)")
}

var miDiccionario : Dictionary<String, String> = ["Twitter" : "Pepe"]
var suDiccionario : [String:String] = ["Twitter" : "Arbo"]
var diccionario = ["Twitter" : "implicito"]

print(diccionario["Twitter"]!)

var diccVacio : [String:String]
//diccVacio["nuevo"] = "hola"

//print (diccVacio["nuevo"]!)

var usuarios2: Dictionary<String,String> = [:]

usuarios2["nuevo"] = "hola"

print (usuarios2["nuevo"]!)

var unDiccionario: [String:Int] = [:]
var llaves = ["llave1": 1, "llave2": 2, "llave3":3]

let unValor = llaves.updateValue(4, forKey: "llave3") // tipo objetive c

print(unValor!)
llaves["llave2"] = 5

print(llaves)


print (llaves.count) // 3
llaves["llave2"] = nil // or 
//llaves.removeValueForKey("llave2")
print (llaves.count) // 2

// ############ Conjuntos #################

var amigos = Set <String>()
var amigos2: Set<String> = []
var amigos3 = Set(["Julieta","Violeta","Andres","Ernesto"])

var amigos4: Set = ["Fabian","Pedro","Andres","Ernesto"]

amigos4.insert("Julian")
amigos4.insert("Julian")

let aQuienElimine = amigos4.remove("Ernesto")
print("Elimine a \(aQuienElimine!)")

for amigo in amigos4{
    print("\(amigo) es mi amigo")
}

let estaVacio = amigos4.isEmpty

let estaAndres = amigos4.contains("Andres")
let numeroAmigos = amigos4.count

let amigosComunes = amigos3.intersect(amigos4)
let diferentes = amigos3.exclusiveOr(amigos4)

let todosAmigos = amigos3.union(amigos4)
let resta = amigos3.subtract(amigos4)

// ############ Opcionales 2 parte ##############
var cadenaOpcional: String? = "10"

if let s = cadenaOpcional {
    if let i = Int(s) {
        print("El entero es \(i)")
    }
}

if let s = cadenaOpcional, i = Int(s) {
    print("Cadena es \(s); el entero es \(i)")
}

let unEntero = 10
let otroEntero: Int = unEntero.successor()
print("El sucesor de \(unEntero) es \(otroEntero)")

var enteroOpcional: Int? = unEntero.successor()
print(enteroOpcional)


var uno: Int? = 10
var siguiente = uno?.successor() // si es nil no ejecuta el metodo
print("\(siguiente)")

var uno1: Int? = nil
var siguiente1 = uno1?.successor() // si es nil no ejecuta el metodo
print("\(siguiente1)")

var otrosLibros: [String] = []
let valor: String = otrosLibros.first ?? "Valor por defecto"

func saludar(){
    print("Hola mundo")
}

func saludar2(persona persona: String){
    print("Hola \(persona)")
}
saludar2(persona: "Pepe")

func saludar3(personas personas: String...){
    for persona in personas {
        print("hola \(persona)")
    }
}

saludar3(personas: "Arbo", "Angel")

func saludar4( persona: String, saludo: String){
    print("Hola \(persona)\(saludo)")
}

saludar4("pepe" , saludo: "juan")

func saludo(persona: String = "Alejandro"){
    print("Hola \(persona)")
}

saludo()
saludo("Pepe")

struct Cuerpo{
    var peso: Double = 0.0
    var altura: Double = 0.0
    
    // altera valor por referencia, se comporta como una clase
    mutating func subirPeso(kilos: Double){
        peso += kilos
    }
    func subirAPeso(kilos: Double){
        //peso = kilos // tiene que ser mutatin para que funcione
        print (kilos)
    }
}

class Persona{
    var cuerpo: Cuerpo = Cuerpo()
    var imc: Double {
        return cuerpo.peso / (cuerpo.altura * cuerpo.altura)
    }
    
    static let pesoDefault : Double = 20.0
    
    static func devuelvePesoDefault() -> Double {
        return pesoDefault
    }
    
    
}

Persona.pesoDefault


var cuerpo = Cuerpo()
cuerpo.peso = 95.0
cuerpo.altura = 1.85
cuerpo.subirPeso(10.0)
cuerpo.peso

let cuerpo2 = Cuerpo()
// cuerpo2.peso = 12.0 // error porq es una constante


var juan = Persona()
juan.cuerpo = cuerpo
juan.imc


print ("Juan pesa \(juan.cuerpo.peso) kilos y mide \(juan.cuerpo.altura) metros")

class Empleado: Persona{
    var idEmpleado = 0
    
    func asignarID(id: Int){
        idEmpleado = id
    }
}

var empleado = Empleado()
empleado.cuerpo = cuerpo
empleado.idEmpleado = 12


let empleado2 = Empleado()
empleado2.asignarID(3) //funciona porque lo que es una constante es la referencia al apuntador de la clase

class Empresa{
    var cantidadEmpleados: Int = 0 {
        willSet{
            print("Tenemos \(cantidadEmpleados) y vamos a tener \(newValue) empleados")
        }
        didSet {
            print("Teniamos \(oldValue) empleados y ahora tenemos \(cantidadEmpleados) empleados")
        }
    }
    
    
    
}

let emp = Empresa()
emp.cantidadEmpleados = 2

protocol EventType{
    var titulo: String {get set}
    var id: Int{get}
    
    func enviaNotificacion()
}

class CalendarEvent : EventType {
    var titulo : String = ""
    var id: Int = 0
    
    func enviaNotificacion(){
        print("enviada")
    }
}

protocol EspecialEvent : EventType {
    var descri : String { get}
}
class CalendarEvent2 : EspecialEvent {
    var titulo : String = ""
    var id: Int = 0
    var descri : String = ""
    
    func enviaNotificacion(){
        print("enviada")
    }
}

struct Point {
    var x : Double = 0.0
    var y : Double = 0.0
}

var punto = Point ()
punto.x = 2
punto.y = 4

print(punto)


extension Point : CustomStringConvertible {
    var description : String {
        return "Esto es un punto y su valores son: x=\(x), y=\(y)"
    }
}

/*
func miFuncion() throws {}

do{
    try miFuncion()
}catch{
    print(error)
}*/

enum MyErrorType: ErrorType{
    case Mal, Peor, Terrible
}

func infalible(valor: Int) -> String{
    return "Obtuve el valor \(valor) sin problemas"
}

func humano (error: Bool) throws -> String{
    if error{
        throw MyErrorType.Mal
    }
    return "Casi perfecto"
}

do {
    infalible(2)
    try humano(true)
    print("todo funciono bien")
}catch{
    print ("algo fallo por el error: \(error)")
}

