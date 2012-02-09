== Introduction ==
*  To be completed

== Features ==
  * Filter file extension and name rule
  * Move file, copy file and send file to recycle bin
  * Run custom command
  * Periodically running file management

=== Custom command ===
${file} - full file path
${name} - filename only
${dir}  - directory path

Example:
echo ${file} >> C:\list.txt

this will echo full file path of all files met the condition to text file

== Bug ==
Please goto http://code.google.com/p/belvederesharp for reporting bugs and submitting features request

*  Timer on MacOSX Mono triggers two Tick event, and causes the program to crash. Please use "Run Now" until it is fixed.

== To Do ==
*  Minimize to tray (Does not work with Mac OS X, will tray again in the future)
*  Confirm action
*  Recursive
*  Element
  *  Extension
  *  Name
  *  Size
  *  Date last modified
  *  Date last opened
  *  Date created
*  Conditions
  *  Is (Implement for Extension and Name) 
  *  Is not
  *  Matches one of
  *  Does not match one of
  *  Contains
  *  Does not contain
  *  Actions
  *  Move file to
  *  Rename file to
  *  Send file to Recycle Bin
  *  Delete file
  *  Copy file to
  *  Open file