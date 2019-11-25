add_custom_command( TARGET EosioClang POST_BUILD COMMAND mkdir -p ${CMAKE_BINARY_DIR}/bin )
macro( eosio_clang_install file )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/eosio_llvm/bin)
   add_custom_command( TARGET EosioClang POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endmacro( eosio_clang_install )

macro( eosio_clang_install_and_symlink file symlink )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/eosio_llvm/bin)
   add_custom_command( TARGET EosioClang POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   add_custom_command( TARGET EosioClang POST_BUILD COMMAND cd ${CMAKE_BINARY_DIR}/bin && ln -sf ${file} ${symlink} )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin)")
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CDT_INSTALL_PREFIX}/bin/${file} ${CMAKE_INSTALL_PREFIX}/bin/${symlink})")
endmacro( eosio_clang_install_and_symlink )

macro( eosio_tool_install file )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/tools/bin)
   add_custom_command( TARGET EosioTools POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
endmacro( eosio_tool_install )

macro( eosio_tool_install_and_symlink file symlink )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/tools/bin)
   add_custom_command( TARGET EosioTools POST_BUILD COMMAND ${CMAKE_COMMAND} -E copy ${BINARY_DIR}/${file} ${CMAKE_BINARY_DIR}/bin/ )
   install(FILES ${BINARY_DIR}/${file}
      DESTINATION ${CDT_INSTALL_PREFIX}/bin
      PERMISSIONS OWNER_READ OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/bin)")
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CDT_INSTALL_PREFIX}/bin/${file} ${CMAKE_INSTALL_PREFIX}/bin/${symlink})")
endmacro( eosio_tool_install_and_symlink )

macro( eosio_cmake_install_and_symlink file symlink )
   set(BINARY_DIR ${CMAKE_BINARY_DIR}/modules)
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_INSTALL_PREFIX}/lib/cmake/eosio.cdt)")
   install(CODE "execute_process( COMMAND ${CMAKE_COMMAND} -E create_symlink ${CDT_INSTALL_PREFIX}/lib/cmake/eosio.cdt/${file} ${CMAKE_INSTALL_PREFIX}/lib/cmake/eosio.cdt/${symlink})")
endmacro( eosio_cmake_install_and_symlink )

macro( eosio_libraries_install)
   execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/lib)
   execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/include)
   install(DIRECTORY ${CMAKE_BINARY_DIR}/lib/ DESTINATION ${CDT_INSTALL_PREFIX}/lib)
   install(DIRECTORY ${CMAKE_BINARY_DIR}/include/ DESTINATION ${CDT_INSTALL_PREFIX}/include)
endmacro( eosio_libraries_install )

eosio_clang_install_and_symlink(llvm-ranlib codex-ranlib)
eosio_clang_install_and_symlink(llvm-ar codex-ar)
eosio_clang_install_and_symlink(llvm-nm codex-nm)
eosio_clang_install_and_symlink(llvm-objcopy codex-objcopy)
eosio_clang_install_and_symlink(llvm-objdump codex-objdump)
eosio_clang_install_and_symlink(llvm-readobj codex-readobj)
eosio_clang_install_and_symlink(llvm-readelf codex-readelf)
eosio_clang_install_and_symlink(llvm-strip codex-strip)

eosio_clang_install(opt)
eosio_clang_install(llc)
eosio_clang_install(lld)
eosio_clang_install(ld.lld)
eosio_clang_install(ld64.lld)
eosio_clang_install(clang-7)
eosio_clang_install(wasm-ld)

eosio_tool_install_and_symlink(codex-pp codex-pp)
eosio_tool_install_and_symlink(codex-wast2wasm codex-wast2wasm)
eosio_tool_install_and_symlink(codex-wasm2wast codex-wasm2wast)
eosio_tool_install_and_symlink(codex-cc codex-cc)
eosio_tool_install_and_symlink(codex-cpp codex-cpp)
eosio_tool_install_and_symlink(codex-ld codex-ld)
eosio_tool_install_and_symlink(codex-abigen codex-abigen)
eosio_tool_install_and_symlink(codex-abidiff codex-abidiff)
eosio_tool_install_and_symlink(codex-init codex-init)

eosio_clang_install(../lib/LLVMEosioApply${CMAKE_SHARED_LIBRARY_SUFFIX})
eosio_clang_install(../lib/LLVMEosioSoftfloat${CMAKE_SHARED_LIBRARY_SUFFIX})
eosio_clang_install(../lib/eosio_plugin${CMAKE_SHARED_LIBRARY_SUFFIX})

eosio_cmake_install_and_symlink(eosio.cdt-config.cmake eosio.cdt-config.cmake)
eosio_cmake_install_and_symlink(EosioWasmToolchain.cmake EosioWasmToolchain.cmake)
eosio_cmake_install_and_symlink(EosioCDTMacros.cmake EosioCDTMacros.cmake)

eosio_libraries_install()
