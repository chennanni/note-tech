package myexample;

import fit.ColumnFixture;

public class SayHelloWithFit extends ColumnFixture {

	public String name;

	public String sayHello() {
		return "Hello " + name;
	}
}
