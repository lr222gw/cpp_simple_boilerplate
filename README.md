# cpp_simple_boilerplate
## what is this?
Simple boilerplate project for c++ in unix enviroments.
!["Picture of the script"](md/picofscript "The script")

## Requirements 
- OS: hopefully works on all Linux distros... 
- VSCode : I think it must be the microsoft one, since it has some proprietary packages
- Clang : hardcoded into the CmakePresets, also due to the use of sanitizers
- **Feel free to create a github issue if I missed something**

## Recommendations
*Not requirments but highly recommended:*
- cppcheck: Used by a vscode plugin to give user hints. *(If not installed, please disable the 'Advanced Lint' extension in vscode)*
- ccache: Enables faster compiling of already compiled sources

## How to use it?
- Download the repo
- Place the 'cpp_simple_boilerplate' directory wherever you want your project to be
- Rename the directory to whatever you want to name the project dir
- cd into cpp_simple_boilerplate and run ./setup_boilerplate.sh 
- Once done just delete the setup_boilerplate.sh script
- When opening the vscode workspace, make sure to press "Yes, use this setting" in order for clangd to work
 ![vscode warning, press "yes, use this setting"](md/workspacewarning  "vscode warning")
- In the bottom of vscode, pick Preset (debug or release)
 - Run cmake configure in vscode (shift+ctrl+p, search cmake, pick cmake configure)
- Note: Before you compile your program you will notice that generated/cmake_inputs.h is causing a error, it will dissapear after compilation
- Compile and start work on your project!

### Notes and Tips on what else to do... 
- Remove the bloated bar at the left side of vscode, buttons can be accessed on the bottom blue bar now... 
- The cmake_inputs.h is not needed and can be removed from the source code, its there as a template in case I need to make data (version, name, etc) from cmake available in c++... 
- You can use the ctrl+shift+p, search for "restart language server" if autocompletion and syntax highlighting is acting up

## Who will use it?
Made for myself, but anyone can use it. Main purpouse is to make the setup process of a new project faster...

Alot of stuff is hardcoded into the CMakeLists.txt, the main thing the script aids with is changing the project name and executable. 
## What does it contain?
- cmake project 
- - Automatic adding of sourcefiles (*I know its not recommended but I like it...*)
- - Use of ccache to make compiling faster
- - Use of Exporting compile commands database used by clang
- - Optimization flags: 
- - - INTERPROCEDURAL_OPTIMIZATION 
- - - CMAKE_CXX_INCLUDE_WHAT_YOU_USE
- - Use of CMakePresets.json to define debug/release build used by vscode
-  Vscode workspace
- - Workspace recommended plugins to make life easier
- - - *CodeLLDB*: To debug your program
- - - *Clangd*: enables code completion, compile errors, etc. 
- - - *GitLens, Git History, Git Graph*: Tools to make working with git very nice. 
- - - *Cmake, cmake-format and CMake Tools*: Makes life writing cmake easier...
- - -  *Close sidebar on debug seession end*: cant live without it... 
- - - *C/C++ Advanced Lint*: Gives you alot of nice hints of what to avoid in your c++ code 
- - - *Activus Bar*: Much sleeker gui for navigating in vscode 
- - - *Back & Forth*; easy go to, get back to the previous position your caret was
- - - *Workspace*; Hide stuff you dont want to see in the vscode explorer
- - - *C++ Insights*: lets you view C++ Insights inside vscode...
- Use of clang address sanitizer (to check memory leaks, etc)
- Use of Clang format 
- 

## Notes
- The vscode project will probably not work as intended if microsofts C/C++ plugins are enabled, This project uses clangd and CodeLLDB instead... 
- To get the vscode extension "Advanced lint" to work you will have to install cppcheck 
