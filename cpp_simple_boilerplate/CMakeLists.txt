#CPP_SIMPLE_BOILERPLATE_PROJECT_NOT_INITIALIZED
message(FATAL_ERROR "Please run the setup_boilerplate.sh script before trying to build!")

cmake_minimum_required(VERSION <CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MAJOR>.<CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_MINOR><CPP_SIMPLE_BOILERPLATE_PROJECT_CMAKE_PATCH>)

project(<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>
        VERSION 0.0.1
        DESCRIPTION "<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME> - <CPP_SIMPLE_BOILERPLATE_PROJECT_DESCRIPTION>"
        LANGUAGES CXX C        
)

# Use CCACHE if it exists
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
    # Compile with CCache if available to speed up compilation
    set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}") # TODO: Do not override "CMAKE_*" variables, it could've been declare before or after this... hmm?
    set(CMAKE_CUDA_COMPILER_LAUNCHER "${CCACHE_PROGRAM}") # CMake 3.9+
else()
    message("Install Ccache to get faster build times!")
endif()

#To make som data from cmake available in c++ 
include(cmake/cmake_cpp_data.cmake)

# Create variable for source files 
set(<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)

# all the source files
FILE(GLOB_RECURSE <CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCES CONFIGURE_DEPENDS
    ${<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCE_DIR}/*.cpp
    ${<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCE_DIR}/*.h
    ${<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCE_DIR}/*.hpp
)
# all the source files
FILE(GLOB_RECURSE <CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_HEADERS CONFIGURE_DEPENDS
    ${<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCE_DIR}/*.h
    ${<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCE_DIR}/*.hpp
)

# Add <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE> target as executable
add_executable(<CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE> )

# Add the vengine sources + imgui sources to the vengine target
target_sources(<CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>
    PRIVATE 
    ${<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>_SOURCES}
)

# Add Sanitizers 
target_compile_options( <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>  PRIVATE $<$<CXX_COMPILER_ID:Clang>: -g -fsanitize=address,leak,undefined -fno-omit-frame-pointer -fsanitize-recover=address        -fsanitize-blacklist=${CMAKE_CURRENT_SOURCE_DIR}/sanitizer_blacklist.txt> )
target_link_options(    <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>  PRIVATE $<$<CXX_COMPILER_ID:Clang>: -g -fsanitize=address,leak,undefined -fno-omit-frame-pointer -fsanitize-memory-track-origins=2 -fsanitize-blacklist=${CMAKE_CURRENT_SOURCE_DIR}/sanitizer_blacklist.txt> )

# measure compiletime
set_property(TARGET <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE> PROPERTY RULE_LAUNCH_COMPILE "${CMAKE_COMMAND} -E time") 

set_target_properties(<CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE> PROPERTIES            
                CXX_STANDARD 20                         # OBS! To use features from 11 and onward. Only use .hpp as header files...
                CXX_EXTENSIONS OFF                      # is this good?...
                EXPORT_COMPILE_COMMANDS ON 
                INTERPROCEDURAL_OPTIMIZATION TRUE       # Will do link time optimizations if available
                LINK_WHAT_YOU_USE TRUE                  # Warns if something unncessary is linked                             
                CMAKE_CXX_INCLUDE_WHAT_YOU_USE TRUE     # Checks if a source file is used, if not then its not included...
                ) 

# ADD target to cmake_inputs, to enable cmake to c++ data transfers...
add_cmake_inputs_to_targets(<CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE> "<CPP_SIMPLE_BOILERPLATE_PROJECT_NAME>")
                
# Link all libraries to vengine target
target_link_libraries(
    <CPP_SIMPLE_BOILERPLATE_PROJECT_EXECUTABLE>
    PUBLIC
)
