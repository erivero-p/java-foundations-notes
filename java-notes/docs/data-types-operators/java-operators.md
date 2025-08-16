# Working with Java Operators

Java has a large number of operators, that can be classified based on the operations they perform (arithmetic, logical, …) or the number of operands they require (unary, binary and ternary). 

## Arithmetic Operators

Arithmetic operators are used to perform standard mathematical operations on all primitive variables except boolean. They can also be applied to wrapper objects for numeric types due to auto-unboxing. In this group we will find binary operations, but also unary ones.

- **Binary arithmetic operators**

Here we have addition (`+`), subtraction (`-`), multiplication(`*`), division (`/`), and modulus (`%`) operations.

- **Unary arithmetic operators**

The `-` operator can also be used in unary operations in the following form: `a = -b;` what is does is returning the negated value of a literal or a variable. Thus, it is a "-1" multiplication. The unary `+` operator is legal but has no effect; it returns the value as-is.

```java
int a = -10; // '-' operator applyied to a literal
int b = -a; // b = 10 in this case
```

Also, decrement and increment operators are considered arithmetic binary operators, but lets give them a whole section.

### Increment and decrement operators

Increment (`++`) and decrement (`--`) operators can only be used on variables, not literals, and they not only return a value but also mutate the variable itself. Also, they have the particularity of being able to be applied before as well as after the variable.

Prefix and postfix operators work in a very similar way, since both change the value of the variable. The difference between the two is that the postfix operator returns the existing value of the variable while prefix operator returns the updated value of the variable. 

Lets illustrate this with examples. In the following, `i` increments its value after being accessed.

```java
int i = 0; 
System.out.println(i++); // this prints 0;
System.out.println(i); // this prints 1;
```

However, if we use the preincrement operator instead of the post one, the value of `i` will be incremented before accessing to it:

```java
int i = 0; 
System.out.println(++i); // this already prints 1;
System.out.println(i); // this also prints 1;
```

## Comparison or relational operators

Relational operators are used to compare integral and floating point values. They can also be applied to wrapper objects for these types due to auto-unboxing.

There's no unary comparison operators for obvious reasons. I will make a subdivision here: 

### `< > <= =>`

Less than (`<`), greater than (`>`), less than or equal to (`<=`) and greater than an equals to (`>=`) operators only work on numeric types and return a boolean value.

## `== !=`

On the other hand, equal to (`==`) and not equal to (`!=`) operand work on all primitive types (including booleans) and also in reference types. They can be even used to make comparisons between a primitive variable and a wrapper. In that case, it will compare the values of both. 

```java
int i = 1;
Integer y = 1;
bool comp = i == y; // this will be true
```

> Java doesn't allow comparisons between a primitive and a reference if the reference is not a compatible primitive's wrapper.
> 

You cannot compare a numeric value and a non-numeric one, neither two references of different types. Thus, all those examples won't compile:

```java
System.out.println(10 == false); //can't compare a number with a boolean
Object obj = new Object(); 
System.out.println(obj != 10); //can't compare a reference with a number
System.out.println(obj == true); //can't compare a reference with a boolean
Integer INT = 10; Double D  = 10.0; 
System.out.println(INT == D);//can't compare an Integer reference with a Double reference
```

When used on references, `==` and `!=` check whether the two references point to the same object in memory or not.

## Logical operators

Logical operators are used to form boolean expressions using boolean variables and values.

### Short circuiting operators

They are called short circuiting operators because they avoid evaluating parts of an expression if the value of that part does not make any difference to the final value of the expression. In that sense, the evaluation of the second operand is "conditional". It is evaluated only if it is required.

Here we have two binary operators: short circuiting 'and' `&&` which will return true only if the two operands are true, and false in the remaining cases, and short circuiting 'or' `||` which will return true if at least one of the two operands are true. 

### Non-short circuiting operators

The following are actually bitwise operators when used with numeric types, which is their main purpose, but also can be used with booleans as logic operators.

I won't extend on their bitwise aspect since it is not in the exam scope but here is more info:

 https://github.com/erivero-p/42-Tutorials/tree/master/Bits%20For%20Dummies

Here we have another version of 'and' `&` and 'or' `|`. The only difference between the previous ones is that they do not short circuit any part of an expression. This behavior is useful in cases where parts of an expression has side effects that you do not want to avoid even if their value is irrelevant to the final value of the expression. 

For example, in this case:

```java
boolean accessGranted = authenticate(user.credentials) & logToAudit(user.name);
```

Even if `checkCredentials` return false, and therefore the `accesGranted` bool is false, you may want to log the authentication try. With an `&&` operation, the second method wouldn't be called.

Operator `|` is also known as inclusive or, since it accepts the true-true and the true - false situations. On the other hand there's the Xor or exclusive or operator `^`. It will return true only if exactly one of the operands is true.

### Non-binary logical operators

Here we have two more logical operators:

- Negation `!`

Negation operator is unary, and returns the compliment of given a boolean value.

- Ternary operators `:?`

They are kind of a short form of the if-else statement. They evaluate either the second or the third operand depending on the value of the first one. For example, the following expression:

```java
if (len == 0) {
	res = "empty";
} else {
	res = "full";
}
```

can also be expressed like that:

```java
res = len == 0 ? "empty" : "full";
```

## Assignment operators

Assignment operators are used to assign the value of an expression given on the right-hand side to a variable given on the left-hand side. There are twelve of them in total, all of them are binary.

### **Simple assignment operato**r `=`

It simply copies the value on the right to the variable on the left. In case of primitive values, it is the value of the primitive that is copied and in case of references, it is the value of the reference (not the actual object pointed to by the reference) that is copied to the variable on the left.

### Compound assignment operators

`*=, /=, %=, +=, -=, <<=, >>=, >>>=, &=, ^=, |=` 

They perform an arithmetic or bitwise operation and then assign the result of the operation to the variable on the left. These operators work only on numeric types (primitives as well as wrappers).

> Compound assignment operations cannot be done in declarations. The statement `String str+= "test";` will not compile since `str` is being declared in this statement.
> 

The operations they perform can be mentally expanded for a better understanding. 

For example, given the following code:

```java
byte b1 = 8;
b1 *= 2; // b1 is now 16
```

Can be unwrapped in the following:

```java
b1 = (int) (b1 * 2);
```

We will talk about this cast later. 

### Assignment operators details

They are quite simple, but there are a few nuances about assignment operators: 

1. They are all right associative, which means a = b = c = 10; will be evaluated as a = (b = (c = 10) ) instead of ((a = b) = c) = 10. We will talk about it later.
2. The left-hand operand of the operation must be a variable. It cannot be a literal or a method call.
3. The right-hand operand of these operators must be an expression whose type must be the same as or "compatible" with the type of the target variable on the left.

## Other Operators

### Access Operators

Here we have two more operators: 

- `.`

The dot operator is applied to a reference to access the members of the object pointed to by that reference. It will always throw a NullPointerException if you apply it to a null reference

- `[]`

The array access operator is used to access the elements of an array.

### Miscellaneous

- `instanceof`

Binary operator  used to check whether an object pointed to by a reference variable given on the left is of the type given of the right of this operator.

```java
ExampleClass obj = new ExampleClass();
boolean res = obj instanceof ExampleClass; // -> true
boolean isString = obj instanceof String; // -> false
```

- `()` - Cast operator, already mentioned.
- `->` the lambda operator, not in the exam scope.

### `+` and `+=` for String concatenation

Those two operators are overloaded to be used for String concatenation. 

To trigger the String concatenating behaviour of the `+` operator, the declared type of at least one of its operands must be a String. If one of the operands is a String and the other one is not, the other operand will be converted to a String first and then both the operands will be concatenated to produce the new String.

> The non-string member can be converted into String since all classes in Java extends implicitly from `Object`, which has a `toString()` method. Also, primitive types will be firstly wrapped into their wrapper classes before being converted into strings.
> 

Thus, in terms of polymorphism, the `+` operator has several forms.

- Usual behaviour when the two operators are numerics.
- Calling `toString()` when one of them is not a String but another reference variable.
- Wrapping the variable if its a primitive one before calling `toString()`.
- And a last trick: if the reference is null, the `+` operand won't invoke `toString()` in order to not throwing `NullPointerException`. Instead, it will take "null" as a String.

The `+=` operator can be used as well for String concatenation and assignation. The only think to take into account is that, in this case, the left-hand member of the operation must always be a String.

## Understanding expressions and type behaviour

### Expressions and Statements

Understanding the concepts of expressions and statements will be useful to have a good perspective on how and why the operators works. 

An expression is a combination of one or more explicit values, constants, variables, operators and functions that the language interprets and computes to return another value. So the main point is that an expression has a value.

A statement, on the other hand, is a complete line of code that may or may not have any value of its own. 

> the return values of the expressions can be combined each others using operators, to create bigger expressions. Statements cannot be combined to conform bigger statements. The succession of various statements will conform functions, programs, etc.
> 

Lets see some examples to illustrate both of them. Given the following code: 

```java
exampleMethod() {
	int a;
	int b = 10;
	a = 20;
	
	a + b // wont compile
	a = a + b;
}
```

- Statements but no expressions: The three first lines of the method, are statements, but they are no expressions since they don't have a value. For example, you cannot assign `int b = 10` to a variable.
- Expression but no statement: `a + b` itself has a value, so it is an expression, but is not a valid statement.
- Both expression and statement: The last of the lines is a valid statement, and also is  an expression which in fact, is a combination of smaller expressions (`a`and `a + b` combined with the operator `=` and also `a` and `b` combined with `+`).

> In Java, there's something called *expression statement* which are expressions that can stand as a statement on its own and produces an effect, such as: assignment, increment and decrement, method calls and class instance creations with `new`.  Not all expressions can be used as expression statements (for example, `a + b;` is invalid).
> 

### Numeric promotion and casting

Java applies the rules of numeric promotion while working with operators to deal with numeric values. Those rules are the following:

1. Unary numeric promotion: If the type of an operand to a unary operator is smaller than `int`, the operand will automatically be promoted to `int` before applying the operator.
2. Binary numeric promotion: Both operands are promoted to an `int` but if any of them is larger than an `int`, the other operand is promoted to the same type of the larger one.

> A direct implication of the rules above is that the result of applying an operator to numeric operands is never gonna be smaller than an `int`.
> 

Lets illustrate it. The following examples won't compile:

```java
byte b = 1;
short s = -b;
// error: incompatible types: possible lossy conversion from int to short
```

```java
short a = 1;
short b = 2;
short c = a + b;
```

In both cases the `shorts` are being promoted to `int` by the operators `-` and `+`. It can also happen with bitwise operators (`c = a << 1`, for example). 

In order to make the code compile in these situations, we can explicitly cast (assuming the risk of losing information). 

```java
short a = 1;
short b = 2;
short c = (short) (a + b);

double d =  1.0;
float e = 1.0f;
float f = (float) (d + e);
```

> An exception: the rules of numeric promotion don't apply to increment`++`, decrement `--`, and compound assignment (`+=`, `*=`, etc) operators. Thus, no cast is needed in their cases.
> 

These rules come into picture only when the operands involve at least a variable (numeric primitive or its wrapper class), as for casting rules we already saw, if all the operands involved are compile time constants, the compiler will be able to check if the result of the operation lies within the range of the target variable. However, be careful with final reference variables, since the values they wrap are not constants.

### Operator precedence and evaluation of expressions

- **Precedence**

As in mathematical expressions, Java expressions have a hierarchy order. They, in fact, follow a very similar order than the BODMAS rule we learn in mathematics (Brackets/Parentheses, Orders/Exponents, Division, Multiplication, Addition, and Subtraction). 

This, is called precedence, and determines which operator out of two is evaluated first. Another way to see it is how tightly an operator binds to its operands. For example, in the following case: `2 + 6 / 2` we can say that, since the `/` operator has higher precedence, 6 will be strongly bound to it than to the `+` operator.

The following table shows the precedence of all Java operators:

| Precedence (High → Low) | Operator Name | Operators | Associativity |
| --- | --- | --- | --- |
| 1 | Array access, object creation, member access, method reference | `[]`, `new`, `.`, `::` | Left to Right |
| 2 | Postfix | `expr++`, `expr--` | Left to Right |
| 3 | Unary and pre-increment/pre-decrement | `+expr`, `-expr`, `!`, `~`, `++expr`, `--expr` | Right to Left* |
| 4 | Cast | `()` | Right to Left* |
| 5 | Multiplicative | `*`, `/`, `%` | Left to Right |
| 6 | Additive | `+`, `-` | Left to Right |
| 7 | Shift | `<<`, `>>`, `>>>` | Left to Right |
| 8 | Relational | `<`, `>`, `<=`, `>=`, `instanceof` | Left to Right |
| 9 | Equality | `==`, `!=` | Left to Right |
| 10 | Bitwise AND | `&` | Left to Right |
| 11 | Bitwise exclusive OR | `^` | Left to Right |
| 12 | Bitwise inclusive OR | | | Left to Right |
| 13 | Logical AND | `&&` | Left to Right |
| 14 | Logical OR | `||` | Left to Right |
| 15 | Ternary | `? :` | Right to Left* |
| 16 | Assignment | `=`, `+=`, `-=`, `*=`, `/=`, `%=`, `&=`, `^=`, ` | =`,` <<=`,` >>=`,` >>>=` |
| 17 | Lambda and switch expression | `->` | Right to Left* |

This explain why the following code won't compile:

```java
int i = 1;
byte b = (byte)i + 2;
```

Since the cast operator has higher precedence that the `+` operator, `i` first cast to byte and then, for the addition to be performed, `i` is promoted to `int`. The addition result is, therefore, an `int`, which is tried to be fit into the byte `b`. How to solve it? altering natural *associativity*  with parenthesis. But first, lets understand what does it mean.

- **Associativity**

Associativity of operators determines the grouping of operators when an expression has multiple operators of same precedence. For example: the value of the expression `2 - 3 + 4`  depends on whether it is grouped as (2 - 3) + 4 or as 2 - (3 + 4). The first grouping would be used if - operator is left-associative  and the second grouping would be used if - operator is right-associative

Most of the operators in Java are defined to be left-associative. The notable exceptions are the assignment operators, the ternary operator, and the lambda and switch expression operators.

- **Parentheses**

Parentheses can be used to alter how an expression is grouped. In the previous cast example, in order to make it compile, we can do the following:

```java
int i = 1;
byte b = (byte) (i + 2);
```

This way, the `byte` cast will be performed to the result of the `i + 2` expression.

- **Evaluation order**

Once an expression is grouped in accordance with the rules of precedence and associativity, the process of evaluation of the expression starts. In Java, expressions are evaluated from left to right. Given the following expression:

```java
getA() + getB() + getC();
```

The method `getA()` will be the first on being called, followed by `getB()` and `getC()`.

Java also makes sure that operands of an operator are evaluated fully before the evaluation of the operator itself. Obviously, you can't compute `getA() + getB()` unless you get the values for `getA()` and `getB()` first.

> An important detail here is that evaluation order of an expression can't be altered with parenthesis. Thus, in `getA() + (getB() + getC());` the evaluation order will still be the same.
>
