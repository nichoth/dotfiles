# Loop over files that have whitespace in their names.
# This example creates sym links for sublime settings.
while read i; 
do 
  ln -s "$i" "{i##*/}"; 
done < <(ls ~/.sublime-settings/*.sublime-settings)

# process substitution
<(some command)

# Parameter Expansion
# Get the basename for a file (remove the path):
${PATHNAME##*/}

# for loop
for file in `ls`;
do
  echo "$file";
done


# Print something a bunch
perl -e 'print "a\n" x 20;'





