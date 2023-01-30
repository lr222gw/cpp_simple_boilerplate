#!/bin/bash

printf "Welcome to the boilerplate setup!\nThis setup will rename the output file and project file to suit any project.\n\nOnce the script is run it can (and should) be removed!\n\n"


CURRENT_CMAKE_VERSION=$(cmake --version | head -n 1 | sed "s/cmake version //g")
CMAKE_VERSION_MAJOR=$(printf $CURRENT_CMAKE_VERSION | sed -E "s/([0-9]*)\.[0-9]*\.[0-9]*/\1/g")
CMAKE_VERSION_MINOR=$(printf $CURRENT_CMAKE_VERSION | sed -E "s/[0-9]*\.([0-9]*)\.[0-9]*/\1/g")
CMAKE_VERSION_PATCH=$(printf $CURRENT_CMAKE_VERSION | sed -E "s/[0-9]*\.[0-9]*\.([0-9]*)/\1/g")

while true; do     
    read -p "Enter a name for the project: "        project_name    
    read -p "Enter a name for the executable: "     project_executable    
    read -p "Enter a description of the project: "  project_description
    
    printf "\nEnter information about cmake (Your system currently has version [${CURRENT_CMAKE_VERSION}] )\n"
    read -p "Enter required minimum cmake version <MAJOR>: "  cmake_major
    read -p "Enter required minimum cmake version <MINOR>: "  cmake_minor
    read -p "Enter required minimum cmake version <PATCH> (use \"-\" or blank to ignore...): "  cmake_patch

    if [[ "$cmake_patch" == "-" ]]; then
        cmake_patch = ""
    fi;
    

    printf "\nPlease confirm that the following details are correct:\n"
    printf "\tProject name       : %s \n" "${project_name}"
    printf "\tProject description: %s \n" "$project_description"
    printf "\tProject executable : %s \n" "${project_executable}"
    if [[ "$cmake_patch" == "" ]]; then
        printf "\tCMAKE Version      : %s.%s \n" "${cmake_major}" "${cmake_minor}"
    else
        printf "\tCMAKE Version      : %s.%s.%s \n" "${cmake_major}" "${cmake_minor}" "${cmake_patch}"
    fi; 
    printf "\n[y = yes], [n = no (no and retry)], [q = quit (no + exit)]\n"
    read userInput
    if [ "${userInput}" == "y" ]; then
       break;
    elif [ "${userInput}" == "q" ]; then
        exit;
    fi; 
done


###########################################
############# Vscode Workspace ##############
###########################################

# Replace name of workspace
# cpp_simple_boilerplate.code-workspace
mv cpp_simple_boilerplate.code-workspace ${project_name}.code-workspace


###########################################
############# CMakeLists.txt ##############
###########################################

# Set cmake version 
 # Major: <CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MAJOR>
 # Minor: <CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MINOR>
 # Patch: <CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_PATCH>

 # Set cmake version for CMakeLists.txt
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MAJOR>/${cmake_major}/g" CMakeLists.txt
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MINOR>/${cmake_minor}/g" CMakeLists.txt

if [[ "$cmake_patch" != "" ]]; then
    sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_PATCH>/.${cmake_patch}/g" CMakeLists.txt
else 
    sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_PATCH>//g" CMakeLists.txt
fi; 

 
# Replace project name with 
# <CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>/${project_name}/g" CMakeLists.txt

# Replace project executable with 
# <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>/${project_executable}/g" CMakeLists.txt

# Replace project description
# <<CPP_SIMPLE_BOILERPLATE_PROJECT_DESCRIPTION>>
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_DESCRIPTION>/${project_description}/g" CMakeLists.txt

# Remove early cmake exit
sed -i -E "/#CPP_SIMPLE_BOILERPLATE_PROJECT_NOT_INITIALIZED/{N;d;}" CMakeLists.txt

###########################################
############ CMakePrests.json #############
###########################################

# Set cmake version for CMakePresets.json
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MAJOR>/${cmake_major}/g" CMakePresets.json
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MINOR>/${cmake_minor}/g" CMakePresets.json

if [[ "$cmake_patch" != "" ]]; then
    sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_PATCH>/${cmake_patch}/g" CMakePresets.json
else 
    sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_PATCH>/0/g" CMakePresets.json
fi; 

# Replace project name with 
# <CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>/${project_name}/g" CMakePresets.json

# Replace project executable with 
# <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>
sed -i -E "s/<CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>/${project_executable}/g" CMakePresets.json
