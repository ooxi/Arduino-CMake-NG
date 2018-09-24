#=============================================================================#
# Gets a filtered list of architectures that aren't compliant with the platform's architecture.
# e.g If a list contains 'avr' and 'nrf52', while our arch is 'avr', 'nrf52' will be returned.
#       _arch_list - List of all architectures probably read from a library's properties file
#       [REGEX] - Returns list in a regex-compatible mode, allowing caller to
#                 use result in search patterns. This is currently the only supported mode.
#       _return_var - Name of variable in parent-scope holding the return value.
#       Returns - Filtered list of architectures.
#=============================================================================#
function(get_unsupported_architectures _arch_list _return_var)

    cmake_parse_arguments(parsed_args "REGEX" "" "" ${ARGN})

    list(FILTER _arch_list EXCLUDE REGEX ${ARDUINO_CMAKE_PLATFORM_ARCHITECTURE})
    set(unsupported_arch_list ${_arch_list}) # Just for better readability

    if (parsed_args_REGEX) # Return in regex format         

        foreach (arch ${unsupported_arch_list})
            # Append every unsupported-architecture and "|" to represent "or" in regex-fomart
            string(APPEND unsupported_archs_regex "${arch}" "|")
        endforeach ()

        # Remove last "|" as it's unnecessary - There's no element after it
        string(LENGTH unsupported_archs_regex str_len)
        decrement_integer(str_len 1) # Decrement string's length by 1 to trim last char ('|')
        string(SUBSTRING unsupported_archs_regex 0 ${str_len} unsupported_archs_regex)

        # prepare for generalized function return
        set(unsupported_arch_list ${unsupported_archs_regex})

    endif ()

    set(${_return_var} ${unsupported_arch_list} PARENT_SCOPE)

endfunction()
