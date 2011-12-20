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
import us.mn.state.dot.testSectionTracking.*
class TestSectionService {

    boolean transactional = true

    def listSelected(params) {
      def tsl=[]
      params.max = Math.min(params?.max?.toInteger() ?: 10, 10000)
      params.offset = params?.offset?.toInteger() ?: 0
      params.sort = params?.sort ?: "id"
      params.order = params?.order ?: "asc"

      def parms = [:]
      parms["max"] = params.max
      parms["offset"] = params.offset
      parms["sort"] = params.sort
      parms["order"] = params.order

      def c = TestSection.createCriteria()
      if (params.searchColumn == 'county') {
        tsl = c.list(parms
        ) {
          ilike "county", params.searchValue
        }
      }
      else if (params.searchColumn == 'routeName') {
        tsl = c.list(parms
        ) {
          ilike "routeName", params.searchValue
        }
      }
        else if (params.searchColumn == 'district') {
          tsl = c.list(parms
          ) {
            eq "district", params.searchValue
          }
      }
        else if (params.searchColumn == 'keyword') {
          tsl = c.list(parms
          ) {
          or {
            ilike "keyword1", "%"+params.searchValue+"%"
            ilike "keyword2", "%"+params.searchValue+"%"
            ilike "keyword3", "%"+params.searchValue+"%"
          }
        }
      }
      return tsl
    }

  String generatRandomString(int n) {
    StringBuffer sb = new StringBuffer( n );
       int c = 'A';
       int r1 = 0;

       for (int i = 0; i < n; i++) {
    r1 = (int) (Math.random() * 3);
    switch (r1) {
    case 0:
    c = '0' + (int) (Math.random() * 10);
    break;
    case 1:
    c = 'a' + (int) (Math.random() * 26);
    break;
    case 2:
    c = 'A' + (int) (Math.random() * 26);
    break;
    }
    sb.append( (char) c );
       }
    return sb.toString()
  }
}
