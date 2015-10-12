/**
  Testing application for RocketUnit. By extending Test,
  Application.cfc will automatically run your tests for you.

  Append "?junit" to the url if you want JUnit XML output for
  your CI setup.

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
component extends="Test" {
  path = getDirectoryFromPath(getCurrentTemplatePath());

  // One or more mappings for the code you want to test,
  // So that your tests can see it
  this.mappings["/rocketunit"] = "#path#../src/rocketunit";

  // The mapping to this test directory, expected by Test.onRequest()
  this.mappings["/test"] = path;

  // Will appear in browser window title
  this.name = "Rocketunit Tests";
}
