---
layout: default
title: Test - Junit Core
folder: junit-core
permalink: /archive/test/junit-core/
---

# Test - Junit Core

## Write Test with Static Method

"JUnit provides overloaded assertion methods for all primitive types and Objects and arrays (of primitives or Objects)."

Class Definition

~~~ java
java.lang.Object
  extended by org.junit.Assert
~~~

Method Definition

~~~ java
//Asserts that two doubles are equal to within a positive delta. 
//If they are not, an AssertionError is thrown.
public static void assertEquals(double expected, double actual, double delta)
~~~

Usage Example

~~~ java
import static org.junit.Assert.*;

public class MyTest {
	int param = 1;
	public static void main(String args[]) {
		try {
			new MyTest().testAssertEquals();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void testAssertEquals() {
		assertEquals(param, 2);
	}
}

result: "Exception in thread "main" java.lang.AssertionError..."
~~~

## Write Test with Annotation

To map a method as JUnit test, you need to put the `@Test` annotation before the method you defined.

> The Test annotation tells JUnit that the public void method to which it is attached can be run as a test case. 
To run the method, JUnit first constructs a fresh instance of the class then invokes the annotated method.

Example

~~~ java
import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class MyTest {
	int param = 1;
	@Test
	public void testAssertEquals() {
		assertEquals(param, 1);
	}
}
~~~

## Execute Test with Test Runners

To run a JUnit test, you need a `Test Runner` class.

In the `Test Runner` class, it uses `org.junit.runner.JUnitCore.runClasses(TestClass1.class, ...)`to invoke your test cases. 
And a `TestResult` is needed to collect the results.

Example

~~~ java
import static org.junit.Assert.*;
import org.junit.Test;
import org.junit.runner.JUnitCore;
import org.junit.runner.Result;
import org.junit.runner.notification.Failure;

public class MyTest {
	int param = 1;
	public static void main(String args[]) {
		Result result = JUnitCore.runClasses(MyTest.class);
        for (Failure failure : result.getFailures()) {
          System.out.println(failure.toString());
        }
		System.out.println(result.wasSuccessful());
	}
	@Test
	public void testAssertEquals() {
		assertEquals(param, 2);
	}
}
~~~

## Execute Test with Other Options

use IDE built-in function

~~~
in Eclipse

right click test class file and click "Run As JUnit Test" 
~~~

use ant junit task

~~~ xml
<target name="test">
    <property name="collector.dir" value="${build.dir}/failingTests"/>
    <property name="collector.class" value="FailedTests"/>
    <!-- Delete 'old' collector classes -->
    <delete>
        <fileset dir="${collector.dir}" includes="${collector.class}*.class"/>
    </delete>
    <!-- compile the FailedTests class if present --> 
    <javac srcdir="${collector.dir}" destdir="${collector.dir}"/>
    <available file="${collector.dir}/${collector.class}.class" property="hasFailingTests"/>
    <junit haltonerror="false" haltonfailure="false">
        <sysproperty key="ant.junit.failureCollector" value="${collector.dir}/${collector.class}"/>
        <classpath>
            <pathelement location="${collector.dir}"/>
        </classpath>
        <batchtest todir="${collector.dir}" unless="hasFailingTests">
            <fileset dir="${collector.dir}" includes="**/*.java" excludes="**/${collector.class}.*"/>
            <!-- for initial creation of the FailingTests.java -->
            <formatter type="failure"/>
            <!-- I want to see something ... -->
            <formatter type="plain" usefile="false"/>
        </batchtest>
        <test name="FailedTests" if="hasFailingTests">
            <!-- update the FailingTests.java -->
            <formatter type="failure"/>
            <!-- again, I want to see something -->
            <formatter type="plain" usefile="false"/>
        </test>
    </junit>
</target>
~~~

## Test Suite: run many tests together

> Test suite means bundle a few unit test cases and run it together.

Class Suite

~~~ java
java.lang.Object
  extended by org.junit.runner.Runner
      extended by org.junit.runners.ParentRunner<Runner>
          extended by org.junit.runners.Suite
~~~

Notice that the `Suite` is also a test runner.

Example 1

~~~ java
import org.junit.runner.RunWith;
import org.junit.runners.Suite;

@RunWith(Suite.class)
@Suite.SuiteClasses({
  MyTest1.class,
  MyTest2.class,
  MyTest3.class,
})

public class MyTestSuite {
  // the class remains empty,
  // used only as a holder for the above annotations
}
~~~

Example 2

~~~ java
TestSuite suite = new TestSuite(TestJunit1.class, TestJunit2.class);
TestResult result = new TestResult();
suite.run(result);
~~~

## Test Fixture: format the test process

> A test fixture is a fixed state of a set of objects used as a baseline for running tests. 
The purpose of a test fixture is to ensure that there is a well known and fixed environment 
in which tests are run so that results are repeatable.

You can write your own fixture by using `Rules`.

Fixture Example

~~~ java
import java.io.Closeable;
import java.io.IOException;

import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

public class TestFixturesExample {
  static class ExpensiveManagedResource implements Closeable {
    public void close() throws IOException {}
  }

  static class ManagedResource implements Closeable {
    public void close() throws IOException {}
  }

  @BeforeClass
  public static void setUpClass() {
    System.out.println("@BeforeClass setUpClass");
    myExpensiveManagedResource = new ExpensiveManagedResource();
  }

  @AfterClass
  public static void tearDownClass() throws IOException {
    System.out.println("@AfterClass tearDownClass");
    myExpensiveManagedResource.close();
    myExpensiveManagedResource = null;
  }

  private ManagedResource myManagedResource;
  private static ExpensiveManagedResource myExpensiveManagedResource;

  private void println(String string) {
    System.out.println(string);
  }

  @Before
  public void setUp() {
    this.println("@Before setUp");
    this.myManagedResource = new ManagedResource();
  }

  @After
  public void tearDown() throws IOException {
    this.println("@After tearDown");
    this.myManagedResource.close();
    this.myManagedResource = null;
  }

  @Test
  public void addTest() {
    this.println("@Enter addTest()");
  }
}
~~~

Test Extends Fixture Example

~~~ java
import static org.junit.Assert.*;

public class MyTest extends TestFixturesExample{
	int param = 2;
	public void addTest() {
		assertEquals(param, 2);
	}
}
~~~

## Links
- <https://github.com/junit-team/junit/wiki>
- <http://junit.org/javadoc/latest/index.html>
