cmake_minimum_required(VERSION 3.10)

project(simulator)

add_custom_target(run COMMAND simulator)

add_executable(simulator main.c hw/dji_display.c hw/dji_services.c extension.c)
target_link_libraries(simulator luavgl lvgl lvgl::demos lvgl::drivers duml_hal ${LUA_LINK_LIBS})
target_include_directories(simulator PRIVATE ${LUA_INCLUDE_DIRS})
