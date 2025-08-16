# Basic Java Elements

## Conventions

Some of the most important conventions in Java are as follows:

- **Cases** - Java uses Camel Case with some details:
    - Class names start with uppercase letter.
    - Package names are generally in all lowercase.
    - Variable names start with a lower case
- **Naming** - Names should be meaningful.
- **Package names** - use a reverse domain name combined with a group name and or application name. For example: `com.talan.bankapp.customers`

## Java Identifiers and reserved words

### Identifiers

Java defines an identifier as an unlimited-lenght sequence of Java letters of Java digits, always starting with a letter. Identifiers will be words with specific meanings assigned by the developers in a program. However, there are some words that can't be assigned, those are called reserved words.

### Reserved words

It is an umbrella term which includes all the kinds of words that can't be used to refer something else in our Java programs.

- **Keywords -** Words with n special meaning in the Java language. They trigger predefined actions on the compiler.
- **Literals -** words interpreted by the java compiler literally. For example, `true`, `false`, `null`, and also numeric values.
- **Prohibited words** - not keywords, not literals, but also restricted. `goto`is an example.

Excepting literals, here goes a list with the Java Reserved Words:

| abstract | continue | for | new | switch |
| --- | --- | --- | --- | --- |
| assert | default | if | package | synchronized |
| boolean | do | goto¹ | private | this |
| break | double | implements | protected | throw |
| byte | else | import | public | throws |
| case | enum | instanceof | return | transient |
| catch | extends | int | short | try |
| char | final | interface | static | void |
| class | finally | long | strictfp | volatile |
| const¹ | float | native | super | while |
| _ (since Java 9) |  |  |  |  |

### Summary of important Java Keywords

- `class`, `Interface` and `enum`, to define reference types.
- `new` to instantiate objects of a class.
- `if` and `else` to create decision statements.
- `switch`, `case`, `default` and `break` to more complex decision structures with multiple paths.
- `for`, `while`, `do`, `break` and `continue`: to create loops.
- `package` and `import` for classes organization.
- `public`, `private` and `protected`: the three access modifiers to achieve encapsulation.
- `extend` and `implements`: to create inheritance   relationships. (also known as "is-a" relationships)
- `boolean`, `byte`, `char`, `short`, `int`, `long`, `float`, and `double`:  the primitive data types.
- `super` and `this`: to reference the instance or the parent of an instance.
- `return`: to define the return value of a method.
- `static`: to define class member that belong to the class and not the instances.
- `throw`, `try`, `catch`, `throws`: for exception handling.

## Create and import packages

### The package statement

Every Java class belongs to a package, and cannot belong to more than one, so, there can be at most one package statement in a source file. It must be the first statement in the file.

If there is no package statement in a file, the classes defined in that file belongs to an unnamed package also known as the *default* package. However, there is not a real package called "default".

> Since the unnamed package has no name, it is not possible to be referenced, so its classes (named "unpackaged classes") won't be available to be imported by other package's classes.
> 

### The import statement

To refer a class in another package, it is necessary to use its *fully qualified class name* (FQCN). It is basically the package name + dot + the class name. By using the import statement in a source file, the imported class can be referenced using only its short name. 

So, the word "import" is a misnomer here, you're not importing anything, it is more like using an alias, telling the compiler where to look for the classes.

> Since we use imports as a shortcut, if two classes with same name but different packages want to be used in the same source files, it makes no sense to import them. We will need to use theirs FQCN each time.
> 

Some details to take in count with imports: 

- All classes in a package can be imported with a wildcard: `*`. However this isn't the best practice.
- Duplicating imports won't cause compile error.
- java.lang package is imported automatically in all the classes.
- Importing non existing packages or classes will raise compile error.
- To import static members of a class we can use `import static` statement.
- There is no way to import a "subpackage", in fact, there's no concept of subpackage in Java. It is illegal to do `com.example.*.*`.

> In Java, packages are not hierarchical in terms of access. That is, `com.example` and `com.example.utils` are independent packages
> 

## Advanced compilation and execution

Once packages are involved, compilation changes a bit. By default, the Java compiler compiles the Java source file and puts the class file in the same folder as the file. But the Java command that launches the JVM expects the class file to be in a directory path that mimics the package name. 

The `javac` command supports the `-d` option, useful to direct the compiler to create the directory structure as per the paclage name of the class, and put the class file in the right place. Then, at time of execution, you can use the`-classpath` or `-cp` option to tell the JVM where to find the class meant to be executed.

### Compiling multiple source files into one

When one class depends on another imported class, both classes must be compiled to avoid errors. In bigger projects, we can compile all the files at the same file using wildcards `javac -d *.java` the  `-d`option in this case is even more important.

### Packaging classes into Jar

Managing one file is much easier than handling many. In large applications with hundreds of class files, Java provides the **JAR (Java Archive)** format to bundle all compiled classes into a single file, similar to a `.zip`.

A JAR maintains the **package structure**, so if `Account.class` belongs to the `accounting` package, it will be stored inside an `accounting/` folder in the JAR. JAR files can also include a **manifest file** (`MANIFEST.MF`) inside the `META-INF` directory, which stores metadata.

To make a JAR directly executable, the manifest must define the main class:

```bash
Main-Class: accounting.Account
```

You can manually write this in a file like `mymanifest.txt`, then package everything with:

```
jar -cvfm accounting.jar mymanifest.txt accounting
```

This avoids needing to specify the class with the `main` method on the command line.

## java.lang package

`java.lang` is one of the packages in the Java standard library.

As we have already mentioned, it has the particularity of being automatically imported, without the need to be declared explicitly.

The most important class in the `java.lang` package is the `java.lang.Object` class. This is the root class: the parent of all other classes in Java. In fact, if a class doesn't explicitly extend another class, it implicitly extends `Object`. Except for primitive types, everything is an object in Java.

Apart from `Object`, the `java.lang` package includes other essential classes such as `Math`, which offers computational operations like rounding decimals, exponentiation, trigonometric functions, and logarithms.

The `System` class is also part of `java.lang`. It allows printing output to the console. Among other members, the `System` class has a static variable named `out`, which is of type `PrintStream`, and provides methods like `print` and `println`.

They are not in the certification exam, but other important packages of the Java Standard library are:

| Package Name | Purpose | Important classes |
|--------------|---------|-------------------|
| java.lang | Provides classes that are critical for the functioning of any Java program. | Object, Math, System, Runtime, wrapper classes. |
| java.io | Provides classes for performing input and output (I/O) activities involving files and other I/O devices. | InputStream, OutputStream, FileReader, FileWriter |
| java.net | Provides classes for performing network communication. | Socket, ServerSocket |
| java.sql | Provides classes for dealing with Databases. | Connection, Statement, ResultSet |
| java.util | Provides tools and utility classes for creating commonly used data structures, internationalization, date handling. | Collection, List, ArrayList, HashSet, HashMap, Date, Locale |
| java.awt and java.swing | Provides classes for building Graphical User Interfaces (GUI) | Frame, Dialog, Button, ActionEvent, LayoutManager |
