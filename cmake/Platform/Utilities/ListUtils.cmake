#=============================================================================#
# Replaces an element at the given index with another element in the given list.
#       _list - List to replace one its' elements.
#       _index - Index of the element to replace.
#                Must not be negative or greater than 'list_length'-1.
#=============================================================================#
macro(list_replace _list _index _new_element)
    list(REMOVE_AT ${_list} ${_index})
    list(INSERT ${_list} ${_index} "${_new_element}")
endmacro()
