# Working with Java Data Types

## Data types in Java

Java supports two kinds of Data: data types and reference types. 

### Data types

A data type defines the kind of data a variable can hold and what operations can be performed on it. This classification allows treating data of the same kind in the same way. So, for example, the set of operations that can be performed in each kind of data, will be defined differently.

> By defining a variable of a certain type, you automatically get the right to perform operations that are valid for that type of variable.
> 

 Data type also determines the space required to store that kind of data. For example, a byte requires 8 bits, a char in Java 16 bits, and an int will be 32 bits. 

Java has two fundamental kinds of data types: primitive and reference.

Primitive data types are for working with raw data. Java inherently will know their size and their allowed operations. In Java, they include integral data types (byte, char, short, int, long), floating point data types (float, double), and boolean data type. 

Reference data types, on the other hand, are designed to be used while working with data with a special meaning for code that Java has no knowledge of. When you define a class, interface or enum, you are essentially defining a reference data type. Once you define them, you can use them.

> About `void` and `null`: Both are Java keywords that means nothingness. In `void`'s case, it can be declared as the return value of a method, however is not a data type itself but a type specification. In the other hand, `null` is a value, used to signify that a reference variable is currently not pointing to any object. It can only be assigned to reference variables.
> 

### Variables

A variable is a named memory location used to store data that can be changed during the execution of a program. In Java, variables are strongly typed, which means that every variable must be declared with a specific data type that determines the kind of values it can hold and the operations that can be performed on it.

Java has two types of variables to work with the two kinds of data types: primitive and reference variables. 

We already mentioned that a primitive variable contains primitive data within itself, while a reference variable stores only the address to the location where  the actual data is stored. 

### Wrapper classes

Java does have objected oriented versions of the primitive data types as well. They are called "wrapper classes". The java.lang package contains Boolean, Byte, Character, Short, Integer, Long, Float, and Double classes that wrap their corresponding primitive types. 

Java 1.5 introduced the feature of "autoboxing", that allows seamless interoperation between primitive types and their corresponding wrapper classes. If you try to assign a primitive value to its corresponding wrapper class variable, the value is automatically wrapped into the corresponding wrapper class. Similarly, if you try to assign a wrapper class object to a primitive variable, the wrapper class object is automatically unboxed and its value is assigned to the corresponding primitive variable.

## Difference between reference variables and primitive variables

### Assignation

Both types of variable supports the assignment (`=`) operation, to give them value. In case of a reference variable, you cannot assign the address of an object directly*. You can only do so indirectly. Also, while assigning one reference variable to another, i.e. `String s2 = s1;` you are not copying the values, just the address. 

> *  You cannot create or assign raw memory addresses manually in Java. Reference variables are automatically assigned the address of the object created using `new` or returned by a method
> 

The JVM just copies the value contained in the variable on the right-hand side of the assignment operator to the variable on the left-hand side. It does this irrespective of whether the variable is a primitive variable or a reference variable. In case of a primitive variable, the value happens to be the actual primitive value and in case of a reference variable, the value happens to be the address of an object.

> In both the cases, it is the value that is copied from one variable to another. For this reason, it is also said that Java uses "pass by value" semantics instead of "pass by reference"
> 

### Size and memory

Since a primitive variable stores actual data within itself, the size of a primitive variable depends on the size of the primitive data. In the other hand, a reference variable stores only the address of a memory location, the size of a reference variable depends on the addressing mechanism of the machine.

> All instances of a given class always take exactly the same amount of space in memory, no matter what values its internal variables hold. Thus, there is never a need to calculate the size of memory space taken by an instance of a class at run time. And for this reason, there is no such operator as "`sizeof`" in Java.
> 

At the low level, both reference and primitive variables store binary values. However, the JVM interprets them differently: primitives represent raw data, while reference variables represent memory addresses pointing to objects. 

### Invocation

Another crucial point to understand is that when you invoke a method (or access a field) using a reference, the JVM invokes that method on the actual object referred to by that variable and not on the variable itself. 

> Since primitives are not objects, you cannot "invoke" any method on a primitive variable. But you can perform mathematical (+, -, *, /, and, %), logical ( ||, &&, !, |, and, &), and bitwise(~, |, and, &) operations on the primitive variables themselves.
> 

## Declaration and initialization of variables

### Declaration and definition

Let's clarify these concepts:

- **Declaration**: States the existence of something.
- **Definition**: Provides all the details about it.

```java
class ExampleClass // class declaration
{
	// class definition 
}
```

In terms of variables, Java doesn't have a distinction between declaration and definition because all the information required to define a variable is included in the declaration itself.

However, Java does make a distinction between variable declaration and initialization. Initialization gives a value to a variable.

### Declaration and initialization

Java has several valid ways of declaring and initialization variables:

- Declaration without initialization:

```java
int x;
String str;
int a, b, c;
String s1, s2;
```

- Same time declaration and initialization:

```java
int x = 10;
int y = x;
int a = 10, b = 20, c = 30;
String str = "hello";
ExampleClass obj = new ExampleClass();

int m = 20;
int p = m = 10; // resets m to 10 and asign the new m value to initialize p
```

- A mix:

```java
//a is only declared, b and c are declared and initialized
int a, b = 10, c = 20;
```

And there are some **illegal** ways examples:

```java
int a = 10, int b;//You can have only one type name in one statement.
int a, Object b;//You can have only one type name in one statement.
int x = y = 10;//Invalid, y must be defined before using it to initialize x.
```

> There is no difference in the way of declaring primitive and reference variables. However, reference variables has additional ways of initialization: assigning them to `null`, and calling the constructor method with `new`.
> 

### Uninitialized variables and default values

Uninitialized variables are not allowed in Java — but how this is enforced depends on the context:

- **Instance variables** are given **default values automatically.** Numeric values are initialized by default to `0`, references to `null`, and booleans to `false`.
- **Local variables** must be explicitly initialized before use — otherwise, a **compile-time error** occurs.

 Lets take a deeper view with some examples.

```java
public class ExampleClass {
	int x; // instance variable
	public static void main (String[] args) {
		System.out.printLn(x);
	}
}
```

This will compile since `x` is a local variable, so the compiler will give it a default value.

```java
public class ExampleClass {
	int x; // instance variable
	public static void main (String[] args) {
		int y; // local variable
	}
}
```

This will compile for one reason: the uninitialized local variable is not being accessed. 

```java
public class ExampleClass {
	int x; // instance variable
	public static void main (String[] args) {
		int y; // local variable
		System.out.printLn(y);
	}
}
```

This won't compile since `y` is an uninitialized local variable which is being accessed.

If at any point the compiler realizes that a variable may not have been initialized before it is accessed, the compiler flags an error. This is called the principle of "definite assignment". It means that a local variable must have a definitely assigned value when any access of its value occurs.

However, the compiler cannot execute code, and so, it cannot make inferences based on the result of executing the code. Therefore, the only value that can be taken into account by the compiler during its flow analysis, is the value of the compile time constants. 

```java
public class ExampleClass {
	public static void main (String[] args) {
		int val;
		int i = 0;
		if (i == 0) {
			val = 10;
		}
		System.out.printLn(val);
	}
}
```

This code wont compile. Even if we know that the if condition is always true, the compiler cannot access the actual value of the variable i. Only by declaring `i` as final: `final int i = 0;` the compiler will be able to know the value of `i`, and then, know that the if condition in this case is always true.

## Assigning values to variables

There are different ways of giving value to variables in Java. The most basic way is by using literals `int i = 1` . Also, you can assign a value to a variable by coping it from another variable `int i = j` or by using the return value of a method `int len = example.getLenght()`. 

### **Literals**

As we already mentioned, a literal is a notation for representing a fixed value in source code, such as a digit. 10 will always be 10. 

Literals have a few rules in Java:

1. Java allows underscores in numeric literal for readability reasons (1000000 can be 1_000_000). 
2. Numbers without decimals are considered `int` literals, and with them, `double` **literals.
3. A `long` literal can be written by appending a lowercase or uppercase L to the number (1234L) and a float literal can be written by appending a lowercase or uppercase (1234.5f)
4. A `char` literal can be written by enclosing a single character into single quotes (`'a'`), using the hexadecimal Unicode format (`'\uxxxx'`) or for some special characters, using the scape character (`'\n'`)
5. There are only two boolean literals: `true` and `false`.
6. `null` is also a literal.
7. Java allows numeric values to be written in hexadecimal (starting with `0x` or `0X`), octal ( `0`  +  one or more ocal digits) and binary formats (starting with `0b` or `0B`). 

### Final variables

A final variable is a variable whose value doesn't change once it has had a value assigned to it. In other words, the variable is a constant. Any variable can be made `final` by applying the keyword final to its declaration.

Making a reference variable final, only means that the variable won't be able to refer any other object. It doesn't mean the contents of that object can't change.

> Trying to reassign the value of a final valid will throw compile error.
> 

There are several rules about final variables initialization, but they depend on initializers and constructors which we will explain in future charapters.

## Assignments between variables of different types

There are certain situations in which a variable of one type, can be assigned to another type. We can group those cases into three groups: 

1. Simple assignments involving primitive types
2. Primitive assignments involving mathematical and arithmetical operators
3. Assignments involving reference types.

In this section, we will take a closer look to assignments between primitive types. Here, basically we have three types of conversions: implicit widening, implicit narrowing and explicit narrowing conversion.

### **Implicit widening conversion**

This is the conversion that happens when the type of the value fits into the new one, i.e., when the source type has a smaller range than the destination type. When we need to assign a smaller type to a larger one, no special treatment is required*.* ****For example, there is no problem on making that:

```java
int x = 10;
long y = x;
```

### **Implicit narrowing conversion**

Sometimes, even if the type of the variable doesn't fit into the new one, the value of the variable does. For example, `long x = 10`fits into an int. However, as we already mentioned, the compiler can not access the value of a variable if it is not a compile time constant. Thus, this kind of conversion only happens when assigning from`final` variables:

```java
final long x = 10;
int y = x;
```

### **Explicit narrowing conversion**

It is the only "cast" Java allows. It is made by specifying the target type within parentheses, and can be done in all primitive types but booleans. 

In theory, explicit casts discard the extra bits when the value doesn't fit the target type. However, due to how numeric types are represented in memory (e.g., signed values, two's complement), the result might not be what we expect. This makes casting a potential source of subtle bugs.

> Explicit narrowing can be also made when is no needed. For example, we can  long `a = (long)i` when `i` is an int.
> 

### Assignations between types of the same size

There are certain cases where the assignation is in between different types that have the same size, for example between short and char or int and float.

- Assigning short to char

Both have a 16bits size, but since a char is unsigned and a short is not, their ranges are different. A char can store values from 0 to 65535, while a short can store values from -32768 to 32767.

> As long as there is a possibility of losing information, an explicit casting is needed. Unless with compile time constants in which we already know no information will get lost.
> 

```java
short s = '\u0061'; // OK -> the unicode char '\u0061' is a compile time constant here

char c = -1; // KO -> -1 is constant but doesn't fit into a char

short s = -4;
char c = (char)s; // OK -> explicit cast is present
```

- Float and int, double and long

Similar thing happen here, same size, different ranges. Java will require an explicit cast when assigning floats to ints and doubles to long, but won't require it when it is the reverse operation. Even if in a `int` to `float` assignation there is an information lost.

So we can do this:

```java
int i = 42;
float f = i; // -> implicit narrowing

float f = 1.5;
int i = (int)f; // -> explicit narrowing
```

But not this:

```java
float f = 1.5;
int i = f; // X won't compile 
```

## Assignment on reference variables

As with primitive variables, it is possible to assign a value to a reference variable at the time of declaration itself. This is declaration and initialization in the same scope: 

```java
ExampleClass c1 = null;
ExampleClass c2 = c1;
ExampleClass c3 = null, c4 = c1;
```

It will follow the same rules we already saw, for example, you cannot group different types within a statement, and you cannot initialize undeclared variables:

```java
ExampleClass e, Object c; // KO -> different types
ExampleClass a = b, b = null; // KO -> b is used before declared
```

When initializing a reference variable by creating a reference object, we talk about instantiation. We will get deeper into constructors in the future, but this is a reminder that we will use the `new` keyword + the class constructor.

### Assigning objects to reference variables

Once declared, if not final, a reference variable can be reassigned to point to any other object of the same kind. However, there are some special cases where they can be reassigned to objects of other kinds. 

A brief overview of that will be the following: a subclass can be always assigned to its superclass, but the opposite operation is not allowed. So:

```java
Object o = new ExampleClass(); // valid since ExampleClass is a subclass of object
ExampleClass e = new Object(); // not valid
```

> We are going a bit far with this, but downcasting is possible with explicit casting: **`ExampleClass e = (ExampleClass) new Object();`**
> 

## Local variable type inference

LVTI is not in the certification exam since it was introduced on Java 10, so I won't go so deep. 

By using properly the `var`shortcut, Java compiler can infer the type of the variable we are declaring. For example:

```java
var e = new ExampleClass();
```

The main rules for var use are those:

- `var` can only be used on local variable, this means, inside a method body.
- `var` must only be used when the type can be inferred unambiguously

So, those cases would be invalid: 

```java
class ExampleClass() {
	var a = new Object(); // not a local variable
	int exampleMethod() {
		var b; // uninitialized variable
		var c = null; // cannot infere variable type from null 
		var d = {1, 2}; // can be ambiguous
		var[] e = new int[]{1 , 2}; // var[] is not a valid construction in Java
	}
}
```

Also, it is important to take in count that, even if legal, in some situations using `var` will affect the readability of the code. For example:

```java
var x = getValue();
```

Even if the compiler can infer the type of `x`, it may not be obvious to human readers.
