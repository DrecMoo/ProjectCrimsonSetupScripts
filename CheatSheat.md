# Linux Commands Cheatsheet


### Directory Traversal

| Command | Arguments                                                                   | Flags                                                                                                                            | Description                                                                                            |
|---------|-----------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| pwd     |                                                                             |                                                                                                                                  | "Print working directory" - displays current directory                                                 |
| ls      | <dir> (optional) [path to directory]<br>[default- current working directory] | "-a" prints all files<br><br>"-l" provides detailed information about each file<br><br>"-R" lists all subdirectories recursively | "list" - lists current working directory's contents                                                    |
| cd      | <dir> (optional) [path to directory]<br>[default- home] |                                                                                                                                  | "Change directory." Note special directories "." and ".." = current and parent directory, respectively |


### Interacting with files

| Command | Arguments        | Flags                                                                                                 | Description                                                                                                                                    |
|---------|------------------|-------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| mkdir   | [directory_name] |                                                                                                       | "Make dir(ectory)" - creates a new directory                                                                                                   |
| touch   | [filename]       |                                                                                                       | Creates a new, empty file                                                                                                                      |
| rmdir   | [directory_name] |                                                                                                       | Removes a directory                                                                                                                            |
| rm      | [filename]       | "-r" - removes a directory and its contents recursively<br><br>"-f" - forces removal through warnings | Remove a file                                                                                                                                  |
| mv      | [src] [dst]      |                                                                                                       | Moves a file or directory at src to dst.<br>Can be used to rename files/directories                                                            |
| cp      | [src] [dst]      | "-p" - copy with permission bits                                                                      | Copy a file from src to dst                                                                                                                    |
| chmod   | [mode] [file]    |                                                                                                       | Changes the permission bits on a file, using octal convention.<br><br>Can use +/- in front of octal to specify addition or subtraction of bits |
| chown   | [user] [file]    |                                                                                                       | Change the owner of a file                                                                                                                     |


### Searching / Log Analysis

| Command        | Arguments                          | Flags                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | Description                                                                                                             |
|----------------|------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------|
|    <br>grep    |    <br>["Text-or-regex"] [File]    |    <br>"-a" search binary data too<br><br>"-r" search recursively<br>"-i" case insensitive<br>"-v" show nonmatching lines<br>"-n" show line numbers<br>"-E" use extended regex<br>"-l" list filenames w/ matches<br>"-c" count matches                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |    <br>Prints all string matches in a file. Tons of ways to do regex searches as well                                   |
| strings        | [File]                             | "-n [number]" change minimum return length<br>(uses "-n 4" by default)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Prints all readable text from a file (sequences of 4 chars or more by default)                                          |
| sort           | [rows of output]                   | "-n" Do numerical instead of alphabetical sort<br><br>"-r" Do reverse/descending order                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Sorts rows of output. Default is string sort in ascending order                                                         |
| uniq           | [rows of output]                   | "-c" Show the number of occurrences                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | Show unique occurrences of strings. Must be combined with sort, as uniq only looks for matches immediately above/below. |
| find           | [path] [options] [tests] [actions] | Options:<br>"-name" search by name <br>"-iname" search by name (case insensitive)<br><br>"-type" filetype (tests: f for files, d for directories, l for symbolic links)<br><br>"-size" filesize (test: [number][denom] (opt +/- prefix for gt/lt). Ex: +40M for files greater than 40MB<br><br>"-mtime" last modified time (test: [number] (opt +/- prefix for gt/lt)<br>"-atime" last accessed time (test: (+/-) [number])<br>"-ctime" last changed time (test: (+/-) [number])<br>***Note that mtime, atime, and ctime use days. mmin, amin, and cmin can be used to specify minute units<br><br>"-perm" file permissions (test: [octal permissions] (no prefix specifies exact permissions match. / prefix specifies "any of these bits." - prefix specifies "all of these bits.") | Find files that match given conditions                                                                                  |


### Awk
Awk is a powerful text processing language that reads files line-by-line, automatically splits each line into fields, and lets you filter, slice, and analyze the data with rule-based logic. Awk can be used in place of most of the above commands

#### Basic Usage:
awk 'pattern {action}' filename

#### Fields
awk is best used on files with consistent tabular format where rows are delimited by newline characters and columns are delimited by spaces. Using this format, awk can access fields consistently by using a 1-based column index. For example, $1 would return the data, $2 the time, etc. $0 is a special index that will return the whole line. 
Ex:
Date Time User Action
1/1/25 00:00 bob login
1/1/25 00:03 bob modify
1/1/25 00:05 bob logout

**Note -F flag can be used to set the column delimiter
For CSV files, use awk -F ',' ...

#### Actions 
The main action used with awk is print, which prints to the terminal
ex: awk '{print $1 $3}' file.txt; prints the first and third item in each row of file.txt

#### Patterns
Patterns can be applied to awk statements to filter which lines the actions are applied to. Note that they are case-sensitive.
Examples: awk '/user/ {print $0}' log.txt; Prints all lines that contain user
'/^user/' all lines that start with "user"
'/user$/' all lines that end with "user"
'/ 4[0-9]{2} /' all lines that contain 400-499
'$2 ~ /POST|GET/' where field 2 == "POST" or "GET" 