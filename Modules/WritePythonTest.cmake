function(write_test)
    write_python_test(${SETUP_CMAKELISTS_FILE} ${_current_name}
        ${_current_target} ${_current_root} "${_current_expected_results}"
        ${_current_env} ${_current_args})
endfunction()
