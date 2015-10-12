# SwiftCoreDataFromScratch

10/11/14<br>
This file is a TableView template based on the SWIFT CORE DATA FROM SCRATCH tutorials from http://theapplady.net These tutorials are arranged into 5 workshops preceded by an introductory file w/the base project. Workshops are organized as follows:

http://theapplady.net/swift-core-data-from-scratch-introduction/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-1/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-2/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-3/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-4/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-5/<br>

I started using these tutorials as a means of exploring TableView features. Once I have this basic version working, I'm going to add UILocalizedIndexedCollation to organize the table alphabetically.

After I get this initial TableView project working, then it will be time to replicate this project into my actual project. The second project will entail adding a custom keyboard and it will use an API that Apple hasn't released yet.<br><br>

10/12/14<br>
The original SWIFT CORE DATA FROM SCRATCH tutorials were created in February 2015 and March 2015 using Xcode 6.x. When the Xcode 7 was released in September, a lot of updating had to occur with the SWIFT CORE project. Fortunately, Xcode 7 converted much of the project’s code and automatically offered suggestions for fixing many other errors — with the exception of “error handling” itself.

To handle the error handling problem, I generated a Test Project with Xcode 7. First, I corrected error handling problems in the  SWIFT CORE “app delegate” by pasting in the applicable code from the Test Project. From those edits I was able to determine the “do/try/catch” pattern now being used for error handling. I adapted that pattern in the other files which were also having error handling problems, and my error handling issues disappeared.

But at this point I am still left with two errors in this initial stage, errors which websites (including StackOverFlow) haven’t offered clear advice. Starting on the "find-managed-object" branch, the errors are as follows:

<blockquote>In the “BooksViewController” file, (commitEditingStyle function) this error shows:<br>
<i>Variable 'savingError' captured by a closure before being initialized</i><br>
In response to this line of code:<br>
<i>print("Failed to save the context with error = \(savingError?.localizedDescription)”)</i><br>

In the “AddViewController” file, (getImage function), this error shows:<br>
<i>Binary operator '!=' cannot be applied to operands of type 'String' and 'NilLiteralConvertible'</i><br>
In response to this line of code:<br>
 <i>if imgUrl.scheme != nil && imgUrl.host != nil</i></blockquote>

