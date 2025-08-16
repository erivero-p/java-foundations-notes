# Decision Statements

In Java, we mainly have three ways to make decision statements: using if/else construct, using ternary operators, or with switch cases. We will be covering the three of them in this chapter.

## If/else constructs

Using the if/else constructs, we will use three keywords: `if`, `if else`, and `else`. 

### **`If`**

It is the most basic one, and the only of the three above that can be used alone. It will allows us to execute a single statement or a block of statements only if a particular condition is true.

```java
if ( particular condition occurs) {
	this code will be executed ;
}
```

> In the case of the block of statements, we need to wrap it inside curly brackets, while in the case of a single statement brackets are optional.
> 

### `else`

This statement is called `if-else` statement because `else` can never appear without a previous `if` condition.  What `else` will mean in this case is that, if the `if` condition is not true, the statement or block in the `else`'s scope will be executed.

```java
if ( particular condition occurs) {
	this code will be executed ;
} else {
	in any other condition this will be executed ;
}
```

Since empty statements are valid in Java, the following `if-else` construct will be valid two: 

```java
if (condition) ; // does nothing
else {
	// execute code when condition is not true
}
```

> `else` statements without a previous `if` condition won't compile.
> 

### `else if`

Same as `else`, it needs to be preceded of an `if` statement. `else if`statement makes clear that all the previous conditions must not be true before evaluating the `else if` condition. 

```java
if ( particular condition occurs) {
	this code will be executed ;
} else if (previous condition is false, and new one is true) {
	this code will be executed ;
} 
```

It can be also used with an `else` statement that must be always the last one, to cover any of the other situations.

A very illustrating example is the fuzzbizz function. It must print fizz if the number is a multiple of three, buzz if is a multiple of five, fizzbuzz if its multiple of both or the number if it is not multiple of none. 

Let's see it with pseudo code:

```java
if ( %3 and %5) {
		print fizzbuzz ;
} else if ( %3 ) { // if %3 and not %5
	print fizz ;
} else if ( %5 ) { // if %5 and not %3
	print buzz ;
} else {
	print the number ;
}
```

If we weren't using the `else if` conditions and only `if`, in the case of 15, for example, which is a three and five multiple, the function would print: fizzbuzz, fizz and buzz. 

### Some tricky details

There are some tricky cases for the exam: 

- Tricky indentation

Unlike other languages such as Python, indentation has no special meaning in Java. It has more a readability purpose. Thus, the following code is valid: 

```java
if (conditionA)
executeA();
else
executeB();
```

Same way, this code won't compile:

```java
if (conditionA)
	executeA();
	printA();
else
	executeB();
```

Since indentation has no meaning, the `printA();` statement is not in the scope of the `if` condition. Thus, the else statement is completely out of place cause is not associated with the `if`, and will throw compile error.

- Dangling else

There will be some cases in which the else association to an if is ambiguous. For example: 

```java
int value = 3; 
if(value == 0) 
if(value == 1) 
System.out.println("b"); 
else System.out.println("c");
```

The code above can be interpretated  in two valid ways: 

```java
int value = 3; 
// first interpretation
if(value == 0) {
	if(value == 1) {
		System.out.println("b"); 
	}
} else {
	System.out.println("c");
}

// second interpretation
if(value == 0) {
	if(value == 1) {
		System.out.println("b"); 
	} else {
		System.out.println("c");
		}
}
```

To solve ambiguity, Java designers decided to break the tie by making `else` being associated always to the closer `if`. Thus, in the previous example, the chosen interpretation would be the second one. And the code won't print nothing as `value` is not equal to 0. 

- Assignment statements inside the `if` condition

In Java it's valid to make assignments inside the conditions, thus the following code  will compile:

```java
boolean flag = false;

if(flag = true) { 
  System.out.println("true"); 
} else { 
 System.out.println("false"); 
}
```

However, the tricky question here is that since flag is not being compared to true, but assigned to it, the value of the condition is the result of making the assignment, which is true. The following is a more clarifying example:

```java
String data = null;
if ((data = getData()) != null) {
	printData(data);
}
```

> Same as assignations pre and post increment and decrement operations can be done inside the if conditions. v.e., `if (x++ > 5) {}`.
> 

## Ternary constructs

We won't get way deep into ternary construct since they are not mentioned in the exam topics, but here we go: 

The syntax of the ternary operator is as follows: 

```java
operand 1 ? operand 2 : operand 3; 
```

Operand 1 must be an expression that returns a boolean. The boolean value of this expression is used to decide which one of the rest of the two other operands should be evaluated.  If the boolean expression given in operand 1 returns true, the ternary operator evaluates and returns the value of operand 2 and if it is false, it evaluates and returns the value of operand 3.

> The ternary operator only evaluates one of the two branches depending on the condition, which is similar to short-circuit evaluation.
> 

### Ternary vs if/else

We already mentioned in a previous charpter that ternary operators work as a short form of the if/else statement. However there's a fundamental difference: a ternary operation is just an expression while an if/else statement is a statement. So, as expressions, they must always have a value. 

> Since the value of a ternary expression is the value returned by the second or the third operand, they both must have their own values.
> 

For example, given `boolean flag = true;`, the following if/else statement:

```java
if (flag) {
	System.out.println("true");
} else {
	System.out.println("false");
}
```

Can't be written into ternary operators like this:

```java
flag ? System.out.println("true") : System.out.println("false");
```

Why is that? The code won't compile for two reasons: 

- Since ternary expressions are not valid statements on its own, they need to be part of a valid statement such as an assignment. For example `int res = operand 1 ? operand2 : operand3;`
- System.out.println() is a void method. Thus, the second and third operands have no value, and therefore they are not valid expressions.

### The return type of ternary expressions

Ternary expressions can return boolean, numeric and reference variables. Following these rules: 

- If the second and the  third operands are boolean (or Boolean), the return type is boolean.
- If they both are numeric types or their wrapper classes, the return type will be the wider of the two numeric types, following the numeric promotion rules.
- Else, the return type will be a reference.

This last case is a bit special. For example, we can have mixed a numeric type and a reference. The following is a valid ternary expression: 

```java
Object obj = a == b ? 5 : "hello";
```

The second operand is an `int` and the third one is a `String` . Since the `int` can be wrapped into an `Integer`, if the condition of the first operand were true, the return value would be an `Integer` object. We can assign the return value of the expression to an Object, which is the common parent of all reference variables.

## Switch statements

A switch statement allows you to use the value of a variable to select which code block/s out of multiple code blocks should be executed. Here is an example:

```java
public class ExampleClass {
	public static void main(String[] args) {
		int i = args.length;
		
		switch(i) {
			case 0: System.out.println("No arguments");
							break;
			case 1: System.out.println("One argument");
							break;
			case 2: System.out.println("Two arguments");
							break;
			default: System.out.println("Too many arguments");
							break;																			
		}
	}
}
```

In the example above there are four blocks of code, each one is associated with one particular case label. Operationally, switch cases appear to be quite similar to cascaded if/else, in fact, the example code could be reproduced perfectly with an if/else cascade:

```java
public class ExampleClass {
    public static void main(String[] args) {
        int i = args.length;
        if (i == 0) {
            System.out.println("No arguments");
        } else if (i == 1) {
            System.out.println("Only one argument");
        } else if (i == 2) {
            System.out.println("Two arguments");
        } else {
            System.out.println("Too many arguments!");
        }
    }
}

```

However, if/else cascades tend to be verbose, and switch statements help with readability. But also, they have very special particularities. Let's take a closer look.

### The switch statement

Unlike `if/else` statements, which only evaluate booleans, a `switch` statement can evaluate different types of expressions.

The **expression evaluated by the `switch`** can be one of the following types:

- Integral types smaller than a `long` (`byte`, `char`, `short`, `int`)
- `enum` types
- `java.lang.String` (introduced in Java 7)

Although it's common to use a single variable as the expression evaluated by the `switch`, you can also use more complex expressions.

For example:

```java
switch (i + 2) { }
```

> As with all Java expressions, it follows the usual rules of numeric promotion, casting, and operator precedence.
> 

### The case labels

Case labels must consist of compile time constants that are assignable to the type of the switch expression. This means that if the switch expression is of type `byte`, the case labels must be compile-time constants within the `byte` range; variables or constants outside that range are not allowed.

Case labels are optional, a valid switch statement may not include them: 

```java
		switch(i) {
			default: System.out.println("hello world!");																
		}
```

### The default block

There can be zero or one default blocks in a switch statement. The purpose of the default block is to specify a block of code that needs to be executed if the value of the switch expression does not match with any of the case labels.

If none of the case labels

Interestingly, is not mandatory to place the default block at the bottom of the switch statement. However, how we order the cases will affect the code flux, in combination with the use of the `break` statements. 

### The break statement

The case labels determine the entry point into a switch, and the break statement determines the exit. So, the moment one of the cases is met, the code block inside it will be executed until a `break` is found. 

However, break statements are also optional. What happens if there's no break at the end of the block of code inside a case label? The next cases will be entered as well. 

> This is called "fall through" behavior of a switch statement. In absence of a break statement, the control falls through to the next case block and the next case block, and so on until it reaches the end of the switch statement.
> 

If we go back to our example, and avoid using break statements we have the following: 

```java
public class ExampleClass {
	public static void main(String[] args) {
		int i = args.length;
		
		switch(i) {
			case 0: System.out.println("No arguments");
			case 1: System.out.println("One argument");
			case 2: System.out.println("Two arguments");
			default: System.out.println("Too many arguments");
		}
	}
}
```

If the number of arguments were, for example, 1, this would be the output:

```java
One argument
Two arguments
Too many arguments
```
