package cl.dl.services;

import cl.dl.domain.Person;

public class PersonService {

	public Person buildPerson(String firstName, String lastName, int age) {
		Person person = new Person();
		person.setFirstName(firstName);
		person.setLastName(lastName);
		person.setAge(age);
				
		return person;
	}
	
}
