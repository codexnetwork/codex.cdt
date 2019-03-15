configure_file(${CMAKE_CURRENT_SOURCE_DIR}/eosio-cc.cpp.in ${CMAKE_BINARY_DIR}/forceio-cc.cpp)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/eosio-cpp.cpp.in ${CMAKE_BINARY_DIR}/forceio-cpp.cpp)

add_tool(forceio-cc)
add_tool(forceio-cpp)
