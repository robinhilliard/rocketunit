# RocketUnit
RocketUnit is the smallest, easiest and most approachable unit testing framework for CFML. Here's what people said about Release 1.0 back in the day:

> Just wanted to drop you guys a line and say Thank You!!! for creating RocketUnit. I'm using it as the testing framework for CFWheels and I have to say that it's the easiest testing framework I've ever used. Excellent work! - Tony Petruzzi

> RocketUnit is absolutely sweet; thx for publishing it, Robin. Compared with both CFUnit and CFCUnit it's a no brainer to setup, it's much simpler to use and still delivers the same (over even better) information. Even people who never have worked with unit testing before can actually get it pretty much straight away - Kai Koenig


> I'd just like to publicly thank RocketUnit for finding this for me the moment we upgraded our dev server here. I encourage everyone who isn't actively unit testing to have a look at RocketUnit or any other unit testing framework as they will saves you a lot of heartache. It takes about 5 minutes to get your first test running, and after that you'll be streets ahead - Phil Haeusler


> I have to confess, I have been using RocketUnit for a while now and it is just perfect! So nice and simple and easy to use, we even have developers using it for unit testing some of our C# webservices!! (ok ok, maybe that is just me) - Lucas Sherwood



Release 2.0 comes with the following new features, all packed into a 700 line component:

1. There is still a single assert statement, but you no longer have to quote the expression:

        assert(index++ eq 222);
      
    As before Rocketunit will provide a detailed breakdown of the terms in the assertion if the assertion fails.
    Assertions can span up to three lines, and RocketUnit will warn if it cannot parse the source of the expression.
2. `Test.cfc` implements `onRequest()` allowing your `Application.cfc` to extend test for an automatic testing page:

        component extends="Test" {
          path = getDirectoryFromPath(getCurrentTemplatePath());

          // One or more mappings for the code you want to test,
          // So that your tests can see it
          this.mappings["/myproject"] = "#path#../src/myproject";

          // The mapping to this test directory, expected by Test.onRequest()
          this.mappings["/test"] = path;

          // Will appear in browser window title
          this.name = "My Project's Tests";
        }
3. The page rendered by `onRequest()` has a start/pause button for an automatic refresh of the test results.
4. `assert()` checks for and warns if terms in the assert expression seem to be having side effects when evaluated
5. Adding `?junit` to the test page outputs JUnit compatible XML for CI.

Release 2.0 has been tested on Lucee 4.5 and comes with a full suite of RocketUnit (naturally) tests. `_Test.cfc` and `Test_Test.cfc` are examples of how to use RocketUnit. The project is set up in a standard testing structure. If you want to you can replace the `src/rocketunit` and `test/rocketunit` folders with your own project and test folders, update the paths in `Application.cfc` to match and browse the test directory to see your tests run.
