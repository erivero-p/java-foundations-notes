# Classes and Constructors

## Relationship between an object and its members

### Object fields

By object fields we mean instance variables of a class. Each instance owns a copy of these variables, which values can be unique. To read or modify those values, in Java we use the dot `.`operator, and it is crucial to have a reference pointing to the object whose fields we are trying to access. 

The basic syntax is this: `reference.field` and the same applies for method invocation.

Sometimes you may not want to keep a reference in a variable For example, when you create an instance only to call a method once. In that case, it can be done in the instantiation scope like this `new ExampleClass().exampleMethod();` 

> Since the method call is chained directly to the object creation, the compiler is able to create a temporary reference variable pointing to the newly created object and invoke the method using that variable.
> 

Within `exampleMethod()`, the same `ExampleClass` object is available though, through a special variable called "this".

### `This`

`this` is a keyword used to refer to the current instanc**e** within instance methods. Its type is always the same as the class or enum in which it is used, and it acts like a local variable automatically set to point to the current object. Technically, it behaves like a `final` local variable, since it cannot be reassigned to another object.

In Java, if you don’t specify any reference explicitly inside an instance method, the JVM assumes you want to access the current object. Therefore, `this` is usually optional and only necessary to break ambiguity when multiple variables with the same name are in scope:

 

```java
class ExampleClass {
	String name;
	
	ExampleClass(String name) {
		this.name = name;
	}
}
```

This ambiguity is called **shadowing**, because the local variable “shadows” the instance variable, making it otherwise inaccessible.

> `this` can also be used in other contexts, such as calling another constructor in the same class (`this(...)`) or passing the current object as an argument to another method or class. Although it can technically be used to access static members, this is not considered good practice.
> 

## Encapsulation

We already mentioned in chapter 2 that encapsulation is considered a fundamental pillar of Object-Oriented Programming. It is defined as the **wrapping up of data and behaviour into a single unit**, binding together the code and the data it manipulates.

Encapsulation acts like a protective shield that exposes only the necessary interface and hides the internal details. One of its main advantages is reducing tight coupling between classes, which occurs when external classes access internal members directly. With encapsulation, code becomes more maintainable, flexible, and scalable.

In Java, encapsulation is primarily achieved through the use of access modifiers.

### Access modifiers

Access modifiers are keywords that explicitly specify the visibility of a class and its members. Java provides three keywords for this purpose, which correspond to four levels of access. From the most restrictive to the least, they are:

- `private` – A private member is accessible only within the same class.
- *default* (package-private) – If no access modifier is specified, the member is accessible by any class in the same package.
- `protected` – A protected member is accessible by all subclasses, and also by classes in the same package (regardless of inheritance).
- `public` – A public member is accessible from anywhere.

> It is a good practice to keep members as private as possible. You can define all class members as private, and create public getter and setter methods in case you need to access them.
> 

## Constructors

When you create a new instance of a class, this is the sequence of steps performed by the JVM:

1. Checks if the class has been initialized; if not, initializes it.
2. Allocates the required memory to hold the instance variables of the class.
3. Initializes the instance variables to their **default values**.
4. Executes instance initializers and then the constructor, in order to set the instance variables to the intended values.

> Only once those four steps are completed, the instance is ready to be used.
> 

Although not required for the exam, it’s useful to know that **instance initializers** are blocks of code written directly within the class body. They are executed in the order they appear, before the constructor runs.

```java
class ExampleClass {
    String name;
    {
        System.out.println("Hi! This is ExampleClass's initializer");
    }
    // methods here
}

```

On the other hand, constructors are special routines that runs only once, with the purpose of set up the object.

The main benefit of using constructors is take advantage of what we mentioned before: instance objects are not ready to use until the JVM finish the four mentioned steps, thus, a constructor ensures that a class won’t be used before its members are initialized properly following the business logic of the class, and, in general, all the initialization activities required have been performed. 

Constructors also provide thread safety because no thread can access the object until the constructor has finished.

### Creating constructors

The syntax of constructors is very similar to methods, with two mandatory rules:

1. The name must be exactly the same as the class name.
2. A constructor does not have a return type. Not even `void`.

For example, the following compiles, but it is **not a constructor**, since it declares a return type:

```java
class ExampleClass {
    void ExampleClass() { } // this is just a method
}
```

A constructor may contain an empty `return;` statement (although it’s not necessary). For instance:

```java
class ExampleClass {
    String name;
    ExampleClass() { }
    ExampleClass(String name) {
        this.name = name;
        return; // optional but valid
    }
}
```

As shown above, constructors can take arguments. We usually distinguish between No-argument constructors and parameterized constructors.

### The default constructor

Every class must have a constructor. If none is explicitly provided, the compiler automatically supplies a *default constructor*. It takes no arguments, and has no code in its body.

> Default constructor is provided by the compiler only when a class doesn’t define any constructor.
> 

Once you define any constructor, the compiler won’t provide the default one. This means that if you only declared a parametrized constructor `ExampleClass(String name)`, and after that try to create an object without parameters `new ExampleClass()`, your code won’t compile, since the method `ExampleClass()` doesn’t exist.

The accessibility of the default constructor is the same as of the class. So if the class isn’t public, the default constructor won’t be either.

### Overloading constructors

We already saw in the example that the same class can have several constructors by changing the parameters of each one. This is called constructor overloading. And the main difference with method overloading lies in how a constructor calls another. In method overloading, a method can call another one simply by invoking it with the proper parameters:

```java
class ExampleClass {

    void ExampleMethod() { 
	    ExampleMethod("John Doe");
    }
    void ExampleMethod(String name) {
				Sytsem.out.println("Hi, this is " + name);
    }
}
```

With constructors, this is called **constructor chaining** and it is done by using the `this` keyword followed by the arguments if any. It can’t be done by calling the constructor for its name. Another restriction is that when calling another constructor, it must be the first line of code in the constructor. 

For example, given this class with this parametric constructor:

```java
class ExampleClass {

	String name;
    ExampleClass(String name) {
				this.name = name;
    }
}
```

From those three no args constructors, only the first one is valid.

```java

    ExampleClass() { 
	    this("John Doe"); // this is valid
			System.out.println("no args constructor called");
    }
    
    ExampleClass() { 
			Sytem.out.println("no args constructor called");
	    this("John Doe"); // not valid: must be first line
    }
    ExampleClass() { 
	    ExampleClass("John Doe"); // not valid: cannot call constructor by name
    }
    
    ExampleClass(String name) {
				this.name = name;
    }

```

> Except for constructor chaining, it is not possible to invoke a constructor of a class directly. A constructor is only invoked during the creation of the instance with `new`.
> 

## Variable Scope, Visibility and Lifespan in a class

Java has three different visibility scopes for variables: class, method and block. And fice lifespan scopes for variables: class, instance, method, for loop, and block.

### Visibility scope and overlapping

Visibility scope means where a variable is visible directly without using any referencing mechanism. In other words, whether the compiler is able to see a variable at given location with any help.

> If you declare a variable in a method, the visibility of that variable is within that method only. Same for classes and blocks.
> 

When we talk about **overlapping** in this context, we mean the fact that two variables can have the same name with no conflicts in case that they have different scopes. The compiler will prioritise the smaller scoped variable. Here an example:

```java
public class ExampleClass {

    static final int x = 0; // class scoped variable
    
    void exampleMethod() {
        int y = 1; // method scoped variable
        System.out.println(y); // prints 1

        if (true) {
            int x = 2; // block scoped variable (overlaps with class variable)
            System.out.println(x); // prints 2
        }

        System.out.println(y); // still prints 1
    } 
    
    {
        System.out.println(x); // outside the method scope, prints 0
    }

}
```

There´s an exception: It is not possible to overlap a method scoped variable with a loop or block scoped  scoped variable. Even if they have different scopes. Thus, the following code won’t compile:

```java
public class ExampleClass {

    void exampleMethod() {
        int i = 1; // method scoped variable
    
        for (int i = 0; i < 5; i++) { //  Won’t compile
            System.out.println(i); 
        }
    } 

}
```

### Shadowing vs hiding

**Shadowing**, which we already mentioned, is a direct consequence of overlapping, which is the fact that a smaller scoped variable can shadow a bigger scoped variable. In our previous example, the block scoped variable `x` is shadowing the class scoped variable `x`. 

On the other hand, **hiding** is where a subclass variable hides the variable with the same name in a superclass. We will talk about it deeper in later chapters.

> There’s a third category of name conflicts called ***obscuring***, which happens when the compiler is not able to determine what a simple name refers to. For example, if a class has a field whose name is the same as the name of a package.
> 

### Scope and lifespan

Scope is also related to the lifespan or life time of a variable. In Java, the existence of a variable depends on the existence of the scope to which it belongs. So, for example, if any instance of a class doesn’t exist any more, its attribute variables won’t exist either.

Lifespan scope doesn’t affect compilation. The compiler checks for the visibility scope. When lifespan is the same as visibility scope, there’s no such a problem. However, they can be different on class and instance variables. For example:

```java
public class ExampleClass {
    int data = 0;

    public static void main(String[] args) {
        ExampleClass c = new ExampleClass();
        c = null; 
        System.out.println(c.data); // compiles, but throws NullPointerException
    }
}
```

> Lifespan scope affects the run time execution, for example, the above program throws `NullPointerException` at runtime.
>