cmake_minimum_required(VERSION 3.22)
project(UseStateObservationExample)

find_package(state-observation REQUIRED)
find_package(jrl-cmakemodules 1.1.2 CONFIG REQUIRED)

add_executable(main main.cpp)

target_link_libraries(main PRIVATE state-observation::state-observation)

get_target_property(INTERFACE_INCLUDES state-observation::state-observation INTERFACE_INCLUDE_DIRECTORIES)
message("state-observation::state-observation include dirs: ${INTERFACE_INCLUDES}")

get_target_property(INCLUDE_DIRS state-observation::state-observation INCLUDE_DIRECTORIES)
message("state-observation::state-observation include dirs: ${INCLUDE_DIRS}")

set(package_targets state-observation::state-observation)

set(properties_to_print
    NAME
    ALIASED_TARGET
    TYPE VERSION
    LOCATION
    INCLUDE_DIRECTORIES
    COMPILE_DEFINITIONS
    COMPILE_OPTIONS
    COMPILE_FEATURES
    COMPILE_FLAGS
    COMPILE_OPTIONS
    LINK_LIBRARIES
    LINK_OPTIONS
    INTERFACE_INCLUDE_DIRECTORIES
    INTERFACE_COMPILE_DEFINITIONS
    INTERFACE_COMPILE_OPTIONS
    INTERFACE_LINK_LIBRARIES
    INTERFACE_LINK_OPTIONS
    CXX_STANDARD
    CXX_EXTENSIONS
    CXX_STANDARD_REQUIRED
)

foreach(target IN LISTS package_targets)
    _jrl_log("")
    _jrl_log("  Properties for target [${target}]:")

    foreach(prop IN LISTS properties_to_print)
        get_property(is_property_set TARGET ${target} PROPERTY "${prop}" SET)

        if(is_property_set)
            get_property(property TARGET ${target} PROPERTY "${prop}")

            # Convert paths containing \ to / (Windows)
            if(WIN32)
                cmake_path(CONVERT "${property}" TO_CMAKE_PATH_LIST property NORMALIZE)
            endif()

            _jrl_pad_string("${prop}"      40 prop_padded)
            _jrl_log("    ${prop_padded} = ${property}")
        endif()
    endforeach()
    _jrl_log("")
endforeach()
_jrl_log_get(log_msg)
message(STATUS "${log_msg}")

install(TARGETS main
        RUNTIME DESTINATION bin)
