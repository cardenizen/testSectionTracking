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
import us.mn.state.dot.secure.*
/**
 * Provides a service class with some methods that integrate the Person domain class and Acegi security.
 *
 */
class PersonService {

    boolean transactional = false

    def authenticateService

    /**
    * Get the current user in a safe way to avoid a null userDomain.
    * @returns The current user or the 'system' person (Person #1) if userDomain() is not active.
    */
    def currentUser() {
        if(authenticateService.userDomain()) {
            return Person.get(authenticateService.userDomain().id)
        }
        else {
            log.warn "userDomain not active, attempting to return Person #1."
            return Person.get(1)
        }
    }

    /**
    * Convenience wrapper around authenticateService.encodePassword().
    * @param passClearText The clear text password to encode.
    * @returns The encoded password.
    */
    def encodePassword(passClearText) {
        authenticateService.encodePassword(passClearText)
    }

}
