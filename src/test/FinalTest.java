package test;
class Extend{
	public int getInt() {
		return 0;
	}
}
public class FinalTest extends Extend{
	final int a = 1;
	public int getInt() {
		return 1;
	}
}
