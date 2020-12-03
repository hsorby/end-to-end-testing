# Acquire test using external project

include(ExternalProject)

function(ACQUIRE_TEST _NAME _LOCATION _REPO_URL _COMMIT_HASH)

    ExternalProject_Add(${_NAME}
        SOURCE_DIR ${_LOCATION}
        GIT_REPOSITORY ${_REPO_URL}
        GIT_TAG ${_COMMIT_HASH}
        CONFIGURE_COMMAND ""
        BUILD_COMMAND ""
        INSTALL_COMMAND "")

endfunction()

