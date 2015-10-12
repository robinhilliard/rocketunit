/**
  Unit tests for Rocketunit's Test.cfc using a stub test case _Test.cfc.

  Using a test framework to test itself is a bit meta. Originally these tests
  were used in the migration to version 2.0, but in the release
  the two Test.cfcs are the same. The assumption is that the probability
  of the framework failing to detect a failing test on itself due to a failure
  is fairly low.

  This also means that you can use the RocketUnit project structure as a template
  for your own project. Replace the "rocketunit" sub-folders with your own source and
  test folders, rename the parent folder, update the mappings in test/Application.cfc
  and you should be able to browse the test results page in the test directory.

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
component extends="test.Test" {

  import "test.rocketunit._Test";


  function setup() {
    // override request key so that the testing/tested Rocketunit results
    // don't mix together and drive us crazy
    instance = new _Test("_test_results");
  }


  function teardown() {
    structDelete(variables, "instance");
    structDelete(request, "_test_results");
  }


  // instance is of the type we want to test (not test.Test!)
  function testInstance() {
    assert(isInstanceOf(instance, "rocketunit.Test"));
  }


  // Only test functions are called, once, in order of declaration.
  // Result structures updated to match, ignoring assert
  // outcomes for this test
  function testRunTests() {
    var results = 0;

    instance.runTests();
    results = request._test_results;
    assert(arrayToList(instance.calls, "") eq "ZYX");
    assert(results.numCases eq 1);
    assert(results.numTests eq 3);
    assert(results.cases.len() eq 1);
    assert(results.tests.len() eq 3);
  }


  // Check the totals and test statuses are correct, and
  // the failure message of the failed test was successfully
  // parsed from a multi-line assert expression.
  function testAssert() {
    var results = 0;

    instance.runTests();
    results = request._test_results;
    assert(results.numFailures eq 1);
    assert(results.numErrors eq 0);
    assert(results.numSuccesses eq 2);
    assert(results.cases[1].numFailures eq 1);
    assert(results.cases[1].numErrors eq 0);
    assert(results.tests[1].status eq "Success");
    assert(results.tests[2].status eq "Failure");
    assert(results.tests[2].message eq "assert failed: <pre>index++ eq 222</pre>");
    assert(results.tests[3].status eq "Success");
  }


  // Check that key results have been reported correctly
  function testHTMLFormatTestResults() {
    var output = 0;

    instance.runTests();
    output = instance.HTMLFormatTestResults(request._test_results);

    // Header table, ignoring start and end times
    assert(reFind( '<tr><td>Failed</td><td>[0-9: ]+</td><td>[0-9: ]+</td>'
                  & '<td align="right">1</td>'
                  & '<td align="right">3</td>'
                  & '<td align="right">1</td>'
                  & '<td align="right">0</td></tr>',
                  output, 1, false) neq 0);

    // Cases table
    assert(output contains
      '<tr><td>test.rocketunit._Test</td><td align="right">3</td>'
      & '<td align="right">1</td><td align="right">0</td></tr>');

    // Tests table, ignoring execution time. Only the failure should be reported.
    assert(reFind('<tr valign="top"><td>_Test</td><td>Y</td><td>[0-9]+</td><td>Failure</td><td>assert failed: <pre>index\+\+ eq 222</pre></td></tr>',
      output, 1, false) neq 0);
  }

  // Again check that the key results have be reported correctly in JUnit format
  function testJUnitFormatTestResults() {
    var output = 0;

    instance.runTests();
    output = instance.JUnitFormatTestResults(request._test_results);
    assert(output contains '<testsuite errors="0" failures="1" tests="3">');
    assert(output contains '<testcase name="Z" classname="test.rocketunit._Test"></testcase>');
    assert(output contains '<testcase name="Y" classname="test.rocketunit._Test"><failure>assert failed: <pre>index++ eq 222</pre></failure></testcase>');
    assert(output contains '<testcase name="X" classname="test.rocketunit._Test"></testcase>');
  }

}
