@tool

extends Node
class_name Check

## Check if the given path exists.
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given path is a string and exists in the file system, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## path: any - Path to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func pathExists(path, throwIfNot: bool = true) -> bool:
	var A = isString(path, throwIfNot)
	var B = __check(FileAccess.file_exists(path), str("Given path (", path, ") doesn't exists."), throwIfNot)
	return A and B



## Check if the given value is a string.
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given value is a string, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## value: any - Value to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func isString(value, throwIfNot: bool = true) -> bool:
	return __check(typeof(value) == TYPE_STRING, "Value must be a string.", throwIfNot)
	
	
	
## Check if the given value is an integer.
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given value is a integer, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## value: any - Value to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func isInt(value, throwIfNot: bool = true) -> bool:
	return __check(typeof(value) == TYPE_INT, "Value must be an integer.", throwIfNot)



## Check if the given value is a float.
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given value is a integer, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## value: any - Value to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func isFloat(value, throwIfNot: bool = true) -> bool:
	return __check(typeof(value) == TYPE_FLOAT, "Value must be an integer.", throwIfNot)



## Check if the given value is a number (float or integer).
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given value is a number, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## value: any - Value to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func isNumber(value, throwIfNot: bool = true) -> bool:
	return isFloat(value, throwIfNot) or isInt(value, throwIfNot)


## Check if the given value is an boolean.
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given value is a boolean, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## value: any - Value to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func isBoolean(value, throwIfNot: bool = true) -> bool:
	return __check(typeof(value) == TYPE_BOOL, "Value must be a boolean.", throwIfNot)



## Check if the given value is a positive number (float or integer).
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given value is a number, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## value: any - Value to check.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func isPositiveNumber(value, throwIfNot: bool = true) -> bool:
	return __check(isNumber(value) && value > 0, "Value must be a positive number.", throwIfNot)
	
	

## Check if the given path finishs with the given extension.
## Returns bool
## STATIC - PUBLIC
##
## Returns 'true' if the given path finishs with the given extension, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## path: String - Path to check its extension.
## extension: String - Extension to expect.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func fileExtension(path: String, extension: String, throwIfNot: bool = true) -> bool:
	var A = pathExists(path, throwIfNot)
	var B = __check(path.ends_with(str(".", extension)), str("Given path (", path, ") is not ending with extension '", extension, "'."), throwIfNot)
	return A and B



## Check the given condition.
## Returns bool
## STATIC - PRIVATE
##
## Returns 'true' if the given test successed, 'false' otherwise.
## Throws an error if the check fails and if 'throwIfNot' is true.
##
## condition: bool - Condition to validate.
## message: String (default: "") - Message to display if the check fails.
## throwIfNot: bool (default: true) - Throws an error if the check fails.
static func __check(condition: bool, errorMessage: String = "", throwIfNot: bool = true) -> bool:
	if not condition:
		if throwIfNot:
			push_error(errorMessage)
		return false
	return true
