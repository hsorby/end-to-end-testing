
macro(read_test_db _DIR)
    if(IS_DIRECTORY "${_DIR}")
        read_test_db_dir("${_DIR}")
    else()
        read_test_db_file("${_DIR}")
    endif()
endmacro()

macro(read_test_db_dir _DIR)
    # Read database of tests.
    file(GLOB test_files LIST_DIRECTORIES FALSE ${_DIR}/*.cmake)

    set(TEST_COUNT 0)
    foreach(test_file ${test_files})
        math(EXPR TEST_COUNT "${TEST_COUNT}+1")
        get_filename_component(test_file "${test_file}" NAME)
        add_functional_test(${_DIR}/${test_file})
    endforeach()
endmacro()

macro(read_test_db_file _FILE)
    set(TEST_COUNT 1)
    add_functional_test(${_FILE})
endmacro()

macro(add_functional_test TEST_DESCRIPTION_FILE)
    unset_test_variables()
    include(${TEST_DESCRIPTION_FILE})
    get_filename_component(TEST_NAME "${TEST_DESCRIPTION_FILE}" NAME_WE)
    set(TEST_${TEST_COUNT}_NAME ${TEST_NAME})
    set(TEST_${TEST_COUNT}_GIT_REPO ${TEST_GIT_REPO})
    set(TEST_${TEST_COUNT}_COMMIT_HASH ${TEST_COMMIT_HASH})

    foreach(_prefix TEST_) # PYTEST_
        set(${_prefix}${TEST_COUNT}_TARGETS ${${_prefix}TARGETS})
        set(${_prefix}${TEST_COUNT}_TARGETS_ARGS ${${_prefix}TARGETS_ARGS})
        set(${_prefix}${TEST_COUNT}_CMAKELISTS_DIR ${${_prefix}CMAKELISTS_DIR})
        set(${_prefix}${TEST_COUNT}_EXPECTED_RESULTS ${${_prefix}EXPECTED_RESULTS})
	if (DEFINED ${_prefix}TARGETS_ENV)
	    string(REPLACE "|" ";" _env_list ${${_prefix}TARGETS_ENV})
            set(${_prefix}${TEST_COUNT}_TARGETS_ENV ${_env_list})
	 else()
	    set(${_prefix}${TEST_COUNT}_TARGETS_ENV "NOENV=")
        endif ()
    endforeach()
endmacro()

macro(unset_test_variables)
    unset(TEST_NAME)
    unset(TEST_GIT_REPO)
    unset(TEST_COMMIT_HASH)

    foreach(_prefix TEST_) # PYTEST_
        unset(${_prefix}TARGETS)
        unset(${_prefix}TARGETS_ARGS)
        unset(${_prefix}CMAKELISTS_DIR)
        unset(${_prefix}EXPECTED_RESULTS)
        unset(${_prefix}TARGETS_ENV)
    endforeach()

endmacro()

