configure_file(${CMAKE_CURRENT_SOURCE_DIR}/eosio-abigen.cpp.in ${CMAKE_BINARY_DIR}/forceio-abigen.cpp)

add_tool(forceio-abigen)
