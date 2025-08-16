# Java Basics

## Java Development Kit (JDK) and Java Runtime Environment (JRE)

We have already talked about the JDK and the JRE.  But this is a kind reminder: JRE includes just the stuff necessary to run a Java program: JVM, Java API and its configuration and extension files. On the other hand, A JDK includes the tools required to write Java programs such as compiler and debugger. A JDK contains a JRE, and is therefore, much larger in size than a JRE. 

The purpose of treating JRE and JDK as two separate entities was to ensure that a runtime environment could be preinstalled in all computer. And also, due to  license reasons. However, from Java 11 in advance, Oracle doesn't build JRE with JDK. In fact, there is no standard JRE anymore.

Also, since the official Oracle Java is not free for commercial purposes, Oracle has created a group called OpenJDK and has released the source code for the JDK on [openjdk.java.net](http://openjdk.java.net/). Companies take that same source code and create their own version of the Java and the JDK. Each such version is called a "Java Build".

## Components of a basic Java program

Every Java program will contain:

- **The source code -** All the source code in a Java program reside in one or more type definitions, written in one or more files with .java extension. Type, in this context, will include classes, interfaces and enums.
- The libraries: standard library classes (pre-compiled) and third party libraries, which will be packaged in .jar.

### Structure of a Java file

> Note: The exam will sometimes use the concept of "Java Program" to mean a Java source code file. This is not precise.
> 

A Java source code file primarily contains the following three things: 

1. Zero or one package statement
2. Zero or more import statements
3. Zero or more type definitions // aquí no debería ser 1 ? ni cero ni más?

```java
package com.example; // optional
import com.interfaces.InterfaceExample; // optional

public class ExampleClass implements InterfaceExample { // class declaration
	// class body 
}
```

We will talk about it later, but class declaration can contain the access modifier (`public` in our example, and also the extension clause (`extends` or `implement`). 

Also, in a Java source file we can find comments. Single line comments are noted using `//` and multiple line comments can be  encapsulated inside of `/*  comment here  */`. We can use comments to document our code using JavaDoc format: 

```java
/**  * Observe the start of the comment. It has two *s
     * Each line starts with a *  * There is a space after each *  
     * <h3>You can write HTML tags here.</h3>  
     * Description of each parameter starts with @param
     * Description of the return value starts with @return  
     * @see tag is used to add a hyperlink to description of another class  
     * @param  name the location of the image, relative to the url argument  
     * @return      the image at the specified URL  
     * @see         SomeOtherClassName  */
```

JavaDoc is a tool bundled in the JDK, that extracts the information contained in the formatted comments and generate HTML documentation. 

### Java source file naming

Every public class must be written inside a Java file with the same name. So: `ExampleClass`will be inside `ExampleClass.java`. This implies that in one file, there can only be one  public class (or type). 

This only apply to top level types, so we can have more than one public class in case of nested classes. Also, we can have one public class, and more private classes in the same file. This would be a valid java file: 

```java
public class ExampleClass {
		public class NestedClassExample {}
}
class NonPublicClassExample {}
private class PrivateClassExample {}
```

This restriction is imposed by the Java compiler and not the JVM.

### The main method

Every Java program must contain a valid main method. The main method is the method that the JVM is hardwired to look for to run a compiled Java program. Its name must be `main` and it must take exactly one parameter of type `String array`. In addition to this, it must return `void`, must be `public` and must also be `static`. It is free to declare any exception in its `throws` clause.

So, these are examples of valid main methods:

```java
public static void main(String[] args) {}
public static void main(String... args) {} // String... = String[]
public static void main(String[] args) throws Exception {}
```

And those would be invalid:

```java
static void main(String[] args) {} // not public
public void main(String[] args) {} // not static
public static void main(String a, String b) {} // wrong arguments
public static void Main(String[] args) {} // Capital letter on name
```

Java programs can handle command line arguments, since the JVM passes them to the main method through its `String[]` parameter.  We can iterate it as any other String array. Unlike C, if no arguments provided, String array length will be 0, as it doesn't contains the program name. 

> The main method is just an entrypoint to one Java application, which probably will be composed by multiple classes. At runtime, an application consist of instances of several classes that interact with each other by calling its methods. So, everything must be well declared and connected.
> 

## Components of object-oriented programming

Java is an object-oriented language, which means that organizes the code into classes* and objects. In contrast, there is the Procedural Programming paradigm, which perceives a software as a series of processes executed over a given set of data, for example, C.

> Classes are the primary object-oriented construct in Java. A class is a combination of data (*fields*), also known as instance variables, and behavior (*methods*).
> 

The four pillars of OOP are: abstraction, encapsulation, inheritance and polymorphism.

### Abstraction

Abstraction is the property of which only the essential details of an entity (class) are displayed to the user. It is the process of hiding the implementation details while showing only the relevant ones. It allows to focus on what an object does rather than how it does it. By abstracting functionality, changes in implementation do not affect the code that relies on the abstraction, as long as the interface remains consistent.

Java provides two ways to implement abstraction: *abstract classes*, and *interfaces*.

### Encapsulation

It is defined as the **wrapping up of data under a single unit.** It is the mechanism that binds together the code and the data it manipulates. Another way to think about encapsulation is that it is a protective shield that prevents the data from being accessed by the code outside this shield. Encapsulation also allows us to expose only the "what" and not the "how". 

In Java, encapsulation can be achieved by using appropriate access modifiers for the class members. For example, declaring all the fields in a class private, and writing public methods in the class to set and get the values of the variables (typically known as getters and setters).

### Inheritance

It is the mechanism by which one class is allowed to inherit the features of another class, being able to establish a parent-child relationship, and extend and specialize the functionalities of the parent on the child.

 In Java, we achieve inheritance by using `extends` keyword. Inheritance supports the concept of *reusability*, so that we can create a new class (called *subclass*) with particular features being able to reuse the general features of a parent class (called *superclass*).

### Polymorfism

It refers to the ability of OOP languages to differentiate between entities with the same name efficiently. This is done by Java with the help of the signature and declaration of these entities.

There are two main ways to achieve polymorphism in Java: *method overloading*, and *method overriding*. While method overloading (also known as compile-time polymorphism) consists of having multiple methods with the same name but different signatures in the same class, method overriding is a direct consequence of inheritance and involves changing the implementation (but not the signature) of a method in a subclass

## OOP in Java

### Java Classes

As we already mentioned, classes are the most basic construction bricks of the Java language. Within a class definition, you can have field declarations, methods, constructors and initializers. All of them are called "members" of a class. We will call field or attributes to the members of a class that store its attributes: it is variables. And we call method to the functions declared in a class. 

### Relation between classes and objects

 By declaring a class, we create a  prototype that can be instantiated as many times as we need. The instantiation of an object of a class is made using the keyword `new`, and calling the constructor method of that class. We will talk about constructors later.

```java
ExampleClass example = new ExampleClass();
```

To access an object, you need to know exactly where that object resides in memory: it's memory address. Once you have it, you can achieve different objects interact with each other by calling their methods or accessing their data fields. This is done using the operator `.`

```java
example.doSomething();
```

### References

There is a fundamental difference in the way Java handles  reference variables and non-reference variables. Those are called primitive and non-primitive types also, and we will extend on them later. But, an overview will be that the JVM will use the address to access the actual object contained by a reference variable and not the reference itself. Also, you won't be able to store the address of any memory location manually in any reference variable.

A reference variable that doesn't point any object, it is said to be `null`.

You can have as many references to an object as you want. When you assign one reference to another, you basically just copy the value contained in one reference into another.

### The `static` keyword

In Java, every piece of code must belong to a class, so you can't have independent functions. However, Java counts with the `static` keyword to achieve something similar. 

A static field of a class will belong to the class itself instead of belonging to the instantiated objects of that class. This way, all the objects of a class can share an unique field, in case of attributes, and you will be able to access to the static class member without having to instantiate an object of that class, which is specially useful for methods.

> Even if you don't need an object to access a static member, you can access it this way `instantiatedObject.staticMember` too. However, it doesn't change its behavior, it still belongs to the class, and is not a good practice as it causes confusion.
> 
