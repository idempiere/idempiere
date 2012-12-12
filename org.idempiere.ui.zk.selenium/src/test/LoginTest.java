package test;

import org.junit.*;

/**
 * Web Driver + zk jq selector, doesn't required AdempiereIdGenerator
 * @author hengsin
 *
 */
public class LoginTest extends AbstractTestCase {
	@Test
	public void testLogin() throws Exception {
		login();			
	}
}
