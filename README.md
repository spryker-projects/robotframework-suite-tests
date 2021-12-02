# Installation

Installation requires both Robot Framework and Browser library powered by Playwright. 
1. Install [Robot Framework](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst)
2. Install [Browser library](https://robotframework-browser.org/#installation)


# How to run tests

`robot -v env:{ENVIRONMENT} {PATH}`

### [Supported Browsers](https://marketsquare.github.io/robotframework-browser/Browser.html#SupportedBrowsers)
| Browser  	|Browser with this engine|
|:--- |:--- |
|chromium| 	Google Chrome, Microsoft Edge (since 2020), Opera|
|firefox| 	Mozilla Firefox|
|webkit| 	Apple Safari, Mail, AppStore on MacOS and iOS|

### Run tests in chromium browser

`robot -v env:{ENVIRONMENT} -v browser:chromium {PATH}`

Since [Playwright](https://github.com/microsoft/playwright) comes with a pack of builtin binaries for all browsers, no additional drivers e.g. geckodriver are needed.

All these browsers that cover more than 85% of the world wide used browsers, can be tested on Windows, Linux and MacOS. Theres is not need for dedicated machines anymore.

## Example

### B2B

`robot -v env:b2b -v browser:chromium -d results tests/smoke/smoke_b2b.robot`

### B2C

`robot -v env:b2c -v browser:firefox -d results tests/smoke/smoke_b2c.robot`


### Custom

`robot -v env:b2b -v browser:chromium -v headless:true -v host:https://www.de.b2b.demo-spryker.com/ -v zed_url:https://backoffice.de.b2b.demo-spryker.com/  -d results tests/smoke/smoke_b2b.robot`

`robot -v env:b2c -v browser:firefox -v headless:false -v host:https://www.de.b2c.demo-spryker.com/ -v zed_url:https://backoffice.de.b2c.demo-spryker.com/  -d results tests/smoke/smoke_b2c.robot`

## Supported Parameters

| Parameter | Comment |
|:--- |:--- |
| `-d {PATH}` | Path to the folder to store the run report. Like `results` |
| `-v env:{ENVIRONMENT}` | Environment variable. Demo data, locators and hosts in tests will depend on this variable value. Possible values: `b2b` and `b2c`. Other demoshops comming soon. **Default:** `b2b` |
| `-v host:{URL}` | Yves URL |
| `-v zed_url:{URL}` | Zed URL |
| `-v browser:{browser}`|Defines in which browser run tests. Possible values: `chromiun`,`firefox`, `webkit`. **Default:** `chromium`|
| `-v headless:{headless}` |Defines if the browser should be launched in the headless mode. Possible values: `true`,`false`. **Default:** `true`|
| `-v browser_timeout:{browser_timeout}` |Default time for Implicit wait. **Default:** `60s`|
| `{PATH}` | Path to the file to execute|


## [Built-in libraries](https://robotframework.org/?tab=builtin#resources)
| Name  	|Description| Keywords documentation|
|:--- |:--- |:--- |
| Builtin |Provides a set of often needed generic keywords. Always automatically available without imports.| [Documentation](https://robotframework.org/robotframework/latest/libraries/BuiltIn.html)|
| Collections |Provides a set of keywords for handling Python lists and dictionaries.| [Documentation](https://robotframework.org/robotframework/latest/libraries/Collections.html)|
| DateTime |Library for date and time conversions.| [Documentation](https://robotframework.org/robotframework/latest/libraries/DateTime.html)|
| Dialogs |Provides means for pausing the execution and getting input from users.| [Documentation](https://robotframework.org/robotframework/latest/libraries/Dialogs.html)|
| OperatingSystem |Enables various operating system related tasks to be performed in the system where Robot Framework is running.| [Documentation](https://robotframework.org/robotframework/latest/libraries/OperatingSystem.html)|
| Process |Library for running processes in the system.| [Documentation](https://robotframework.org/robotframework/latest/libraries/Process.html)|
| Screenshot |Provides keywords to capture screenshots of the desktop.| [Documentation](https://robotframework.org/robotframework/latest/libraries/Screenshot.html)|
| String |Library for generating, modifying and verifying strings.| [Documentation](https://robotframework.org/robotframework/latest/libraries/String.html)|


## External libraries that can be installed based on your needs
The full list can be found on the [official website](https://robotframework.org/?tab=libraries#resources)
| Name  	|Description| Keywords documentation|
|:--- |:--- |:--- |
| Browser |A modern web testing library powered by [Playwright]((https://github.com/microsoft/playwright)). Aiming for speed, reliability and visibility. **Note: Already installed**| [Documentation](https://marketsquare.github.io/robotframework-browser/Browser.html)|


## Automatically re-executing failed tests
There is often a need to re-execute a subset of tests, for example, after fixing a bug in the system under test or in the tests themselves. This can be accomplished by selecting test cases by names (--test and --suite options), tags (--include and --exclude), or by previous status (--rerunfailed or --rerunfailedsuites).

Combining re-execution results with the original results using the default combining outputs approach does not work too well. The main problem is that you get separate test suites and possibly already fixed failures are also shown. In this situation it is better to use --merge (-R) option to tell Rebot to merge the results instead. In practice this means that tests from the latter test runs replace tests in the original.
| Command  	|Description| 
|:--- |:--- |
|`robot -v env:b2b -v browser:chromium -d results tests/smoke/smoke_b2b.robot`|first execute all tests|
|`robot -v env:b2b -v browser:chromium -d results --rerunfailed results/output.xml --output results/rerun.xml tests/smoke/smoke_b2b.robot`|then re-execute failing|
|`robot -v env:b2b -v browser:chromium -d results --merge results/output.xml results/rerun.xml`| finally merge results|

The message of the merged tests contains a note that results have been replaced. The message also shows the old status and message of the test.

Merged results must always have same top-level test suite. Tests and suites in merged outputs that are not found from the original output are added into the resulting output.

