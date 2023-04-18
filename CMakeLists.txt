cmake_minimum_required(VERSION 3.1)
project(luavgl LANGUAGES C VERSION 0.0.1)
option(BUILD_SIMULATOR "Build lvgl simulator with luavgl support" ON)
option(FIND_LUA_PACKAGE "Find lua package" OFF) # may manually set LUA_INCLUDE_DIR

option(USE_LUAJIT "Use luajit instead of lua" OFF)


set(PKG_CONFIG_EXECUTABLE "/bin/false")

if (BUILD_SIMULATOR)
    add_compile_options(-g -O3)
endif(BUILD_SIMULATOR)

add_library(luavgl STATIC "src/luavgl.c")

# Search in the 'cmake' directory for additional CMake modules.
list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)

add_subdirectory(deps/Lua)
list(APPEND LUA_LINK_LIBS lua_static)

target_include_directories(luavgl PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)
target_include_directories(luavgl PRIVATE ${LUA_INCLUDE_DIRS}) # need lua.h, lauxlib.h
target_link_libraries(luavgl ${LUA_LINK_LIBS})
target_compile_options(luavgl PRIVATE -Wall -Werror)

add_library(duml_hal SHARED "libshims/duml_hal.c")

if (BUILD_SIMULATOR)
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/simulator) # need lv_conf.h and lv_drv_conf.h
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/deps/lua-compat-5.3/c-api)
    add_compile_definitions(LUAVGL_EXAMPLE_DIR="/tmp/examples")

    add_subdirectory(deps/lvgl)
    #add_subdirectory(deps/lv_drivers)
    add_subdirectory(simulator)
    target_include_directories(luavgl PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/deps/lvgl) # need lvgl.h
endif(BUILD_SIMULATOR)

