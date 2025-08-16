# Using Loop Statements

We call loop statement to certain statements that make a set of instructions (block of code) be executed repeatedly until a certain condition is reached. Every repetition of execution is called iteration. Loops are a fundamental building block of structural programming. Java has three different statements which you can use to create a loop:  `while`,  `do/while` ,  `for` and `foreach`. 

## The while loop

A while loop executes a group of statements while a condition is true. If the condition is false, the group of statements is not executed and the control goes to the next statement after the while block. The basic syntax of a while loop is as follows: 

```java
while (boolean_expression) {
	statement(s);
}
```

In while loops the condition is always checked before the group of statements is executed. Let's go through an example:

```java
public void loopExampleMethod() {
    int i = 0;
    while (i < 4) {
        i++;
        System.out.println("i is: " + i);
    }
    System.out.println("After the loop i is " + i);
}

```

The output of the code above is the following: 

```
i is 1
i is 2
i is 3
i is 4
After the loop i is 4
```

### Anatomy of the while loop

The while loop is basically composed of two main components: the control condition and the while body.

- **The control condition**

This is the condition that determines whether the loop continues to execute or stops. Usually, the control condition is a simple comparison involving a variable, as in the previous example, but it can also be a compound expression.

The important rule is that the final expression must evaluate to a boolean value.

```java
while (messages[i] != null && messages[i].sender == user) {}
```

It's also possible to perform operations inside the condition itself. The most common ones are increments and decrements. For example, modifying our first example:

```java
public void loopExampleMethod() {
    int i = 0;
    while (i++ < 4) {
        System.out.println("i is: " + i);
    }
    System.out.println("After the loop i is " + i);
}
```

This version changes the output to:

```
i is 1
i is 2
i is 3
i is 4
After the loop i is 5
```

Why is that? Even when the condition fails at `i = 4` and the loop body doesn't run anymore, the increment operation (`i++`) still occurs **before** the condition is evaluated as false, so `i` ends up being `5`.

If instead we used the **pre-increment** operator `++i`, the output would be different because `i` is incremented **before** the check:

```
i is 1
i is 2
i is 3
After the loop i is 4
```

> Be careful with that: Modifying the control variable inside the loop's condition can make the code harder to read and may cause off-by-one errors or unexpected behavior. When possible, keep the control updates inside the loop body for clarity.
> 
- **The while body**

The `while` body contains the statements to be executed in each iteration.

As with `if` statements, if the body has only **one** statement, the curly braces `{}` are optional but  recommended for readability.

Ideally, the loop body should change the control variable (or some other state) so that the condition will eventually evaluate to `false`, ending the loop.

However, sometimes the loop is intentionally designed to run forever.

Example of a basic infinite loop:

```java
while (true) {
    System.out.println("infinite loop");
}

```

> Unlike C, Java does not allow integer values as the while condition, so you can't write an infinite loop as `while (1) {}`.
> 

However, there will be more realistic situations in which an infinite loop is required, for example, for keeping a socket listening: 

```java
Socket clientSocket = null;
While ((clientSocket = serverSocket.accept()) != null) {
	clientSocket.listen(...);
}
```

It is possible to exit out of a while loop without checking the while condition, by using the `break` statement in the while body, but we will talk about it later.

## The do-while loop

A `do-while` loop is similar to the   loop. The only difference between the two is that in a do-while loop the loop condition is checked after executing the loop body. Its syntax is as follows: 

```java
do {  
 statement(s); 
} while(boolean_expression);
```

Since the loop condition is checked after the loop body is executed, it will be always be executed at least once.

The decision of when to use a while loop or a do while loop lies precisely there. Use a `do-while` loop if you need the code inside the loop to be executed before checking the condition. For example, in situations where the initial execution produces the data needed to evaluate wheter to continue looping: 

```java
int bytesRead;
do {
    bytesRead = read();
} while (bytesRead > 0);

```

In this case, `read()` must be called **before** we can decide whether more reading is necessary. A `while` loop would not work as clearly here because the condition depends on the result of the first operation.

> However generally, a `while` loop is considered more readable than a do-while loop and is also used a lot more in practice.
> 

## The for loop

The for loop is the most flexible, complicated and used of all loop statements. The syntax of a for loop is the following:

```java
for (initialization ; condition ; updation ) {
	statements(s);
}
```

> All the three sections of a for statement: initialization, condition updation, are optional, but the semicolon are not. Thus, `for( ; ; );` is actually a valid statement, (and an infinite loop)
> 

### Sections of a for loop

- **Initialization section**

The initialization section allows to specify code that will be executed at the beginning of the loop.   In this section, we can basically find variable declarations or statement expressions. 

> We learnt about statement expressions in chapter 5, but there's a friendly reminder: assignment, increment/decrement, method calls and class instance creations.
> 

A few examples of valid initialization sections: 

| statement | example |
| --- | --- |
| declaration | `int i = 0;` |
| assignment | `k = 1;` |
| post/pre inc/decrement | `i++;` ,   `--i` |
| method calls | `bytes =  read();` |
| instantiation | `Object o = new Object();` |

> It is important to take into account that variables declared in the initialization section of a for loop won't exist outside the scope of the loop.
> 
- **Condition section**

As for while loops, you can only have an expression that returns a boolean or Boolean in this section. If there is no expression in this section, the condition is assumed to be true.

- **Updation section**

Updation section allows only expression statements, similar to initialization section but with no declarations. Generally, this section is used to update the loop variable.

> In initialization and updation sections, more than one expressions are valid, if they are comma separated like that: 
`for (i = 0, j = 10; i < j; i++, j--)`
> 

### **Order of execution**

The parts of a `for` loop are executed in the following sequence:

1. **Initialization section** – executed exactly once before the first condition check (or ignored if empty).
2. **Condition section** – evaluated; if omitted, it is assumed to be `true`.
3. **Loop body** – executed if the condition evaluates to `true`.
4. **Updation section** – executed after the loop body (or ignored if empty).
5. Control returns to step 2: condition check.

Let's transform the `while` loop example we used earlier:

```java
public void loopExampleMethod() {
    int i = 0; // initialization
    while (i < 4) { // condition
        i++; // updation
        System.out.println("i is: " + i);
    }
    System.out.println("After the loop i is " + i);
}
```

Using a `for` loop:

```java
public void loopExampleMethod() {
    // initialization, condition, and updation in the header
    for (int i = 0; i < 4; i++) {
        System.out.println("i is: " + i);
    }
    // System.out.println("After the loop i is " + i);
}
```

Here we have grouped the initialization, condition, and updation in the `for` statement's header.

For this example, the order of execution is the following: 

1. Initialize `i` to `0`
2. Check that `i` is less than `4`
3. Execute the loop body (print the value)
4. Update `i` from `0` to `1` 
5. Check again that `i` is less than `4`
6.  and so on until `i` is 4.

> The last line is commented out because `i` is declared inside the `for` loop, so it does not exist outside its scope. Uncommenting it would cause a compilation error.
> 

## The for each loop

The "enhanced for loop", or  `for-each`loop was introduced in Java 5 to cover a very common necessity in professional Java development: iterate through a collection of objects.

> We will talk about collections in next chapters, the main thing here is that `Collection` is an interface in  `java.util`, which extends the `java.lang.Iterable` interface. Some collections don't even have index, but all of them can be iterated through with an iterator.
> 

The basic syntax of an enhanced for loop is the following: 

```java
for (Type variableName : array_or_Iterable) {    
	statement(s); 
}
```

`Type` is the type of the elements that the array or the collection contains, `variableName` is the local variable that you can use inside the block to work with an element of the array or the collection, and `array_or_iterable` is the array or an object that implements `java.lang.Iterable` interface.

### Using a for-each loop

The **true power** of the enhanced for loop is realized when you combine it with **generics** (also introduced in Java 5).

> Generics are not in the exam scope. A brief overview in this context is that they allow you to specify the type of elements a collection will hold. This makes your code safer and eliminates the need for manual casting when retrieving elements.
> 

Let's first see how a for-each loop looks **without** generics (pre-Java 5 style):

```java
List names = new ArrayList(); // raw type, no generics
names.add("Alice");
names.add("Bob");
names.add(42); // This compiles, but will cause problems later

for (Object obj : names) {
    String name = (String) obj; // Manual cast required
    System.out.println(name.toUpperCase()); // ClassCastException if not a String
}
```

In the code above, we have some problems: the list can store any type of object, thus, you must cast every element to the expected type, and if an element weren´t of the expected type, the program would throw a  `ClassCastException` at runtime.

Now let's see the **same example** using **generics**:

```java
List<String> names = new ArrayList<>(); // generic type parameter <String>
names.add("Alice");
names.add("Bob");
// names.add(42); // ❌ Compilation error: incompatible type

for (String name : names) {
    System.out.println(name.toUpperCase()); // No casting needed
}
```

In this case, generics `<T>` allows us to specify that the type contained by the List are strings `<String>`, so no cast is needed, getting type safety, cleaner code and no potential runtime errors. 

Another detail to take into account when using `for-each` loops is the fact that there's no such a thing as index in them. So if you needed to count the number of iterations you would need to create and manage a variable specially for it. Like that: 

```java
List<String> names = getNames(); 
int i = 0; // index declaration outside the foreach scope
for (String name : names) {
		i++;
    System.out.println("Name number " + i + ": " + name.toUpperCase());
}
```

## Loop control statements and patterns

The following concepts are common for all loops.

### Break and continue

`break` and `continue` are two statements that allows us to alter the flux of a loop.

Whenever the flux gets to a `break;` control will jump outside the loop, skipping any remaining iterations.

The `continue` statement is a bit different. Its purpose is to skip the remaining statements and jump to the next iteration, more concretely, to the condition check phase.

The following is a very silly example, but will help to illustrate: 

```java
for(String student : students) {
	if (!student.isPresent)
		continue ;
	student.greet();
}
```

There's no need to greet an student which is no present, so we can just jump to the next one.

Both of these statements are typically used inside conditional statement**s**. If a `break` or `continue` executes unconditionally, there's no point in writing any code below it since that code would be unreachable. In fact, the compiler will throw an error if it detects unreachable statements after a `break` or `continue`.

### Nested loops

Loops allow nesting, this is, wrapping a loop inside another one. Something important to be cared about is managing the loop variables correctly. It isn't the best practice to nest more than two loops, since variable management gets much complicated.

```java
for (Student student : students) {
    for (Grade grade : student.getGrades()) {
        grade.save();
    }
}
```

We can use `break` and `continue` inside nested loop also, they will just alter the flux inside the loop they are in, not the outer one. However, Java also allows you to break or continue an **outer loop** by using **labels**.

### Labels

A label is simply an identifier you assign to a block of code or a statement that can contain a block (such as loops or conditional statements). Some examples:

```java
SINGLE_STMT: 
    System.out.println("hello"); 

HELLO: 
    if(a==b) 
        callM1(); 
    else 
        callM2(); 

COME_HERE: 
    while(i>=0) {  
        System.out.println("hello"); 
    } 

SOME_LABEL: {  
    //ok, because this is a block of statements  
    System.out.println("hello1");  
    System.out.println("hello2"); 
}
```

> By convention, label names are written in uppercase.
> 

Getting back to our problem with breaking nested loops:  To break out of a nested loop from inside an inner loop, you can use a **labeled break** or **labeled continue**. The label must be placed on one of the loops enclosing the statement.

```java
OUTER_LOOP: 
for (Student student : students) {
    for (Grade grade : student.getGrades()) {
        if (grade.getValue() > 9.9) {
            student.giveHonorRoll();
            break OUTER_LOOP;
        }
    }
}
```

> Although you can use labeled `break` and `continue` in non-nested loops, it's rarely necessary since the unlabeled versions are enough in most cases.
>
