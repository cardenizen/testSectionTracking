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

public class MultiValuedMap {
  private def map = [:]

  def theMap() { return map }

    def put(String key, String value) {
      if (map[key] == null) {
        def v = []
        v.add(value)
        map.put(key,v)
      }
      else {
        map.get(key).add(value)
      }
    }

    def put(Long key, String value) {
      if (map[key] == null) {
        def v = []
        v.add(value)
        map.put(key,v)
      }
      else {
        map.get(key).add(value)
      }
    }

  def asList() {
    def aList = []
    map.each {k, v ->
      v.each {
        aList.add(k + " : " + it)
      }
    }
    return aList
  }

  def asList(String s) {
    def aList = []
    map.each {k, v ->
      if (k == s)
      v.each {
        aList.add(it)
      }
    }
    return aList
  }

  def getValueCount(key) {
    def l = map.get(key)
    if (l == null)
      return 0
    return l.size()
  }

  def String toString() {
    def rc = ""
    map.keySet().each {
      rc += "   ${it}:"+getValueCount(it)
    }
    return rc
  }

  def getValue(key) {
    def l = map.get(key)
    if (l == null)
      return ""
    if (l.size() == 1) {
      return l[0]
    }
    else {
      return l
    }
  }


}