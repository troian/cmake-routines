# Get the current working branch
execute_process(
	COMMAND git rev-parse --abbrev-ref HEAD
	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
	OUTPUT_VARIABLE GIT_BRANCH
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Get the latest abbreviated commit hash of the working branch
execute_process(
	COMMAND
	git log -1 --format=%h
	WORKING_DIRECTORY
	${CMAKE_SOURCE_DIR}
	OUTPUT_VARIABLE
	GIT_COMMIT_HASH
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
	COMMAND
	git rev-list --tags --max-count=1
	WORKING_DIRECTORY
	${CMAKE_SOURCE_DIR}
	OUTPUT_VARIABLE
	GIT_REV_LIST
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
	COMMAND
	git describe --tags
	WORKING_DIRECTORY
	${CMAKE_SOURCE_DIR}
	OUTPUT_VARIABLE
	GIT_VERSION
	OUTPUT_STRIP_TRAILING_WHITESPACE
)

string(REGEX REPLACE "^v([0-9]+)\\..*" "\\1" MAJOR_VERSION "${GIT_VERSION}")
string(REGEX REPLACE "^v[0-9]+\\.([0-9]+).*" "\\1" MINOR_VERSION "${GIT_VERSION}")
string(REGEX REPLACE "^v[0-9]+\\.[0-9]+\\.([0-9]+).*" "\\1" PATCH_VERSION "${GIT_VERSION}")

set(HASH_VERSION ${GIT_COMMIT_HASH})

message("-- Building version: ${MAJOR_VERSION}.${MINOR_VERSION}.${PATCH_VERSION}.${HASH_VERSION}")

add_definitions("-DGIT_COMMIT_HASH=${GIT_COMMIT_HASH}")
add_definitions("-DGIT_BRANCH=${GIT_BRANCH}")
add_definitions("-D__PACKAGE_VERSION__=\"${GIT_VERSION}\"")
