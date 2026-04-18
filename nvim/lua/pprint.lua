local M = {}

M.Colors = {
  FgBlack = 30,
  FgRed = 31,
  FgGreen = 32,
  FgYellow = 33,
  FgBlue = 34,
  FgMagenta = 35,
  FgCyan = 36,
  FgWhite = 37,

  FgBrightBlack = 90,
  FgBrightRed = 91,
  FgBrightGreen = 92,
  FgBrightYellow = 93,
  FgBrightBlue = 94,
  FgBrightMagenta = 95,
  FgBrightCyan = 96,
  FgBrightWhite = 97,

  BgBlack = 40,
  BgRed = 41,
  BgGreen = 42,
  BgYellow = 43,
  BgBlue = 44,
  BgMagenta = 45,
  BgCyan = 46,
  BgWhite = 47,

  BgBrightBlack = 100,
  BgBrightRed = 101,
  BgBrightGreen = 102,
  BgBrightYellow = 103,
  BgBrightBlue = 104,
  BgBrightMagenta = 105,
  BgBrightCyan = 106,
  BgBrightWhite = 107,
}

---@param value any value to colorize
---@param ... number|string ANSI color codes to use
---@return string wrappedString the result string
function M.color(value, ...)
  local numArgs = select("#", ...)

  local code_str = ""
  for i = 1, numArgs do
    code_str = code_str .. select(i, ...) .. ";"
  end
  code_str = string.sub(code_str, 1, -2)
  return string.format("\027[%sm%s\027[0m", code_str, tostring(value))
end

---@param ... any `pprint` pretty-prints values and colors them according to the their type. Takes between 1 and 3
---arguments. If three arguments are provided, they are assumed to be a message, a value, and an indent level. The
---message should be a string, and the value can be any value. The default indent level is 0 and the indent size is
---4 spaces. If two arguments are provided (the most common case), they are assumed to be the message, and the value.
---If only one argument is provided, it is assumed to be the value.
function M.ctable(...)
  local numArgs = select("#", ...)
  local message = ""
  local value = nil
  local indent = 0

  if numArgs == 1 then
    value = select(1, ...)
  elseif numArgs == 2 then
    message = select(1, ...)
    value = select(2, ...)
  elseif numArgs == 3 then
    message = select(1, ...)
    value = select(2, ...)
    indent = select(3, ...)
  else
    print(
      M.color("ERROR", M.Colors.BgRed) .. " " ..
      M.color("print.ctable::must have 1 to 3 arguments", M.Colors.FgRed))
    return
  end

  local indent_str = string.rep("    ", indent)

  if indent > 0 then
    message = M.color(message, M.Colors.FgCyan) .. ": "
  elseif #message > 0 then
    message = message .. " "
  end

  local prepend = indent_str .. message
  if type(value) == "function" then
    print(prepend .. M.color("function value", M.Colors.FgBlue))
  elseif type(value) == "table" then
    print(prepend)
    for key, val in pairs(value) do
      M.ctable(key, val, indent + 1)
    end
  elseif type(value) == "string" then
    local w = indent > 0 and "\"" or ""
    print(prepend .. M.color(w .. value .. w, M.Colors.FgGreen))
  elseif type(value) == "nil" then
    print(prepend .. M.color(value, M.Colors.FgRed))
  else
    print(prepend .. M.color(value, M.Colors.FgMagenta))
  end
end

function M.table(...)
  local numArgs = select("#", ...)
  local message = ""
  local value = nil
  local indent = 0

  if numArgs == 1 then
    value = select(1, ...)
  elseif numArgs == 2 then
    message = select(1, ...)
    value = select(2, ...)
  elseif numArgs == 3 then
    message = select(1, ...)
    value = select(2, ...)
    indent = select(3, ...)
  else
    print(
      "ERROR" .. " " ..
      "print.table::must have 1 to 3 arguments")
    return
  end

  local indent_str = string.rep("    ", indent)

  if indent > 0 then
    message = message .. ": "
  elseif #message > 0 then
    message = message .. " "
  end

  local prepend = indent_str .. message
  if type(value) == "function" then
    print(prepend .. "function value")
  elseif type(value) == "table" then
    print(prepend)
    for key, val in pairs(value) do
      M.table(key, val, indent + 1)
    end
  elseif type(value) == "string" then
    local w = indent > 0 and "\"" or ""
    print(prepend .. w .. value .. w)
  elseif type(value) == "nil" then
    print(prepend .. value)
  else
    print(prepend .. value)
  end
end
return M
