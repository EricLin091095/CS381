######################################### 	
#    CS 381 - Programming Lab #1		#
#										#
#  < SOLUTION >							#
#  < wuhun@oregonstate.edu>			    #
#										#
#########################################
my $name = "Ricardo Wu";

#########################################
##
##  ETHICS Reminder
##
##  Yes: use the internet to learn Raku
##
##  No: don't use other people to do your work
##
#########################################

#########################################
# VARIABLE DEFINITIONS 
#########################################

# pseudo-constants...
# ... the tests override your choice, so
#     you can set your preferred value
my $STOP_WORDS = 0;           # flag - filter stopwords, 0 (off) | 1 (on)
my $DEBUG = 0;				  # flag - debug words, 0 (off) | 1 (on)
my $SEQUENCE_LENGTH = 10;	  # length of song title, suggested default 10
my $FILE = "";

# variable initialization...
# ... you will use all three at some point

# array of song tracks
my @tracks = ();
# hash of hashes for bigram counts
my %counts = ();
# hash of words already used in current sequence, reset for new sequence
my %word_history = ();


#########################################
# Functions that you will edit
#########################################

# This extracts a title from the raw track input line
sub extract_title {
	if ($DEBUG) {say "<extracting titles>\n";}
	my @tracktitles = ();
	
	for @tracks -> $track { 
	
		################
		# LAB 1 TASK 1 #
		################
		## Edit the regex below to capture only song title
		##
		if ($track ~~ /(.*)/) {
			$track ~~/^^.*\<SEP\>.*\<SEP\>.*\<SEP\>(.*)$$/;
			##

			# Old (Wrong one): rx/^^ .* \^<SEP>? .* \^<SEP>? .* \^<SEP>? (.*) $$/
			# Reasons of old error:
			# 1. I put my original regex into line 60 (limiting options).
			# 2. used exact match, not separate special characters.

			##
		############################# End Task 1
			
			# $0 should be the title caught by regex first set of parens
			# It is added to end of the array		
			@tracktitles.push: $0;
		}
	} 
	# Updates @tracks
	return @tracktitles;
}

# This removes comments and parenthetical information
sub comments {
	if ($DEBUG) {say "<filtering comments>\n";}
	my @filteredtitles = ();

	my $bracket = /\(.*/;
	my $squareBracket = /\[.*/;
	my $curlyBracket = /\{.*/;
	my $backwardSlash = /\\.*/;
	my $forwardSlash = /\/.*/;
	my $underScore = /_.*/;
	my $minus = /\-.*/;
	my $column = /\:.*/;
	my $quotation = /"\"".*/;
	my $leftQuote = /\`.*/; #backtick
	my $plus = /\+.*/ ;
	my $equal = /\=.*/;
	my $feature = /feat\..*/; #the . is special character, thus it needs to use backslash.

	# This loops through each track
	for @tracks -> $title { 

		##########################
		# LAB 1 TASK 2           #
		##########################
		## Add regex substitutions to remove superflous comments and all that follows them
		## Assign to $_ with smartmatcher (~~)
		########################## 
		$_ = $title;

		# Uncomment and replace ... with a substition for ( and anything that follows
		#print "\n $_";
		$_ ~~ s:g/$bracket//;
		#print "\n $_";
		$_ ~~ s:g/$squareBracket//;
		# # print "\n $_";
		$_ ~~ s:g/$curlyBracket//;
		#print "\n $_";
		$_ ~~ s:g/$backwardSlash//;
		#print "\n $_";
		$_ ~~ s:g/$forwardSlash//;
		#print "\n $_";
		$_ ~~ s:g/$underScore//;
		#print "\n $_";
		$_ ~~ s:g/$minus//;
		#print "\n $_";
		$_ ~~ s:g/$column//;
		#print "\n $_";
		$_ ~~ s:g/$quotation//;
		#print "\n $_";
		$_ ~~ s:g/$leftQuote//;
		#print "\n $_";
		$_ ~~ s:g/$plus//;
		#print "\n $_";
		$_ ~~ s:g/$equal//;
		#print "\n $_";
		$_ ~~ s:g/$feature//;
		#print "\n $_";
		#print "\n";

		# Repeat for the other symbols
		# Replace them with space.

		########################## End Task 2
		
		# Add the edited $title to the new array of titles
		@filteredtitles.push: $_;
	}
	# Updates @tracks
	return @filteredtitles;
}

# This removes punctutation
sub punctuation {
	if ($DEBUG) {say "<filtering punctuation>\n";}
	my @filteredtitles = ();

	my $question = /\?/;
	my $upsidedownQuestion = /\x[00BF]/;
	my $exclaimation = /\!/;
	my $upsidedownExclaim = /\x[00A1]/;
	my $periodOnly = /\./;
	my $semicolumn = /\;/;
	my $columnSign = /\:/;
	my $andSign = /\&/;
	my $dollarsign = /\$/ ;
	my $asterisk = /\*/;
	my $littleMouse = /\@/;
	my $percent = /\%/;
	my $poundSign = /\#/;
	my $OR = /\|/ ;

	##########################
	# LAB 1 TASK 3           #
	##########################
	## Add regex substitutions to remove punctuation
	## Remember to permit the apostrophe ' (near enter key)
	## Use the g (greedy) directive
	##########################
	
	for @tracks -> $title { 
		##########################
		$_ = $title;
		# Uncomment and replace ... with a substition for ?
		# print "\n $_";
		$_ ~~ s:g /$question//;
		# print "\n $_";
		$_ ~~ s:g /$upsidedownQuestion//;
		# print "\n $_";
		$_ ~~ s:g /$exclaimation//;
		# print "\n $_";
		$_ ~~ s:g /$upsidedownExclaim//;
		# print "\n $_";
		$_ ~~ s:g /$periodOnly//;
		# print "\n $_";
		$_ ~~ s:g /$semicolumn//;
		# print "\n $_";
		$_ ~~ s:g /$columnSign//;
		# print "\n $_";
		$_ ~~ s:g /$andSign//;
		# print "\n $_";
		$_ ~~ s:g /$dollarsign//;
		# print "\n $_";
		$_ ~~ s:g /$asterisk//;
		# print "\n $_";
		$_ ~~ s:g /$littleMouse//;
		# print "\n $_";
		$_ ~~ s:g /$percent//;
		# print "\n $_";
		$_ ~~ s:g /$poundSign//;
		# print "\n $_";
		$_ ~~ s:g /$OR//;
		# print "\n $_";
		# print "\n";

		# Repeat for the other symbols
		# Same structure as Task 2.

		########################## End Task 3
		# Add the edited $title to the new array of titles
		@filteredtitles.push: $_;
	}
		
	# Updates @tracks	
	return @filteredtitles;			
}


# This removes non-English characters, trailing whitespace, and blank titles
sub clean {
	if ($DEBUG) {say "<filtering non-ASCII characters>\n";}
	my @filteredtitles = ();

	my $i = 1;

	##########################
	# TASK 4, 5, 6, 7 Below  #
	##########################
	## These are small tasks, where each "<your code here>"
	##   will be either a regex substitution
	##   or an if statement and a subsequent action (e.g. skip to next without adding)
	##########################

	# This loops through each track
	for @tracks -> $title {

		##########################
		# LAB 1 TASK 4           #
		##########################
		## Add regex substitutions to (1) trim leading and trailing whitespace
		##    and then (2) leading and trailing apostrophes.
		## There will be some trailing apostrophes left after the trailing whitespace is removed
		##########################

		# replace leading/trailing apostrophe
		$_ = $title;
		my $ti = $_;
		#print "$_ =============================================================== \n";

		# Uncomment and replace ... with a substition to trim apostrophes
		# $_ ~~ ...    # trim leading apostrophes
		#$_ ~~ s/ ^^ "\'" (.*) $$ | ^^ "\ \'" (.*) $$ /$0/;
		$_ ~~ s/ ^^\' //;
		#$_ ~~ s/ ^^\'(.*)|^^\s\'(.*) /$0/;

		# $_ ~~ ...    # trim trailing apostrophes
		#$_ ~~ s/ ^^ (.*) "\'" $$ | ^^ (.*) "\'\ " $$ /$0/;
		$_ ~~ s/ \'$$ //;
		#_ ~~ s/ (.*)\'$$|(.*)\'\s /$0/;


		# Uncomment and replace ... with a substition to trim whitespace
		# $_ ~~ ...    # trim leading whitespace
		$_ ~~ s/ ^^\s //;
		#$_ ~~ s/ ^^\s(.*) /$0/;
		# $_ ~~ ...    # trim trailing whitespace
		#$_ ~~ s/ ^^ (.*) "\ " $$ /$0/;
		$_ ~~ s/ \s$$ //;

		#print "{$i}:.{$ti}. \t--> .{$_}.\n";
		#$i++;

		########################## End Task 4


		##########################
		# LAB 1 TASK 5           #
		##########################
		## Filter out non-ASCII characters
		## (letters, numbers, apostophe, space allowed)
		##########################

		# Use "next;" to skip lines containing non-ASCII characters
		##########################
		##                      ##
		## <Insert code here>   ##
		my $letterl = /<[A..Z]>/;
		my $letters = /<[a..z]>/;
		my $numbers = /<[0..9]>/;
		my $apostophe = /\'/;
		my $space = /\s/;

		if not $_ ~~ /^^[$letterl|$letters|$numbers|$apostophe|$space]*$$/ {
			next;
		}
		##                      ##
		##########################
		########################## End Task 5



		##########################
		# LAB 1 TASK 6           #
		##########################
		## Skip title if (1) blank contains only whitespace,
		## or (2) contains only apostrophes
		##########################

		# skip if only contains whitespace
		##########################
		##                      ##
		## <Insert code here>   ##
		if $_ ~~ / ^\s*$ / {
			next;
		}
		#if $_ ~~ /\s / {
		#	next;
		#}
		##                      ##
		##########################


		# skip if only contains only an apostrophe
		##########################
		##                      ##
		## <Insert code here>   ##
		if $_ ~~ / ^\'$ / {
			next;
		}
		#if $_ ~~ /"\'"/ {
		#	next;
		#}
		##                      ##
		##########################

		########################## End Task 6


		##########################
		# LAB 1 TASK 7           #
		##########################
		## Set to lowercase
		$_ = $_.lc;

		# print "{$i}:.{$ti}. \t--> .{$_}.\n";
		# $i++;
		##########################		
		# minor edit needed to this line (raku has a handy function)
		@filteredtitles.push: $_;
		########################## End Task 7

	}
	# Updates @tracks	
	return @filteredtitles;
}
	
# This removes common stopwords	
sub stopwords {
	if ($DEBUG) {say "<filtering stopwords>\n";}
	my @filteredtitles = ();

	# Don't write it here!!
	# It over-engineered the program.
#
#	my $a =/^a\s$/;
#	my $an = /^an$/;
#	my $and = /^and$/;
#	my $by = /^by$/;
#	my $for = /^for$/;
#	my $from = /^from$/;
#	my $in = /^in$/;
#	my $of = /^of$/;
#	my $on = /^on$/;
#	my $or = /^or$/;
#	my $out = /^out$/;
#	my $the = /^the$/;
#	my $to = /^to$/;
#	my $with = /^with$/;

	##########################
	# LAB 1 TASK 8 #
	##########################
	## Add regex substitutions to remove common stopwords
	## Use <|w> (word boundaries) in your regexs
	## Also trim the single space following the word
	## Use the g (greedy) directive
	## Use the i (case insensitive) directive
	##########################
	for @tracks -> $title { 

		##########################
		$_ = $title;

		# Uncomment and replace ... with a substition for "a"

		# Actually, no need for pointers above, I could write it here instead:
		# Substitution, global seach & case insensitive.


		$_ ~~ s:g:i/<|w>a<|w>\s//;
		$_ ~~ s:g:i/<|w>an<|w>\s//;
		$_ ~~ s:g:i/<|w>and<|w>\s//;
		$_ ~~ s:g:i/<|w>by<|w>\s//;
		$_ ~~ s:g:i/<|w>for<|w>\s//;
		$_ ~~ s:g:i/<|w>from<|w>\s//;
		$_ ~~ s:g:i/<|w>in<|w>\s//;
		$_ ~~ s:g:i/<|w>of<|w>\s//;
		$_ ~~ s:g:i/<|w>on<|w>\s//;
		$_ ~~ s:g:i/<|w>or<|w>\s//;
		$_ ~~ s:g:i/<|w>out<|w>\s//;
		$_ ~~ s:g:i/<|w>the<|w>\s//;
		$_ ~~ s:g:i/<|w>to<|w>\s//;
		$_ ~~ s:g:i/<|w>with<|w>\s//;


		#old work, has error:
#		$_ ~~ s:g/(\w*)$an<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$and<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$by<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$for<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$from<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$in<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$of<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$on<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$or<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$out<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$the<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$to<|w>(\w*)//;
#		$_ ~~ s:g/(\w*)$with<|w>(\w*)//;

		# unable to crack the code....

		# Repeat for the other stopwords

		##########################
		# Add the edited $title to the new array of titles
		@filteredtitles.push: $_;
	}
	
	########################## End Task 8
	
	# Updates @tracks	
	return @filteredtitles;			
}


# This splits the tracks into words and builds the bi-gram model
sub build_bigrams {

	##########################
	# LAB 2 TASK 1: Bigram Counts
	##########################
	## Loop through the tracks to split the titles into words. 
	## Count all adjacent pairs.
	##
	## Following your diligent work, the %counts hash (declared up yonder) 
	## should contain the bigram counts for all consecutive word pairs across
	## the entire dataset of tracks
	##
	## Plan carefully.  It is not a lot of code.
	##
	## My approach is ~10 lines (4 of which are just a closing curly-brace) 
	##    (the take away is that it does not take much; 
	##     there is no need to take exactly 10 lines)
	##########################
	
	
	# What did I do here?
    # I say "from the scalar of title to the array of track"
    # I'll declare a variable called split_words to scalar title, spilt them in the @split.
    # If there's more than 1 element(word) in my title,
    # I'll +1 word count in my while loop, until it's done.

	for @tracks -> $title {
		my @split = $title.split(" ");
		if @split.elems > 1 {
			my $i = 1;
			while $i < @split.elems() {
				if %counts{@split[$i - 1]}{@split[$i]}:exists {
					my $value = %counts{@split[$i - 1]}{@split[$i]};
					%counts{@split[$i - 1]}{@split[$i]} = $value + 1;
				}else {
					%counts{@split[$i - 1]}{@split[$i]} = 1;
				}
				$i += 1;
			}
		}
	}

#	for @tracks -> $title {
#		$_ = $title;
#		my @split = $_.split(' ');
#
#				if $_.elems > 1 {
#					while index < $_.elems-1 {
#			    		if %counts{index}{index+1}:exists {
#							%counts{index}{index+1}++;
#			    		}
#			    		else {
#			    			%counts{index}{index+1}=1;
#			    		}
#			    	}
#			    }
#
#
#
#	}





	# I don't know why this part doesn't work.


	########################## End Task Bigram Counts
	
	if ($DEBUG) {say "<bigram model built>\n";}	
}


# This finds the most-common-word (mcw) to follow the given word
sub mcw {
 	# declare value to cut-down compile time:
#    my $local_hash;
#    my $inner_hash;
#    my $key1;
#    my $key2;
#    my $val;
#    my $current_key;
#    my $current_value;

	# Seed word (arg) for which we find the next word
	my $word = @_[0];
	# Store the most common next word in this variable and return it.
	my $best_word = '';
	
	##########################
	# LAB 2 TASK 2: MCW
	##########################
	##
	## Find all available "next" words for $word
	## Sort them (there is a function for that)
	##   so your results are deterministic and match the tests
	##
	## Iterate through all the available words
	##   that follow $word in the %counts
	##
	## Remember to check the %word_history	
	##   and skip that word if used before
	##
	## Find the candidate word with highest count,
	##   update $best_word (it gets returned)
    ## 
	## In case of ties, stick with first one found
	##    (i.e. use strictly > in your count comparison if)
	##    that way you make the same choice the tests do
	##
	## This comment is longer than your code will be for this task. 
	##########################
	
	
	##########################
	# What am I going to do here:
	# building a for-loop, for each title in track array: (o)
	# assign the pointer to title, sort it: (o)
	# building hashes of word counts: (o), line_572~576
    # prevent repetitive counts & override the higher count: (x), 
    # -> unsure about the statement for finding out the highest word count,
    # as well as the repetitive count.
    # return the highest counts:

	if %counts{$word}:exists {
		my $temp_key;
		my $temp_val;
		for %counts{$word}.sort {
			if $temp_val {
				if $_.value > $temp_val {
					$temp_key = $_.keys;
					$temp_val = $_.value;
				}
			}else {
				$temp_key = $_.keys;
				$temp_val = $_.value;
			}
		}
		$best_word = $temp_key.Str;
	}

#    for @track -> $title {
#      my $_ = $title;
#      my $current_key;
#      my $current_value;
#      $_ = $_sort();
#      %local_hash = $title;
#      %inner_hash = %local_hash<>:v;
#      $key1 = %local_hash<>:k;
#      $key2 = %local_hash<>:k;
#      $val = %local_hash<>:v;
#      %counts{$key1.Str}{$key2.Str} = $val.Str;
#
#		if %count{$key1}.kv:exists {
#			for %counts{$key1}.kv -> $current_key,$current_value {
#				if $key1 > $current_value {
#					%counts{$key1.Str}{$key.Str} = $current_value;
#      			}
#      			else {
#					%counts{$key1.Str}{$key2.Str} = $best_word;
#      			}
#      		}
#
#
#
#    }


	########################## End Task MCW
	

	if ($DEBUG) {say "  <mcw for \'$word\' is \'$best_word'\>\n";}
	
	# return the most common word to follow word
	return $best_word
}



# This builds a song title based on mcw
sub sequence {
	if ($DEBUG) {say "<sequence for \'$_[0]\'>\n";}	
	
	# clear word history for new sequence
	%word_history = ();
		
	##########################
	# LAB 2 TASK 3: Build Song Title
	##########################
	## Use the seed word to build a sequence.
	## For each word, look up the mcw
	## Add to sequence.
	## Repeat until next word is empty or newline
	## Mind the max $SEQUENCE_LENGTH
	## Remember to track word history using %word_history
	## My solution is about 12 lines (and could have been less)
	##########################

	# $SEQUENCE_LENGTH is at line 29
	# I built a loop, suggesting that if my seedword hasn't reach length limit (10 here),
	# it will keep adding up.
	loop (my $seedword = 0; $seedword < $SEQUENCE_LENGTH; $seedword++) {
		# If the counts has successfully store inside the global variable, %counts and it exists
		if %counts{words}:exists {
			# It will add the seedword (building the title, setting word history as false so it can moved on.
			$seedword++;
			%word_history = False;
		}else {
			# If it wasn't shown in the sequence, it'll be added.
			$seedword = 1;
			%word_history = True;
		}

	}


		
	# return the sequence you created instead of this measely string
	return "ERROR: SEQUENCE 404";
	########################## End Task Song Title
}

##############################################################################
##             End Functions that students edit                              #
##############################################################################

##############################
##                           #
##     READ ONLY BELOW       #
##                           #
##############################

##############################
##############################
##############################
##                           #
##     Menu System           #
##                           # 
##############################
##                           # 
##  Read and understand      #
##   how to use the commands #
##                           # 
##  You do not need to edit  # 
##    the menu code below.   # 
##                           # 
##  You may expand the menu  # 
##   to you add your own     #
##   commands, if desired.   # 
##  				         # 
##  Do not break any of the  # 
##   existing command rules  # 
##   or you will fail tests. # 
##                           # 
##############################

# This is the "command" loop that runs until end-of-input
for lines() {    
	
	# split line into array of words
	my @input = split(/\s+/, $_);	
	# command is @input[0], first word
    my $command = lc(@input[0]);
	# argument is @input[1], second word
	
	if ($command eq "load") { 
		# load the input file
		my $file = lc(@input[1]);
		$FILE = $file;				
		load($file);	
	}elsif ($command eq "length") { 	
		# change the sequence length
		if ($DEBUG) {say "<sequence length " ~ @input[1] ~ ">\n";}
		$SEQUENCE_LENGTH = @input[1];
	}elsif ($command eq "debug") { 
		# toggle debug mode on/off
		if (lc(@input[1]) eq "on") {
			if ($DEBUG) {say "<debug on>\n";}
			$DEBUG = 1;
		}elsif (lc(@input[1]) eq "off") {
			if ($DEBUG) {say "<debug off>\n";}
			$DEBUG = 0;
		}else {
			say "**Unrecognized argument to debug: " ~ @input[1] ~ "\n";
		}
	}elsif ($command eq "count") { 
		if (lc(@input[1]) eq "tracks") {
			# count the number of lines in @tracks			
			count_lines(@tracks);
		}elsif (lc(@input[1]) eq "words") {
			# count the number of words in @tracks
			count_words(@tracks);
		}elsif (lc(@input[1]) eq "characters") {
			# count the number of characters in @tracks
			count_characters(@tracks);
		}else {
			say "**Unrecognized argument: " ~ @input[1] ~ "\n";
		}
	}elsif ($command eq "stopwords") { 
		# toggle stopwords on/off
		if (lc(@input[1]) eq "on") {
			if ($DEBUG) {say "<stopwords on>\n";}
			$STOP_WORDS = 1;
		}elsif (lc(@input[1]) eq "off") {
			if ($DEBUG) {say "<stopwords off>\n";}
			$STOP_WORDS = 0;
		}else {
			say "**Unrecognized argument: " ~ @input[1] ~ "\n";
		}
	}elsif ($command eq "filter") { 
		if (@input[1] eq "title") {		
			# extract the title from the line
			@tracks = extract_title();
		}elsif (@input[1] eq "comments") {
			# filter out extra phrases from the titles
			@tracks = comments();
		}elsif (@input[1] eq "punctuation") {
			# filter out punctuation		
			@tracks = punctuation();
		}elsif (@input[1] eq "unicode") {
			# filter out non-ASCII characters		
			@tracks = clean();
		}elsif (@input[1] eq "stopwords" && $STOP_WORDS) {	
			# filter out common words, if enabled
			@tracks = stopwords();		
		}else {
			say "**Unrecognized argument to stopwords: " ~ @input[1] ~ "\n";
		}	
	}elsif ($command eq "preprocess") { 
		# preprocess does all of the filtering tasks at once and builds bigrams
		
		# first, extract the title from the line
		@tracks = extract_title();
		# next, filter out extra phrases from the titles
		@tracks = comments();
		# next, filter out punctuation
		@tracks = punctuation();
		# next, filter out non-ASCII characters, blank titles
		@tracks = clean();		
		# next, filter out common words, if enabled
		if ($STOP_WORDS) {@tracks = stopwords();}
		
		# build bi-gram model counting occurences of word pairs
		build_bigrams();
	}elsif ($command eq "build") {
		# build bi-gram model counting occurences of word pairs
		build_bigrams();
	}elsif ($command eq "mcw") {
		# say the most-common-word to follow given word
		say mcw(lc(@input[1]));
	}elsif ($command eq "sequence") { 
		# say a song title based on the given word
		say sequence(lc(@input[1])).Str;
	}elsif ($command eq "print") {
		if (@input[1]) {
			say_some_tracks(val(@input[1]));
		}else {
			say_all_tracks(@tracks);
		}
	}elsif ($command eq "author") { 
		say "Lab1 by $name run";		
	}elsif ($command eq "name") { 
		say sequence(lc($name));               
	}elsif ($command eq "random") { 
		say sequence((%counts.keys)[%counts.keys.rand]).Str;			
	}else {
		# warn user if command was ignored
		say "**Unrecognized command: " ~ $command;
	}	
}


##############################
##############################
##############################
##                           #
##     Helper Functions      #
##                           # 
##############################
##                           # 
## Below contains important  # 
## functions the menu uses.  # 
##                           # 
##                           #
## Feel free to look around. #
##                           # 
## Help yourself to the      #
##     cookies and punch.    #
##                           #
## Look but don't touch.     #
##                           #
## You break it,             #
##         you bought it!    # 
##############################

# This loops through N lines of the array 
sub say_some_tracks($n) {
	if ($DEBUG) {say "<printing $n tracks>\n";}	
	loop (my $i=0; $i < $n; $i++) {
		say @tracks[$i];
	} 
}

# This loops through each line of the array
sub say_all_tracks {	
	if ($DEBUG) {say "<saying all tracks>\n";}	
	# are you sure you want to? (use CTRL+C to kill it)
	my $fh = open "tracks.out", :w;
	for (@_) { 
		$fh.say($_);
	} 
	$fh.close;
}

# Count lines of array
sub count_lines {
	if ($DEBUG) {say "<counting number of tracks>\n";}
	say @_.elems;
}

# Count words, after splitting on whitespace
sub count_words {
	if ($DEBUG) {say "<counting number of words>\n";}
	my $word_count = @_.words;
	say $word_count.elems;
}

# Count individual characters
sub count_characters {
	if ($DEBUG) {say "<counting number of characters>\n";}
	say @_.chars;
}

# Loads the tracks file into an array
sub load {
	for @_.IO.lines -> $line {
		@tracks.push($line); 
	}
	if ($DEBUG) {say "<loaded " ~ $FILE ~ ">"};	
}