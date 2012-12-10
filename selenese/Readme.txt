test
- Example test cases exported from Selenium IDE ( JUnit4 + WebDriver )

resource/selenese
- selenese test script recorded by Selenium IDE

Notes
======
* The mapping between selenese ( the native format created from Selenium IDE recording ) and 
  web driver export is not one to one. For e.g, the fireEvent command is not needed in
  web driver test script.

* While both "id=loginPanel_Ok" and "loginPanel_Ok" work the same when you execute selenese test with Selenium IDE, 
you must use the id= syntax for the web driver export to work.

* The selenese script recorded by Selenium IDE required changes ( most of the time, you need to add insert fireEvent and sleep command )
before you can run it with Selenium IDE. However, it mostly work if you export it to the Java WebDriver format and run it from Eclipse.

* AdempiereIDGenerator is required for the recording and execution of selenese test cases.  

