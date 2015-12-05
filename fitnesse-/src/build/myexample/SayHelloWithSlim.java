package myexample;

public class SayHelloWithSlim {

	private String name;

    public void setName(String name) {
        this.name = name;
    }

	public String sayHello() {
		return "Hello " + name;
	}
}
