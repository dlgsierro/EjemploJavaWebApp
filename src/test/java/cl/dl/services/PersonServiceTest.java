package cl.dl.services;

import org.junit.Test;

import junit.framework.TestCase;

public class PersonServiceTest extends TestCase {
	
	private PersonService service = new PersonService(); 

	@Test
	public void testBuildPerson() {
		assertNotNull(service.buildPerson("Gonzalo", "Sierro", 41));
	}
	
}
