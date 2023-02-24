# dir2wordlist
dir2wordlist helps that generate a wordlist using recursive find on a directory. The purpose of this small tool is to discover restricted files and directories.



![alt text](https://github.com/mikailfidan/dir2wordlist/blob/master/dir2wordlist.gif)

<h2>Usage:</h2>

  1. Set execute permissions for the script:
     chmod +x ./dir2wordlist.sh
  2. Enter the following to run the script:
     ./dir2wordlist.sh [OPTIONS]...

<code>./dir2wordlish -h</code>



 ./dir2wordlist.sh [OPTIONS] 

 Options:

  -d, required Target directory.

  -e, optional Exclude extensions.The extensions must be in quotes and separated by spacess.
      (Exp: -e "png jpg css js")

  -o, optional Output file name.(Default:date-hourse-minute_wordlist.txt)

 For Example: <code> ./dir2wordlist.sh -d /home/script-folder -e "png jpg css js" -o dir_wordlist.txt </code>
