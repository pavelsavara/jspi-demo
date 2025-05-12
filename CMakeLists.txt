cmake_minimum_required(VERSION 3.14)

# Project name and version
project(emscripten_hello_world VERSION 1.0 LANGUAGES C)

# Set the source file
set(SRC src/main.c)

# Set the output file
set(OUT index.html)

# Add the executable target
add_executable(${OUT} ${SRC})

# Specify the compiler and flags
set(CMAKE_C_COMPILER emcc.bat)
set(CMAKE_C_FLAGS "-O0")

# Set the output properties for Emscripten
set_target_properties(${OUT} PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_NAME "hello"
    LINK_FLAGS "-sEXPORT_ES6=1 -sMODULARIZE=1 -sEXPORT_NAME=HelloModule -sEXPORTED_RUNTIME_METHODS=ccall,cwrap -sJSPI_EXPORTS=_mono -sEXPORTED_FUNCTIONS=_malloc,_main,_mono,_remono -sJSPI=1 -sJSPI_EXPORTS=mono -sJSPI_IMPORTS=fetchmono --js-library ${CMAKE_SOURCE_DIR}/src/library_jspi.js"
)

# Copy the index.html file to the build directory
add_custom_command(
    TARGET ${OUT} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/src/index.html
    ${CMAKE_BINARY_DIR}/index.html
    COMMENT "Copying index.html to build directory"
)
add_custom_command(
    TARGET ${OUT} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy
    ${CMAKE_SOURCE_DIR}/src/main.js
    ${CMAKE_BINARY_DIR}/main.js
    COMMENT "Copying main.js to build directory"
)
