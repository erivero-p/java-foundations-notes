# Working with the String Class

## Creating Strings

`java.lang.String` is an object created to represent a series of characters. It is a `final` class that extends `Object` and implements `java.lang.CharSequence`. It is a fundamental Java object with quite a special treatment in terms of how are they created, managed and used. 

### **Strings creation with constructors**

`String` has several constructors, but the main ones are the following:

1. `String()` - Creates an empty String.
2. `String(String str)` - Creates a new String by copying the sequence of characters currently contained in the passed `String` or `StringBuilder` object.
3. `String(byte[] bytes)` - Creates a new String by decoding an array of bytes using the platform’s default charset.
4. `String(char[] value)` - Creates a new String so that it represents the sequence of characters contained in the array argument.

> Note that a string is composed of a `char` array but is not one. Therefore, you cannot apply the array indexing operator  `[]` to one String.
> 

### String creation through concatenation

We explained during operators chapter, that the `+` operator is overloaded in such a way that if either one of its two operands is a string, it converts the other operand to a string and produces a new string by joining the two.

Here´s a refresh: If the non-string operand is a reference variable, the `toString()` method is invoked. If is a primitive variable, it will be first wrapped. Finally, if one of the operand is a `null` literal or a null reference variable, the string `"null"` is used instead of invoking any method on it. 

> Is a good practice to overload the `toString()` method in your classes when you design them, to be more meaningful.
> 

Just like the mathematical expression, string concatenation with `+` is also evaluated from left to right.

String concatenation behaviour can be also triggered with the `+=` operator if at least one of the operands is a String. Also, in this case, since the result of the operation is going to be assigned to the left-handed operand, it needs to be a String or a class compatible, like `Object` or `CharSequence`. Otherwise the code won´t compile.

```java
int x = 1;
x += "hello"; // Won´t compile

Object o = 1; 
m += "hello"; // will compile

Object m = "hello"; 
m += 1; // wont compile: m is an object and 1 is an int so conatenation wont be triggered
```

## Using Strings

### Strings with special characters

Java provides "escape sequences" to put such special characters in a String. An escape sequence starts with a backslash (`\`) followed by a letter. For example, if you want to write a new line character in a string, you should write `\n`.

### String interning

Since Strings are object, they are stored in the heap space. However, Java keeps compile time constant strings in a special area of the heap space called "string pool".

The purpose of the string pool is to maintain a set of unique strings. Thus, anytime you create a new string using constant expressions, Java checks whether the same string already exists, and if so, returns a reference to the same String object instead of creating a new one. 

> In fact, when you do `new String("hello");` two String objects are created instead of just one if this is the first time the string `"hello"` is used in the anywhere in program - one in the string pool because of the use of a quoted string, and one in the regular heap space because of the use of new keyword.
> 

```java
String a = "hello";
String b = "hello";
String c = new String("hello");

System.out.println(a == b); // true, both point the same pool object
System.out.println(a == c); // false, c is in heap heap
System.out.println(a.equals(c)); // true, equals() compare content

```

### String inmutability

Strings are immutable. It is impossible to change the contents of a string once you have created it.

Each time we alter a String, what happens is that a new one is created and reassigned to the reference we have. For example:

```java
String s1 = "Hello";
s1 += " world!"; // creates a new "Hello world!" string and make s1 point to it

String s2 = "A";
s2.concat("B"); // concat() returns a new "AB" but is not assigned
System.out.println(s2); // prints "A" since concat return hasnt been assigned and has

s2.toLowerCase(); // a new "ab" string is created

```

## Using the methods of the String class

The String class contains several methods that help you manipulate strings. To understand how these methods work, you may think of a string as an object containing an array of chars internally. Since array indexing starts with 0, Strings do also. And also, any attempts to access an index that is beyond the range of one String will throw `IndexOutOfBoundsException`.

### Methods related to indexes and string length

1. `int length()` - returns the length of this string
2. `char charAt(int index)` - returns the char value in the specified index.
3. `indexOf` and `lastIndexOf` both have two signatures since they can receive an `int` to represent a character, or a `String`. And in all cases return an `int`. They return the index of the first or the last occurrence of the parameter received.

```java
System.out.println("0123".indexOf('2'));                // 2
System.out.println("Hi, How are you?".indexOf("are"));  // 8
System.out.println("/user/ceo/MyClass.java".indexOf('/'));      // 0
System.out.println("/user/ceo/MyClass.java".lastIndexOf("/"));  // 9
System.out.println("/user/ceo/MyClass.java".lastIndexOf(".class")); // -1

```

### `substring`

1. `String substring(int  startIndex, int endIndex)` - returns a new string  that goes from `start` to `end` (excluding end).
2. `String substring(int startIndex)` - the string returned goes from `startIndex` to the end of the original String.

```java
System.out.println("0123456".substring(2, 6)); //prints 2345
System.out.println("0123456".substring(2)); //prints 23456.
System.out.println("0123456".substring(9)); //throws StringIndexOutOfBoundsException
```

### Methods than returns a new string with the required changes

1. `String concat(String str)` - Concatenates the specified string to the end of  `this` String.
2. `String toLowerCase()/toUpperCase()` - Converts all of the characters in this String to lower/upper case. 
3. `String replace(char oldChar, char newChar)` - Returns a new string resulting from replacing all occurrences of oldChar in this string with newChar. 
4. `String trim()` - Returns a copy of the string, with leading and/or trailing white space omitted. 

```java
System.out.println("1234".concat("abcd")); //prints 1234abcd
System.out.println("ab".toUpperCase()); //prints AB
System.out.println("ababa".replace('a', 'c')); //prints cbcbc
System.out.println(" 123 ".trim()); //prints "123" (without the quotes)
```

> One interesting thing about the String manipulation methods detailed above is that they return the same string if there is no change in the string as a result of the operation. So for example, the following affirmation is true:
> 

```java
String s1 = "aaa"; //size of this string is 3 
System.out.println(s1.substring(0,3) == s1);//prints true because the resulting substring is the same as the original string
String s1 = "abcdef";
System.out.println(s1.substring(0,3) == s1); // false

```

It is very common to chain those method invocations:

```java
String str = "  hello ";
str = str.concat("world ").trim().concat("!").toUpperCase(); 
System.out.println(str);
// prints "HELLO WORLD!"
```

### Methods to inspect the content  of a string

1. `boolean startsWith(String prefix)` -  Returns true if this string starts with the specified prefix.
2.  `boolean endsWith(String suffix)`- Returns true if this string ends with the specified suffix.
3.  `boolean contains(CharSequence s)`- Returns true if and only if this string contains the specified sequence of char values. 
4. `boolean equals(Object anObject)`- Returns `true` if the contents of this string and the passed string are exactly same. Observe that the type of the parameter is Object. That's because this method is actually defined in the Object class and the String class overrides this method. So, you can pass any object to this method, but if that object is not a string, it will return `false`.
5. `boolean equalsIgnoreCase(String anotherString)`- Compares `this` String to another String, ignoring case considerations.
6. `int compareTo(String anotherString)` - compares two Strings by alphabetical order, if they are equal will return 0, if `this` is greater will return a positive  value, and if not, a negative one.

> Unlike `==` `equals` and `compareTo`  compare the content of the String object, and not the reference itself.
> 

### `split`

`String[] split(String regex);` It splits the string into an array of strings separating them by the matches with `regex`. It is easy to understand with some examples: 

```java
"Say hi to your friends".split(" ");
// ["Say", "hi", "to", "your", "friends"]
"I don't like you anymore".split("like you");
// ["I don't ", " anymore"]
```

This method can be so powerful because its  argument can be actually a regular expression, but those are not in the exam scope. But i will show some examples:

```java
"a.b.c".split("."); // -> [] because "." is a special regex that means every character
"a.b.c".split("\\."); // ["a", "b", "c"]
```

## Formatting Strings

Besides `System.out.print`/`println`, Java provides more powerful ways to build parameterized messages using **formatting methods**.

### Formatting with `System.out.format` and `System.out.printf`

```java
PrintStream format(String format, Object... args)
```

Both methods work the same, in fact, `printf` is just an alias. `format` is the template string, and  `args` the values to insert into the template. Placeholders are replaced by values at runtime.

```java
String name = "Bob";
String date = "1st Oct 2020";
System.out.format("Hello, %s! Today is %s.", name, date);
System.out.printf("Hello, %s! Today is %s.%n", name, date);
// both prints: Hello, Bob! Today is 1st Oct 2020.
```

### Format specifiers

For the exam scope,  the  three format specifiers you need to know are:

1. `%s` → for Strings (any object can be converted to String).
2. `%d` → for integral values (`byte`, `char`, `short`, `int`, `long`). Using `%d` with incompatible types (e.g. `double` or `String`) throws `IllegalFormatConversionException`.
3. `%n` → line separator (platform independent).

### Rules & Exceptions

The  number of specifiers has to be always minor or equal to the number of arguments. Otherwise, will throw `MissingFormatArgumentException`.

```java
String name = "bob";
int acctNo = 1234;
int points = 100;

System.out.format("Hello, %s!%nYour account %s has %d points.%n",
                  name, acctNo, points);
// OK

System.out.format("Great Job!\n", name);
// Extra argument is ignored

System.out.format("Points worth %d USD.%n", points*10.0);
// throws IllegalFormatConversionException (double with %d)
```

### `String.format`

`String.format` has the same rules as `System.out.format`, but returns a `String` instead of printing it. Will be useful when the formatted text is needed for storage, email, etc.

```java
String msg = String.format("Hello, %s!", name);
System.out.println(msg);
// Hello, bob!
```