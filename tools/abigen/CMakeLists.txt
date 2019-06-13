configure_file(${CMAKE_CURRENT_SOURCE_DIR}/eosio-abigen.cpp.in ${CMAKE_BINARY_DIR}/codex-abigen.cpp)

add_tool(codex-abigen)
