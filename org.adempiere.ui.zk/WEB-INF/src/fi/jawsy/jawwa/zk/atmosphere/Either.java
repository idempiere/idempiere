package fi.jawsy.jawwa.zk.atmosphere;

public class Either<L, R> {
	private L left;
	private R right;
	
	public Either(L l, R r) {
		left = l;
		right = r;
	}
	
	public L getLeftValue() {
		return left;
	}
	
	public R getRightValue() {
		return right;
	}
}
