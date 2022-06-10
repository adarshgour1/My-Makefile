#-----------------------------------------------------------------
#if you are using C program
#following Log statement will be helpful
#define Log(msg, ...)  fprintf(stdout,"#%d:%s\n",__LINE__,__FILE__);   \
                            fprintf(stdout,"DEBUG: " msg" \n",##__VA_ARGS__);
#



#
# 'make'        build executable file 'main'
# 'make clean'  removes all .o and executable files
#

# define the Cpp compiler to use
CXX = g++

# define any compile-time flags
CXXFLAGS	:= -std=c++17 -Wall -Wextra -g

# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
LFLAGS =

# define output directory
OUTPUT	:= $(PWD)/output

# define source directory
SRC		:= $(PWD)/src

# define source directory
OBJ		:= $(PWD)/obj

# define include directory
INCLUDE	:= $(PWD)/include

# define lib directory
LIB		:= lib

MAIN	:= main
SOURCEDIRS	:= $(shell find $(SRC) -type d)
OBJDIRS		:= $(shell find $(OBJ) -type d)
INCLUDEDIRS	:= $(shell find $(INCLUDE) -type d)
LIBDIRS		:= $(shell find $(LIB) -type d)
FIXPATH = $1
RM = rm -f
MD	:= mkdir -p

# define any directories containing header files other than /usr/include
INCLUDES	:= $(patsubst %,-I%, $(INCLUDEDIRS:%/=%))

# define the C libs
LIBS		:= $(patsubst %,-L%, $(LIBDIRS:%/=%))

# define the C source files
SOURCES		:= $(shell find $(SOURCEDIRS)/* -maxdepth 1 | grep -v main)


# define the C object files 
OBJECTS		:= $(SOURCES:$(SOURCEDIRS)/%.cpp=$(OBJDIRS)/%.o)


all: $(OBJECTS)
	@tput setaf 1
	@echo
	@echo -----------------Generating Binaries------------------------------
	@echo
	$(CXX) $(CXXFLAGS) $(INCLUDES) -o $(OUTPUT)/main.bin $(SOURCEDIRS)/main.cpp $(OBJECTS) $(LFLAGS) $(LIBS)
	@echo
	@echo -----------------All Binaries Generated--------------------------
	@echo
	@tput setaf 7


$(OBJECTS):$(SOURCES)
	@tput setaf 27
	@echo
	@echo -----------------Generating Object Files------------------------------
	@echo
	@echo $< : $@
	$(CXX) $(CXXFLAGS) $(INCLUDES) -c $<  -o $@
	@echo
	@echo -----------------Object Files Generated------------------------------
	@echo
	@tput setaf 7

.PHONY: clean
clean:
	$(RM) $(OBJDIRS)/*.o
	@echo Cleanup complete!
