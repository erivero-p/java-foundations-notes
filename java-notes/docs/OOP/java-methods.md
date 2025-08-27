# Java Methods

## Methods Creation

A method is what gives behaviour to a type (in Java, classes, interfaces and enums can have methods). In other words, methods are pieces of code that define high level actions. Those actions can be invoked by calling the method name. 

The basic structure of a method is the following:

```java
returnType methodName(parameters) {
	methodBody ;
}
```

The **`returnType**` specifies what the method will return as result of its execution. 

The **`methodName`** is the name given to the method, it must be a valid Java identifier. 

The `parameters` of a method are specified by a list of comma-separated parameter declarations. Unlike  regular declarations, even if they share the same type, the type can’t never be avoided like this `(int i, j, k)`. If a method does not take any parameter, the parameter list will be empty `()`.

> Parameters that are not meant to be reassigned inside the method body *can* (optionally) be declared as `final`.
> 

The `methodBody` contains the code that will be executed upon invocation. It must be contained within curly braces. They are mandatory even if there’s only one scope in the method body.

### **Returning a value from a method**

- **void methods**

 If the method doesn’t mean to return nothing, it must specify so with the keyword `void`.

Once a method is declared as `void` is not allowed to return anything, The only return statement allowed is the empty one `return ;`. 

- Non void methods

If the return type is not void, it is mandatory for the method to return  one element of the specified* type. This means that is not possible to return a value conditionally like this:

```java
void exampleMethod(final int a) {
    // a = 5; // ❌ Error: cannot assign a value to final variable a
    System.out.println(a);
}
```

> The above situation can be fixed by ensuring that there will be a value returned in all situations. For example, with `else {return 0;}`.
> 

### Returning a value of a different type from a method

*The general rule is that the element returned must be of the specified return type as I mentioned above. However, there are three exceptions to this rule:

1. Numeric promotion. If the return type is a numeric one, the return value can be any other numeric type if fits in the return type.
2. Autoboxing/Autounboxing. If the method returns a wrapper class, Java allows returning its primitive type. In reverse, if the method returned a primitive, not only its wrapper class can be returned but also the wrapper classes of smaller sizes as for numeric promotion.
3. Subclasses. Java allows one method to return any subclass of the return type.

```java
// Numeric promotion
double getNumber() {
    return 5; // int promoted to double
}

// Autoboxing
Integer getWrapper() {
    return 10; // int autoboxed to Integer
}

// Subclass return
Number getNum() {
    return Integer.valueOf(42); // Integer is subclass of Number
}
```

### Returning multiple values from a method

Java does not allow a method to return more than one value. This can be handled by using arrays, but sometimes is  quite confusing.

Even though classes are designed to capture values that are related to each other. They can also be used to wrap values with no relation, just to return them from the same method. They are called *holder classes*.

> In Java 16, records where introduced. They can be used also for this purpose. But either holder classes or records are in the exam scope.
> 

### Varargs

There will be situations in which you don´t know the number of arguments that the method is going to receive. This is not a problem as long as you know the type of the arguments.

Same as with returning multiple values, it can be solved by using arrays, but Java 5 introduced the new syntax called *varargs*, to make passing a variable number of arguments to a method a little easier. Varargs methods are defined by using an elipsis (`...`) following the variable type.

For example:

```java
int summarizer(int... args) {
	int res = 0;
	for (int arg : args) {
		res += arg;
	}
	return res;
}

void greet(String greeting, String... names) {
    for (String name : names) {
        System.out.println(greeting + ", " + name);
    }
}
```

Varargs have mainly two restrictions:

1. A method cannot have more than one varargs parameter.
2. The varargs parameter, if present, must be the last one in the parameter list.

> A valid invocation for a method whose unique parameter is a varargs can be an empty parameter list, for example `summarizer()`.
> 

## Method overload

### Method signature

Since overloaded methods are just methods with the same name but different signatures, lets clarify what a method signature is.

Method signature acts like the identifier of the method. It has to be unique, and includes just the method name and its ordered list of parameter types. Thus, the following declarations have all the same signature:

```java
void example(int a, String b);
public static void example(int a, String b);
int example(int a, String b);
private String example(int a, String b);
```

So, whenever a class have multiple methods with the same name and different parameter lists, those methods are called “overloaded” methods. For example:

```java
void example(int a);
void example(String b);
void example(int a, int b);
void example(int a, String b, double c);
```

### Method selection

The election of which one of the overloaded methods is chosen is made by the compiler, taking into account the declared type of the object that invokes the method, and of the parameters. This means that is not using the real runtime object, but the declared types, to reduce errors. At runtime, the JVM picks up the method signature that was selected by the compiler.

> Having overloaded methods won´t cause a compilation error by itself as long as their signatures are different.
> 

Since due to inheritance and autoboxing circumstances, sometimes the selection can be a bit ambiguous, there are some basic:

- **Exact match**

If the compiler finds a method whose parameters exactly match with the method call, will select it. 

- **Most specific**

If more than one method is capable to accept a method call an none of them is an exact match, the compiler will choose the most specific one. 

```java
void example(Object obj);
void example(CharSequence str); // compiler will choose this one

example("hello");
```

In the example above, the compiler will choose the second signature, since `String` extends from `CharSequence`, so it is more specific, is “closer”. Same here:

```java
void example(int i);
void example(short s); // compiler will choose this one
byte b = 10,
example(b);
```

- **Widening before autoboxing**

Since autoboxing was introduced in Java 5, primitive versions will have higher priority if the argument can be widened to a compatible primitive version. For example:

```java
void example(Byte b);
void example(short s); // compiler will choose this one

byte b = 10;
example(b);
```

Even if with autoboxing `byte` and `Byte` are exact matches, the compiler will choose the `short` version.

- **Autoboxing before varargs**

If an argument can be autoboxed into a method parameter type, then, will be prioritized over a vararg of the same type. Here an example:

```java
void example(int... values);
void example(Integer value); // compiler will choose this one

example(5);
```

## Passing object references and primitive values into methods

### Pass by value

Java uses **pass-by-value** semantics to pass arguments to methods. There are no exceptions. 

Let´s illustrate it with some examples, starting with a simple one:

```java
public class exampleClass {
	public static void main(String[] args) {
			int a = duplicate(100); // invokes duplicate with the value 100
			// a now contains 200
			System.out.println(a); //prints 200
	}
	
	int duplicate(int x) { // initializes the parameter x with the value passed (100)
		// x now contains 100
		return x*2; // returns the value generated by statement 2*x
	}
```

Let´s make a small change:

```java
public class exampleClass {
	public static void main(String[] args) {
			int a = 100;
			int b = duplicate(a); // invokes duplicate with the value contained by a 
			// b is now 200 but a remains the same
			System.out.println(a + ", " + b); //prints 100, 200
	}
	// here everything is the same as before
	int duplicate(int x) { // initializes the parameter x with the value passed (100)
		return x*2; // returns the value generated by statement 2*x
	}
```

Right before the execution of the method, the JVM initializes the parameter x with the value passed. But this value can be changed inside the method. It won’t change the value of `a`. Since Java pass by value and not by reference, the method is not aware of where the value comes from, and cannot access the original variable, that´s where the pass by value term comes from.

```java
	public class exampleClass {
	public static void main(String[] args) {
			int a = 100;
			int b = duplicate(a); // b is now 200 but a still  remains the same
				}
	int duplicate(int x) { // initializes the parameter x with the value passed
		x = 200; // reasign the value of x, doesnt change a 
		return x*2; // returns the value generated by statement 2*200;
	}
```

### Passing objects to methods

Once we understand the implications of pass-by-value, we can see that for reference variables happens the same. Since reference variables doesn’t hold a real object but is address in memory, when we pass an object as an argument, what we are passing is the value of the reference, which is the memory location.

```java
public class Data {
	int value = 100;
}

public class exampleClass {
	public static void main(String[] args) {
		Data d = new Data(); // d contains the memory address of the created Data object
		duplicate(d); // JVM copies the value contained by d
		System.out.println(d.value); // prints 200	 
	 }
	vois duplicate(Data x) { // JVM initializes x with the copied address
		x.value = 2*x.value; //  value is modified
	}
```

> Even if we made the following: `duplicate(new Data());` we wouldn´t be passing the real object as parameter, because a temporal reference is created by calling `new Data()` even if we don´t store it in any variable.
> 

In the example above,  `d` reminds the same, since the object is in the same address. What have been modified is the atribute `value` of the object referenced by `d`and also by `x` .

### Returning values from a method

Same as with parameters, returning values uses pass-by-value semantics.

In the case of primitives, a return statement can return either the value directly or the value of a variable.

```java
return 100; // value 
return x; // value contained on x
```

In the case of objects, the return statement can be an explicit variable or the value of an implicit temporary variable that references the object. In both cases it is really the object address what is returned. 

```java
return str; // explicit variable
return "hello"; // temporal implicit variable
return new Student(); // temporal implicit variable
```

## Applying the `static` keyword to methods and fields

Any member of a class, including nested classes can be declared as static. In the case of methods and fields, the `static` keyword must appear just before the return type or the type. Like this:

```java
class ExampleClass {
    static int count;            // static field
    private static void ping() { // static method
        System.out.println("Ping");
    }
}

```

### Accessing static members

We already learned that a static member belongs to the class and not to any instance of the class, so it doesn’t require an instance of the owning class to exist. Thus, the standard and recommended way of accessing static member is by using the name of the owning class. For example, to access `count` from the example above, we would do: `ExampleClass.count`

However, Java allows a static member to be accessed through a variable as well:

```java
ExampleClass e = null;
System.out.println(e.count);
```

The compiler won’t complain about `e` being null because it notices that we are trying to access a static member. Yes, the access to static members is decided at compile time by checking the declared type of the variable, not the real object at runtime. This is called **static binding** or **compile time binding**.

> Of course, to access the static member from the same class, there’s no need to use the class name.
> 

It is also possible to access a static member using explicit or implicit references to instances, but is not the best practice.

```java
ExampleClass e = new ExampleClass();
e.ping(); // explicit reference
new ExampleClass().ping(); // implicit reference

```

### Accessing instance members from a  static method

Since static methods belong to the class and not to any instance, and since instance members require an actual instance to be accessed, accessing them from a static method is not straightforward.

We already mentioned that `this`variable is implicit, it is not declared explicitly anywhere, and even if it´s not written explicitly, the compiler assumes its existence. Whenever the compiler sees an instance member being accessed from within a method, uses the `this`variable to access that member. Thus, if we try to access as usual an instance method from a static member, the compiler will compile, because there´s no such a thing as “this” instance in static methods.

 

```java
class ExampleClass {
	int instanceField;
	static void staticMethod() {
		System.out.println(this.instanceField); // Wont compile
		System.out.println(instanceField); // this is implicit, wont compile either
	}
}
```

Does this mean that a static method can never access a non-static field? Incorrect. You can access instance field as long as you have an instance. So, the following code is correct:

```java
class ExampleClass {
	int instanceField;
	static void staticMethod() {
		ExampleClass tmp = new ExampleClass(); // create an instance
		System.out.println(tmp.instanceField); // access through the instance
	}
}
```

### Accessor and Mutator Methods

Accessor and mutator methods are just the technical names for **getters** and **setters**. While encapsulation (chapter 9) explained *why* we use them, here we’ll show *how* to create and use them.

- An **accessor** (getter) returns the value of a private field.
- A **mutator** (setter) changes the value of a private field.

```java
class Student {
    private String name;

    // accessor
    public String getName() {
        return name;
    }

    // mutator
    public void setName(String name) {
        this.name = name;
    }
}

public class Example {
    public static void main(String[] args) {
        Student s = new Student();
        s.setName("Alice");                 // using mutator
        System.out.println(s.getName());    // using accessor
    }
}
```

Using getters and setters enforces encapsulation while still allowing controlled access to private data.