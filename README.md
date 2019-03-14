# zip-script
Exploration of the impact of zip-code verification with stripe on abuse and non-abuse users.

# how-to
1. Add `.csv` to `inputs/`
2. Run `script.sh`
3. Combine output `.csv`s:
   * `cat tmp_files* > final.csv`
4. Ensure you have the correct number of rows:
   * `wc -l final.csv`

# troubleshooting
If you have found that the number of rows is off, the ranges in `script.sh` are likely off.
Instead of manually trying to look through hundreds of lines of code, stub out the main loops, and run `ruby parser.rb` to find where you start getting inconsistent.
