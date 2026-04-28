cmake_minimum_required(VERSION 3.22)
project(UseStateObservationExample)

find_package(state-observation REQUIRED)

add_executable(main main.cpp)

target_link_libraries(main PRIVATE state-observation::state-observation)
get_target_property(INCLUDES state-observation::state-observation INTERFACE_INCLUDE_DIRECTORIES)
message("state-observation::state-observation include dirs: ${INCLUDES}")

install(TARGETS main
        RUNTIME DESTINATION bin)
