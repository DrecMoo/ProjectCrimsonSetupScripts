# Linux Commands Cheatsheet


### Directory Traversal

| Command | Arguments                                                                   | Flags                                                                                                                            | Description                                                                                            |
|---------|-----------------------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| pwd     |                                                                             |                                                                                                                                  | "Print working directory" - displays current directory                                                 |
| ls      | <dir> (optional)<path to directory><br>[default- current working directory] | "-a" prints all files<br><br>"-l" provides detailed information about each file<br><br>"-R" lists all subdirectories recursively | "list" - lists current working directory's contents                                                    |
| cd      | <dir> (optional)<path to directory><br>[default- current working directory] |                                                                                                                                  | "Change directory." Note special directories "." and ".." = current and parent directory, respectively |


### Interacting with files

| Command | Arguments        | Flags                                                                                                 | Description                                                                                                                                    |
|---------|------------------|-------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|
| mkdir   | <directory_name> |                                                                                                       | "Make dir(ectory)" - creates a new directory                                                                                                   |
| touch   | <filename>       |                                                                                                       | Creates a new, empty file                                                                                                                      |
| rmdir   | <directory_name> |                                                                                                       | Removes a directory                                                                                                                            |
| rm      | <filename>       | "-r" - removes a directory and its contents recursively<br><br>"-f" - forces removal through warnings | Remove a file                                                                                                                                  |
| mv      | <src> <dst>      |                                                                                                       | Moves a file or directory at src to dst.<br>Can be used to rename files/directories                                                            |
| cp      | <src> <dst>      | "-p" - copy with permission bits                                                                      | Copy a file from src to dst                                                                                                                    |
| chmod   | <mode> <file>    |                                                                                                       | Changes the permission bits on a file, using octal convention.<br><br>Can use +/- in front of octal to specify addition or subtraction of bits |
| chown   | <user> <file>    |                                                                                                       | Change the owner of a file                                                                                                                     |