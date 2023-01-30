 
# Define a variable in CMake
set(CMAKE_WHOM_TO_GREET "data from CMake")

# Add the header file to your target
function(add_cmake_inputs_to_targets target greet_whom)        
    # Last changes to variables before .h file is generated...
    SET(CMAKE_WHOM_TO_GREET ${greet_whom} )
    
    # Generate a header file in the build directory
    configure_file(cmake/cmake_inputs.h.in ${CMAKE_CURRENT_SOURCE_DIR}/src/generated/cmake_inputs.h)

    # Setting include dir and sources
    target_include_directories(${target} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src/generated)
    target_sources(${target} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src/generated/cmake_inputs.h)
endfunction()

