function(write_test _file _name _target _root _expected_results)
    write_target_test(
        ${_file}
        ${_name}
        ${_target}
        ${_root}
        "${_expected_results}"
        ${ARGN}
    )
endfunction()

