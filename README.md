# flattener-swift
Flatten arbitrarily embedded arrays into a flat array, in Swift.

Inspired by the [Nutshell Developer Take Home Project](https://github.com/nutshellcrm/join-the-team/blob/master/developer-questions.md#flattener) 

This sample shows how to create an array of values that is the flattened version of an array that may contain values mixed with arrays of the same type.  For example:

`[[1,[[2]],[3]],4]`

### To Run

This code is a Swift playground.  I made it for Mac, to avoid needing to run an IOS emulator.

Download it on a Mac with XCode, and when you open it, it will run the tests.

A sample run result is:

```
Test Suite 'FlattenerTests' started at 2017-04-01 16:06:44.485
Test Case '-[__lldb_expr_1.FlattenerTests testFlaten]' started.
Test Case '-[__lldb_expr_1.FlattenerTests testFlaten]' passed (0.095 seconds).
Test Suite 'FlattenerTests' passed at 2017-04-01 16:06:44.581.
	 Executed 1 test, with 0 failures (0 unexpected) in 0.095 (0.096) seconds
```	 

### Approach

Recursion.  Modern languages (Swift, Java) have "flatten" methods on streams or arrays, but these would take a more uniform structure, such as an array of arrays of values, into an array of values.  They are not designed to handle the complexity of this data structure.  So we do a simple recursive method to unwrap the complexity into an array.

### Comment

This data structure is a challenge for strongly typed languages such as Java or Swift.  You can get around strong typing by using a general type that covers the items and Array, such as "Any" in Swift.

More open languages like Javascript would easily handle the structure, but the implementation of flatten() could be the same.

I don't know where one would use a data structure like this.  It seems a bit contrived.  But it leads to a fun little demonstration of recursion.
