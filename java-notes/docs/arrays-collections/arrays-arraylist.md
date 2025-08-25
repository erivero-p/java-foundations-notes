# Arrays and ArrayLists

## Declaration and instantiation of Arrays

An array is an object that holds a fixed number of values of a given type. This means they can only store elements of that type (or compatible types, in the case of objects).

Arrays can be **unidimensional** or **multidimensional**, and they allow duplicate values.

### Array declaration

Array declaration in Java is done by appending square brackets `[]` to the variable type. Since they can have multiple dimensions, each dimension is represented by a pair or brackets. The typical syntax is the following:

```java
int[] unidimensional;
int[][] bidimensional;
```

However, Java also allows applying the brackets to the variable name instead. So the following are also valid declarations:

```java
int unidimensional[];
int bidimensional[][];
int[] alsoBidimensional[];
// and mixed
int[] uni, bi[];
```

> It is not valid to specify the array size at declaration. Thus this `int[2] a;` won’t compile.
> 

Array of objects are declared the same way. Some valid examples would be:

```java
Object[] o;
String[] unidimensional, bidimensional[];
```

All statements shown above only declare but don’t actually create arrays. Let’s talk about creation.

### Arrays creation and initialization

There are two main ways to create arrays: **array creation expressions** and **array initializers**.

- **Array creation expressions**

An array creation expression basically consists on the keyword `new` followed by the type and the size in square brackets like this:

```java
int a[] = new int[10];
String[] b = new String[5];
```

These expressions allocate space to hold the specified number of variables of the specified type. Also, the JVM will initialize the values to its defaults automatically (booleans to `false`, numeric types to `0`, references to `null`).   

- **Array initializers**

A way of creating arrays without the `new` keyword is by initializing them directly with array initializers. It is a shortcut to create and initialize at the same time. It is done with curly brackets `{}` wrapping the values to store in the array separated by comas. For example:

```java
int[] primes = {3, 5, 7, 11};
boolean[] flags = {false, true, true}
String[] greets = {"hi", "hello", "whatsup"};
```

> This syntax is only valid at the time of declaration. If you want to reassign an array later, you must use `new` again.
> 

## Using arrays

### Array indexing

In Java, array indexing starts at `0`. So, for example, in an array of size `10`, the last item will have index `9`.
If you try to access a non-existing index (i.e., an index outside the bounds of the array), the JVM will throw an `ArrayIndexOutOfBoundsException`.

### Members of an array object

Since arrays are objects in Java, they inherit all methods from the `Object`class.

In addition, they have specific members. In this section we will focus on two of them, as they are the most relevant for most use cases:

- **Length field**

```java
public final int length;
```

There’s no much to say: Arrays have a public final int member to store the size of the array. It is final because arrays have fix sizes. Once created, you cannot change its size.  if you need to, you have to create a new one.

> An array can have length `0`. A good example is the `args[]` array of the `main` method. If the program is executed with no arguments, the array will be empty and have a length of 0, which is different from being null.
> 
- **`clone()`method**

All array classes have a public method called `clone()`. It will make a *shallow copy* of the array when invoked. 

Merely, when you invoke clone from an array, what happens is that a new Array object of the same length will be created, and its contents will be copied into the new one. This is: if the contents are primitive variables, their values will be copied. However, if the array contained reference types, only the references and not the real objects they point to would be cloned. That’s why we talk about shallow copy.

### Runtime behaviour of arrays

Two aspects of the runtime behaviour of arrays is that they are reified and they are covariant.

- **Reified aspect of arrays**

The type checking of the elements of an array is done at runtime by the JVM instead of by the compiler at compile time. So there are certain situations in which the compiler wont notice the type violation, but the JVM will. For example:

```java
String[] sa = {"1", "2", "3"};
Object[] oa = sa;
oa[0] = new Object();
```

In the code above, `oa` points to a Strings array, but the compiler will let you store an object in it with no error. Instead of a compilation error, the JVM will throw a runtime exception (`java.lang.ArrayStoreException`) which is a potencial source of issues. 

- **Covariant aspect of arrays**

The fact that arrays are covariant implies that an array of certain objects, can store any of the subclasses of that object. For example, the following code works well:

```java
Number[] na = {1, 2, 3};
na[] = new Float(1.2f);
```

### Uses of arrays

Arrays are quite basic structures, since they only have a field and a few methods. Hence, they are more used like building blocks for more complex data structures, for example, `java.util.Arrays` is a class included in the Java Standard Library to take arrays a bit further. Also, Strings are built based in an array of chars. And the same happens with some other data structures such as List, Stack and Queue. 

## Collections and Generics

We already mentioned collections and generics, but they are barely within the exam scope. Therefore, this section will only provide a brief overview, mainly to prepare for understanding `ArrayList`.

The motivation for **collections** came from the limitations of arrays:

- **Resizing** an array requires creating a new one and copying the elements.
- **Inserting** or **removing** elements in the middle of an array is tedious and inefficient.
- Arrays provide very few operations beyond simple indexing and iteration.

Since these needs are extremely common in Java development, the language designers introduced a set of reusable data structures with built-in functionality.

> These data structures are grouped under the **Collections Framework**, whose root interface is `java.util.Collection` (which itself extends `Iterable`). This framework is organised into a rich hierarchy of interfaces and classes, commonly referred to as the **Collections API**.
> 

Just for fun (not in the exam), here’s a simplified diagram of part of that hierarchy:

![image.webp](attachment:4ed10dfc-85b7-4074-8a68-7c42b3fe3037:image.webp)

About generic, all you need to know is what we already learnt during the for-each section in chapter 8: generics allow to specify the type of the elements that a collection will hold. For example:

```java
ArrayList<String> names = new ArrayList<>();
names.add("Alice");
names.add("Bob");
```

Without generics, collections would be **type-unsafe**, forcing developers to rely on casts and risking `ClassCastException` at runtime.

With generics, the compiler ensures type safety, improving code reliability and readability.

With this background, we are ready to move on to one of the most commonly used collections in Java: **`ArrayList`**.

## `ArrayList` API

### Creating (and resizing) ArrayLists

ArrayList is one of the implementation classes of the List interface. It has three constructors: 

1. `ArrayList()`: Constructs an empty list with a default capacity of 10.
2. `ArrayList(Collection c)`: Constructs a list containing the elements of the provided collection.
3. `ArrayList(int inicialCapacity)`: Constructs an empty list of the specified size.
- **Resizing behaviour**

Arrays can’t be resized, therefore, all the data structured based on arrays, internally can’t. In practice, however, they can, because `ArrayList` provide the methods to do it. The important thing is that even if apparently you are resizing them, what it is internally being done is a copy into a new one with different capacity.

This implies that, when calling the `ArrayList()` method and adding more than 10 elements, a copy of the list is going to be made in each addition. Hence, specifying the estimated capacity of the `ArrayList` while creating it improves the performance. Also, for that same purpose, `ArrayList` provides two methods for resizing: `ensureCapacity(int n)` which resizes to a new `n` capacity, and `trimToSize()`, which resizes to a smaller one, taking only the filled spaces.

- **Typical declarations**

Some common declarations you may see on the exam:

```java
// 1. Using List as reference type (recommended, good practice)
List list = new ArrayList();

// 2. Copying from an existing collection
ArrayList<String> al2 = new ArrayList<String>(list);

// 3. Using generics with the diamond operator
List<Student> list1 = new ArrayList<>();
```

> In example (3), notice the use of the diamond operator (`<>`) . It tells the compiler to infer the generic type from the left-hand side, so we don’t need to repeat `<Student>` on the right-hand side.
> 

### Important methods of `ArrayList`

Some of the methods below are inherited from Collections, but for the exam scope there’s no need to make a distinction.

I will introduce this section with `toString()` method, which extends the method from Object by doing the following: it takes a string representation for each of its elements invoking `toString` on them, and combine then into a string wrapped between square brackets `[]`.

| method | description |
| --- | --- |
|  | **Methods to add elements to an `ArrayList`** |
| `boolean add(E e)` | Appends `e` to the end of the list. |
| `void add(int index, E e)` | Inserts `e` at position `index`. |
| `boolean addAll(Collection<? extends E> c)` | Appends all elements of `c` to the end. |
| `boolean addAll(int index, Collection<? extends E> c)` | Inserts all elements of `c` starting at position `index`. |
|  | **Methods to remove elements from an `ArrayList`** |
| `E remove(int index)` | Removes element at `index` and returns it. |
| `boolean remove(Object o)` | Removes the **first occurrence** of `o`. |
| `boolean removeAll(Collection<?> c)` | Removes **all elements** present in `c`. |
| `void clear()` | Removes **all elements** from the list. |
|  | **Methods to replace elements from an `ArrayList`** |
| `E set(int index, E e)` | Replaces the element at `index` with `e`. Returns the replaced element. |
|  | **Methods to read without modifying** |
| `E get(int index)` | Returns the element at `index`. |
| `boolean contains(Object o)` | Returns `true` if the list contains `o`. |
| `int indexOf(Object o)` | Returns the first index of `o`, or `-1` if not found. |
| `boolean isEmpty()` | Returns `true` if the list has no elements. |
| `int size()` | Returns the number of elements contained by the `ArrayList` |

Some details you may now about `ArrayList` methods:

- `ArrayList` allows null and duplicate elements

None of the `ArrayList` methods except `toArray(T[] a)` throws `NullPointerException`. For example, calling `remove` with a non existing index will throw `IndexOutOfBoundException`. And trying to remove a non existing object on `boolean remove(Object o)` will only return false.

Also, same as primitive (// can I say primitive here?) arrays, ArrayList allow adding duplicate values.

- Method chaining

Unlike `StringBuilder`, none of the `ArrayList`methods return a reference to the same `ArrayList` object. Therefore, is not possible to chain method calls.

- Size vs Capacity

When talking about `ArrayList`s there’s a difference in between size and capacity. Size is the number of elements that are currently stored in the `ArrayList`. While capacity is the length of the internal array that an `ArrayList` uses to store its elements.

> Therefore, the length member of the one instance of `ArrayList`, and the return value of invoking `size()`in the same array, can be different if some of the “spaces/slots” of the instance are empty.
> 

## Using `ArrayList`

### Traversing the elements of an `ArrayList`

We already saw a bit of this during the loops chapter, but here’s a quick view of the different ways to iterate over an array. Having a `ArrayList<Student> students`:

```java
// using a regular loop (for or while)
for (int i = 0; i < students.size() ; i++) {
	System.out.println(students.get(i).name);
}

// with an enhanced for
for (Student s : students) {
	System.out.println(s.name);
}
// using java.util.Iterator
java.util.Iterator it = students.iterator();
while(it.hasNext()) {
	Student s = it.next();
	System.out.println(s.name);
}
```

I'm going to dwell a little on the third of these loops since it is in the exam scope even though it is not a very common way to iterate through an `ArrayList`.  We know that all collections extends from `Iterable`and hence they can be iterated through using an `Iterator` object.

`ArrayList` has a `iterator()`method to create an instance of `Iterator`.  This iterator has the method `hasNext()`to check if a next element exist, and that’s why we use it in the while condition. And a `next()`method that will return the next object in order to keep iterating.

### Differences with Array

The main differences lie in the advantages of `ArrayList` we have mentioned throughout this chapter: **dynamic sizing**, **type safety when using generics**, and convenient methods for searching and inserting elements, which make `ArrayList` easier to work with than arrays.

However, an `ArrayList` generally requires more memory, and another limitation compared to arrays is that it cannot store primitive types directly. This limitation is less significant since Java 5 introduced autoboxing, which automatically converts primitives to their wrapper classes when needed.