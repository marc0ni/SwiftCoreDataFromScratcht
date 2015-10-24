# SwiftCoreDataFromScratch

10/11/15<br>
This file is a TableView template based on the SWIFT CORE DATA FROM SCRATCH tutorials from http://theapplady.net These tutorials are arranged into 5 workshops preceded by an introductory file w/the base project. Workshops are organized as follows:

http://theapplady.net/swift-core-data-from-scratch-introduction/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-1/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-2/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-3/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-4/<br>
http://theapplady.net/swift-core-data-from-scratch-workshop-5/<br>

I started using these tutorials as a means of exploring TableView features. Once I have this basic version working, I'm going to add UILocalizedIndexedCollation to organize the table alphabetically.

After I get this initial TableView project working, then it will be time to replicate this project into my actual project. The second project will entail adding a custom keyboard and it will use an API that Apple hasn't released yet.<br><br>

10/12/15<br>
The original SWIFT CORE DATA FROM SCRATCH tutorials were created in February 2015 and March 2015 using Xcode 6.x. When the Xcode 7 was released in September, a lot of updating had to occur with the SWIFT CORE project. Fortunately, Xcode 7 converted much of the project’s code and automatically offered suggestions for fixing many other errors — with the exception of “error handling” itself.

To handle the error handling problem, I generated a Test Project with Xcode 7. First, I corrected error handling problems in the  SWIFT CORE “app delegate” by pasting in the applicable code from the Test Project. From those edits I was able to determine the “do/try/catch” pattern now being used for error handling. I adapted that pattern in the other files which were also having error handling problems, and my error handling issues disappeared.

But at this point I am still left with two errors in this initial stage, errors which websites (including StackOverFlow) haven’t offered clear advice. Starting on the "find-managed-object" branch, the error is as follows:

<blockquote>
ERROR CORRECTED<br>
In the “AddViewController” file, (getImage function), this error shows:<br>
<i>Binary operator '!=' cannot be applied to operands of type 'String' and 'NilLiteralConvertible'</i><br>
In response to this line of code:<br>
 <i>if imgUrl.scheme != nil && imgUrl.host != nil</i></blockquote><br><br>

10/22/15<br>
Added UILocalizedIndexCollation to project. Index is added successfully to right side of tableView, but the sections are not sorting the contents alphabetically.<br><br>

10/24/15<br>
Copied, pasted, and edited these functions from the "ContactsTableViewController" file of the iContactU project:<br>
<ol>
<li>partitionObjects</li>
<li>numberOfSectionsInTableView</li>
<li>tableView</li>
<li>sectionForSectionIndexTitle</li>
<li>sectionIndexTitlesForTableView</li>
</ol><br>
At this point, I have these errors occurring in the "tableView" function: <br>
<blockquote><i>fatal error: Array index out of range</i><br><br>
When that function is commented out, the app will return these errors:<br>
<i>2015-10-24 13:32:05.461 SwiftCoreDataFromScratch[1157:56084] *** Assertion failure in -[UITableView _endCellAnimationsWithContext:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3505.16/UITableView.m:1504<br><br>
2015-10-24 13:32:05.468 SwiftCoreDataFromScratch[1157:56084] CoreData: error: Serious application error.  An exception was caught from the delegate of NSFetchedResultsController during a call to -controllerDidChangeContent:.  attempt to insert row 0 into section 0, but there are only 0 rows in section 0 after the update with userInfo (null)</i><blockquote>
