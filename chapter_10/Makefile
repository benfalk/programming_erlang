# leave these lines alone
.SUFFIXES: .erl .beam .yrl

.erl.beam:
	erlc -W $<
.yrl.erl:
	erlc -W $<

ERL = erl -boot start_clean 

# Here's a list of the erlang modules you want compiling
# If the modules don't fit onto one line add a \ character 
# to the end of the line and continue on the next line

# Edit the lines below
MODS = my_module

# The first target in any makefile is the default target.
# If you just type "make" then "make all" is assumed (because
#   "all" is the first target in this makefile)

all: compile

compile: ${MODS:%=%.beam}
	
## special compilation requirements are added here

special1.beam: special1.erl    
	${ERL} -Dflag1 -W0 special1.erl

## run an application from the makefile

application1: compile
	${ERL} -pa Dir1  -s application1 start Arg1 Arg2 

# remove all the code

clean:	
	rm -rf *.beam erl_crash.dump
