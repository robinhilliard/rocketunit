/**
  A very simple stub test case for Test_Test to test
  The "_" prefix prevents this component from being included
  automatically in the RocketUnit tests. Instead it is
  instantiated explicitly in Test_Test.setup().

  Note that it extends the Test.cfc under src/rocketunit, not
  the one under test.

  (c) 2008-2015 RocketBoots Pty Ltd

	This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 **/
component extends="rocketunit.Test" {

  // Used to assert tests are called in definition order
  index = 1;
  this.calls = [];

  function testZ() {
    this.calls.append("Z");
    assert(index++ eq 1);
  }

  // Failed assertion expression spread across two lines of source
  // to check that assert() can find, parse and reassemble
  // the expression correctly.
  function testY() {
    this.calls.append("Y");
    assert(index++
           eq 222);
  }

  function testX() {
    this.calls.append("X");
    assert(index++ eq 3);
  }

  // Doesn't start with "test", so should not be called
  function notATest() {
    this.calls.append("NOT-A-TEST");
    assert(index++ eq 4);
  }

}