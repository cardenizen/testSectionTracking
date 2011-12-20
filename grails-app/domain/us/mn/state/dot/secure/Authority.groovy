/*
 * Copyright 2009 Minnesota Department of Transportation
 * Author(s): Dennis Carroll
 *
 * This file is part of TestSectionTracking.
 * 
 * TestSectionTracking is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * TestSectionTracking is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with TestSectionTracking.  If not, see <http://www.gnu.org/licenses/>.
 */
package us.mn.state.dot.secure
import us.mn.state.dot.secure.Person

/**
 * Authority domain class.
 */
class Authority implements Serializable {

//  static hasMany = [people: Person]  // join table is authority_people
  static hasMany = [person: Person]    // join table is authority_person

	/** description */
	String description
	/** ROLE String */
	String authority

	static constraints = {
		authority(blank: false, unique: true)
		description()
	}
}
