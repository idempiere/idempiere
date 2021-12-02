package org.adempiere.base.annotation;

import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;
import java.lang.annotation.Target;

@Retention(RUNTIME)
@Target(TYPE)
public @interface Process {

	/**
	 * Optional alternate name (in addition to class name)
	 * @return alternate name
	 */
	String name() default "String";
}
