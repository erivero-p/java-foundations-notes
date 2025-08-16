# What is Java

## Understanding Java

The word Java is also often used to mean different things depending on the context. So, lets have an overview of what Java can mean:

- **Programming language** - with its own set of keywords, syntax and rules.
- **Java Development Kit (JDK) -** A set of tools, such as compiler, debugger and disassembler, useful to write Java code.
- **Java Virtual Machine (JVM) -** a VM that allows running Java on Mac, Linux and Windows. The code will run in the VM independiently of the physical machine's operating system. There is no standard JVM for Android or iOS-based devices.
- **Java bytecode -** the machine language understood by the JVM. Java programs are compiled into bytecode instructions by the Java compiler.

```
					compiler (JDK)                        JVM
Java --------------------> Java Bytecode --------------> Physical Machine Language
```

- **Java Class Library -** A huge library of code for common tasks required by Java applications, including file manipulation, Graphical User Interfaces (GUI), networking, databases, security, multi-threading, etc.  This standard library is called the Java Application Programming Interfaces (Java APIs), and is organized in packages.
- **Java Runtime Environment** (JRE) - It is conformed by the JVM and the pre-compiled collection of the Java class library. It covers the WORA principle (Write Once Run Anywhere), since once a JRE is available on a particular machine, any Java app can be run without any change.

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                                    JDK                                      │
├─────────────────────────────────────────────┬───────────────────────────────┤
│                    JRE                      │   Java Development Tools      │
├─────────────────┬───────────────────────────┤   compiler, debugger,         │
│      JVM        │    Java Library           │   disassembler, analyzer      │
│                 │                           │                               │
└─────────────────┴───────────────────────────┴───────────────────────────────┘

JRE = JVM + Java Standard Class Library
JDK = JRE + Development Tools
```

> All of the above aspects of Java are independent of each other. For example, the Java language can be used on Android applications because even without JVM,  Android provides its own tools and libraries to make the translation.  Also, the JVM can be used in other languages such  as Groovy, Jython, Kotlin, and Scala, by compiling them into Java byte code.
> 
- **Java Platforms -**  a combination of JVM, JRE and JDK, creating different packages for different needs. For example, Java Standard Edition (Java SE) or Java/Jakarta Enterprise Edition (JEE). (Originally Java, now is Jakarta).
- **Java versions** - Java 1.0 was released in 1996. The current version is Java 21. Some versions are considered monumental since they have path-breaking changes, such as Java 5 with Generics, and Java 8 introducing Lambdas.
- **Java Community Process (JCP) -** An independent organization of Java users that develops standard technical specifications for Java technologies, helping to prevent fragmentation.

## Java features

### From management perspective

- **Platform Independent -** Java applications can be developed on one machine and run on another without the need to recompile the code.
- **High performance** - Thanks to advancements in the JVM.
- **Secure** - Built-in security features / Java Security Manager
- **Familiar -** Java belongs to the C/C++ family, borrowing syntax and features from them.
- **Simpler** - Java eliminated several complicated features of C/C++ such as pointer arithmetic, operator overloading, multiple class inheritance.
- **Multiple delivery modes and deployment options** - Java applications can be delivered remotely to client machines in multitude of ways. For example, using Java Web Start technology or through a web browser.
- **Java ecosystem** - Java has a vast number of libraries.
- **Backward compatibility -** Applications with older Java versions can run fine on newer JVMs.

### From technology perspective

- **Compiled** - Java is a compiled language (into bytecode).
- **Variety of technological solutions under one umbrella** - the Java platform includes a variety of technologies for varying needs. For example, AWT, Swing and JavaFX for Desktop applications, Java Server Pages (JSP) for web applications, JPA and Servlet for server side applications, etc.
- **Multithreaded -** Java supports multi-threading.
- **Distributed -** Java allows distributed applications. This has the advantage of using multiple machines by distributing task to them. For example, having a GUI program (client) in one machine, connected to the server in other machine.
- **Garbage Collection -** JVM reclaims unused portions of program memory by removing unused objects.

### From Programming Perspective

- **Object-Oriented** - Java is an Object-Oriented language.
- **Structured** - Java belongs to the family of languages that follow the Structured Programming method. Structured programming involves modularizing large programs into smaller multiple pieces. Other programming paradigms are Procedural and Functional. However, Java borrows features of other programming paradigms, for example, lambda expressions from functional programming.
- **Statically typed -** in Java, a variable and its type must be declared at compile time.
- **Strongly typed** - once declared, a variable cannot point to an object of a different kind.
- **Automatic memory management** - Allocation and liberation are handled by the JVM completely automatically.
- **Programmatic Exception Handling -** Java allows control over the program flow with try-catch blocks.
- **Ready-made class library -** we already talked about Java API.

## Real-world applications of Java

- Desktop applications - Java has been used to develop standalone desktop apps with or without a GUI. Before Java 8, there was a type of small GUI based  Java applications called "Applets", that were loaded in a browser window when the user opened the website containing them, but they were deprecated.
- Distributed applications - Java RMI (Remote Method Invocation) is one of the technologies used to manage communication between distributed components, such as client and server parts of an application.
- Middleware  applications  - There are also other types of middleware, like message brokers and protocol handlers,  that help establish communication between applications. Several of these, including Tomcat, JBoss, and Tibco, are developed in Java.
- Server-side applications - Java has been used to develop purely server-side applications such as Database engines or data analytics platforms.
- Framework and Libraries - Some Java-based frameworks are Struts, Spring and Hibernate.
- Mobile Applications - Before Android and IOs, mobile apps could be developed with Java Micro Edition platform (currently outdated).

## What Java is not

- Not an executable - Java is not compiled into a native executable (like a .exe file). Instead, it produces .class files, which are interpreted or executed by the JVM. In this sense, the JVM is the actual executable.
- No code level security - Unlike native executables, compiled Java code can be easily decompiled into source code, making it easy to replace a class file with a modified (or hacked) one.
- Clunky GUI - GUIs built in Java are worse than native operative system GUIs, and negate the WORA feature of Java.
- Not on mobiles - Java is not directly used on modern mobile operating systems like iOS, and Android does not use the standard JVM, but Java remains a core language for Android development through alternative runtime environments.
