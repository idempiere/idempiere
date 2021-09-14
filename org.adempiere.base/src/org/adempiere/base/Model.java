package org.adempiere.base;

import static java.lang.annotation.ElementType.TYPE;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import org.atteo.classindex.IndexAnnotated;

/**
 * Automatic model class registration
 * @author Saulo Gil
 */
@Target(TYPE)
@IndexAnnotated
@Retention(RetentionPolicy.RUNTIME)
public @interface Model {

	/**
	 * Table name
	 * @return
	 */
	String table();

}