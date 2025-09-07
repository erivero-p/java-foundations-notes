# Debugging and Exception Handling

## Java Exception Handling

Exceptions are for managing exceptional situations. This is, situations where the behaviour is not the expected. Sometimes, we can expect a sort of inconvenience, but not all the cases.
With `if/else` we could try to check every possible situation before acting, but it can become unreadable and hard to maintain. Also, It only allows us to cover situations known at coding time, but not the unknown ones. 

Java exception mechanism is designed to help you write code that covers all possible execution paths that a program may take: the normal expected path, the not expected but known path and a path for unknown exceptional situations. For that, we have `try-catch` blocks.

```java
try {
	// code for normal course of actions
} catch (SecurityException se) {
	// code for known exceptional situation
}
catch (Throwable t) {
	// code for unknown exceptional situations
}
```

## Fundamentals of the try/catch approach

The `try` block contains the expected behaviour, and must be associated to at least one `catch` (or `finally`) block, where we write the resolution of a problem that may occur. When an exceptional situation actually happens, control jumps to the corresponding `catch` block. An exception is considered *handled* when it is caught.
However, a method may also decide **not to handle** the exception itself. In that case, it must declare it in its signature with a `throws` clause:

```java
public void copyFile(String input, String output) throws IOException {
    // tries to copy the file, but if any I/O issue occurs,
    // it throws an IOException to the caller
}
```

If an exception is thrown and not caught, it is **propagated** (bubbles up) to the caller method. That caller can either handle it with a `try-catch`, or declare its own `throws` clause to keep propagating.

> If an exception is never caught in the chain of calls, it eventually reaches the JVM. Since the JVM has no knowledge of the business logic, it “handles” the exception by **terminating the program** (actually, the thread, but for the exam assume program = single thread).
> 

### The  `java.lang.Throwable` object

`Throwable` is the root class of all exceptions. It captures the details of the program and its surroundings at the time it is created. For example, a `Throwable` includes the chain of method calls that led to the exception, which is known as the *stack trace*, and also, any informational message specified by the programmer while creating the exception, which is helping with debugging.

`Throwable` has two direct subclasses, `java.lang.Error` and `java.lang.Exception`, and a huge number of grand child classes, each one meant for a specific situation.

### The  `throw` statement

The throw statement is used by a programmer to "throw an exception" or "raise an exception" explicitly. Throwing an exception implies that the code has encountered an unexpected situation with which it does not want to deal.

```java
public double computeSimpleInterest(double p, double r, double t ){   
	if(t<0) 
		throw new IllegalArgumentException("time is less than 0");  
 //other code
 }
```

> Explicitly throwing an exception using the throw statement is not the only way an exception can be thrown. JVM may also decide to throw an exception if the code tries to do some bad thing like calling a method on a null reference.
> 

### The `throws` clause

The main purpose of the `throws` clause is to ensure that the method either **handles the situation itself** (`try-catch` inside the method), or It **informs the caller** about the possibility of failure, so the caller can decide how to handle it.

```java
public double computeSimpleInterest(double p, double r, double t) throws Exception {
    if (t < 0) throw new Exception("time is less than 0");
    // other code
}
```

In this example, the method explicitly declares that it may throw an `Exception`. This way, whoever calls it knows in advance that it may fail, and must either catch the exception or propagate it further

> While `throw` is used inside the method to actually throw an exception, `throws` is used in the method signature, to declare which exceptions may be thrown.
> 

### The `try` statement

A `try` statement gives the programmer an opportunity to recover from and/or salvage an exceptional situation that may arise while executing a block of code. A try statement consists of a `try` block,  zero or more `catch` blocks, and an optional `finally` block.

> At least a `catch` or `finally` block are mandatory.
> 

```java
try {
	// code that might throw exceptions
} catch(ExceptionClass1 e1) {
	// code to handle exception of type 1 if thrown
}  catch(ExceptionClass2 e2) {
	// code to handle exception of type 2 if thrown
} finally {
 //code to execute after the try block and catch block finish execution
}
```

As you may imagine, the `finally` block code is executed in any situation, and is useful to make recovery operations, but can never catch an exception. 

## Un/checked exceptions and Errors

### Checked and unchecked exceptions

Not all exception need to be explicitly handled .They are called unchecked exceptions because the compiler doesn’t need to check whether piece of code has thrown them. 

**Checked exceptions** represent conditions that are *reasonably expected and recoverable*. The compiler requires that methods either catch them (`try-catch`) or declare them in the method signature with the `throws` clause.

On the other hand, we can say that **unchecked exceptions** are for unexpected situations, in which has no sense on forcing the caller of the method to catch them. For that reason, for unchecked exception is not mandatory to declare them with the `throws` clause in a method signature.

To know whether an exception is considered unchecked or not, look at its inheritance. If it extend `java.lang.Error` or `java.lang.RuntimeException`, will be an unchecked exception. Any other `throwable` child will be checked. 

> Some important children of `RuntimeException` and therefore unchecked exceptions are: `NullPointerException`, `ArrayIndexOutOfBoundsException`, `ArithmeticException`, `ClassCastException`, and `SecurityException`.
> 

### Runtime exceptions and Errors

**Runtime exceptions** usually signal bugs in the code. They happen when the program receives data or enters a state the developer did not anticipate (e.g., dereferencing `null`, accessing an array out of bounds). These exceptions are normally thrown by the JVM itself, not explicitly with `throw`. A well-written program should ideally avoid situations that trigger them. Although technically possible to recover from runtime exceptions, they are not meant to be caught in normal flow — instead, the code should be fixed to prevent them.

**Errors** are similar in nature but even more severe: they indicate critical problems in the JVM’s own operation, such as `OutOfMemoryError` or `StackOverflowError`. Errors are thrown exclusively by the JVM and should never be thrown explicitly by application code. Recovery from them is not realistic, since once the JVM is compromised, the program is unlikely to behave reliably.

In summary, runtime exceptions are unchecked because they generally represent programming mistakes, while errors represent system-level failures. Neither should be caught as part of ordinary business logic; instead, the focus should be on prevention.

## Using try-catch blocks

### Creating a method that throws an exception

Actually, we have been already mentioning the following rules, but just to summarise: 

1. If there’s a possibility of a checked exception getting thrown by the method, the exception or its superclass must be declared in the method signature with a `throws` clause.
2. A method can declare any exception in its throws clause irrespective of whether that method actually throws that exception or not.
3. The requirement to list an exception in the throws clause is applicable only when an exception is thrown out of the method to the caller. If the code inside a method throws an exception but that exception is caught within the method itself, there is no need to declare it in the throws clause of the method.
4. An exception can only be caught by a catch block and not by a finally block.

All of the following are valid examples: 

```java
// 1. Checked exception not caught but declared
public void readFile(String path) throws IOException {
    FileReader fr = new FileReader(path); // may throw FileNotFoundException (checked)
    fr.read();
}
// 2. A method can declare an exception even if it doesn’t throw it
public void doNothing() throws Exception {
    // no exception is thrown here, but it's still valid to declare
}
// 3. If the exception is caught inside, no need to declare it
public void safeDivision(int a, int b) {
    try {
        int result = a / b;
        System.out.println("Result: " + result);
    } catch (ArithmeticException e) {
        System.out.println("Division by zero not allowed");
    }
}
```

### Invoking a method that throws an exception

The rules for invoking a method that throws an exception are similar to the ones for creating a method that throws an exception.

1. Invoking a method that throws a **checked exception** is equivalent (for the compiler) to using `throw`. You must either **catch** the exception or **declare** it in the `throws` clause.
2. If you declare it, you can use the **same exception** or any of its **superclasses**.
3. **Unchecked exceptions** (`RuntimeException` and `Error`) do not need to be caught or declared.

> The decision whether to handle or propagate an exception depends on whether the problem can be resolved at that point in the code. If not, it should be allowed to propagate.
> 

```java
// propagate the exception if cannot be solved
public static void main(String[] args) throws Exception {
    double interest = computeInterest(100, 0.1, -1);
    System.out.println(interest);
}

// handle and log the issue if can be solved
public static void main(String[] args) {
    try {
        double interest = computeInterest(100, 0.1, -1);
        System.out.println(interest);
    } catch (Exception e) {
        e.printStackTrace(); // logs details for debugging
    }
}

```