package myexample;

import fit.ColumnFixture;

public class SayHello extends ColumnFixture {

	public String name;

	public String sayHello() {
		return "Hello " + name;
	}
}
