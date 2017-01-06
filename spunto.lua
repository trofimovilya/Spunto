-- Spunto - Hammerspoon plugin, poor man's Punto Switcher replacement
-- Copyright © 2017 Ilya Trofimov
--
-- Permission is hereby granted, free of charge, to any person obtaining
-- a copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
-- DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
-- TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
-- OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


-- Settings -------------------------------------------------------------------

DICT_PATH = "spunto/en-ru.txt"
SWITCH_LAYOUT_AFTER = true

-- Code -----------------------------------------------------------------------

function initDict(filename)
  local file, err = io.open(filename)

  if err then
    hs.notify.new({
      title = "Spunto",
      informativeText = "Dictionary file can not be found."
    }):send()

    return
  end

  local dict = {{}, {}}

  while true do
    local line = file:read()

    if line == nil then break end

    local pair = {}

    for _, c in utf8.codes(line) do
      table.insert(pair, utf8.char(c))
    end

    dict[1][pair[1]] = pair[2]
    dict[2][pair[2]] = pair[1]
  end

  file:close()

  return dict
end

function replace(original)
  if dictionary == null then
    hs.notify.new({
      title = "Spunto",
      informativeText = "Dictionary is not loaded."
    }):send()

    return
  end

  local modified = ""

  for _, code in utf8.codes(original) do
    local c = utf8.char(code)
    local replaced = false

    for _, d in pairs(dictionary) do
      if d[c] ~= nil then
        modified = modified .. d[c]
        replaced = true
        break
      end
    end

    if not replaced then
      modified = modified .. c
    end
  end

  return modified
end

function switchLayout()
  local layouts = hs.keycodes.layouts()

  if not SWITCH_LAYOUT_AFTER or #layouts ~= 2 then
    return
  end

  local currentLayout = hs.keycodes.currentLayout()

  for _, l in pairs(layouts) do
    if l ~= currentLayout then
      hs.keycodes.setLayout(l)
      return
    end
  end
end

function changeSelectedText()
  local element = hs.uielement.focusedElement()
  if element ~= nil then
    local selectedText = element:selectedText()
    if selectedText ~= nil and selectedText ~= "" then
      local modifiedText = replace(selectedText)
      if modifiedText ~= nil and modifiedText ~= "" then
        hs.eventtap.keyStrokes(modifiedText)
        switchLayout()
        return true
      end
    end
  end

  return false
end

function changeSelectedTextOrLastWord()
  if not changeSelectedText() then
    hs.eventtap.keyStroke({"shift", "alt"}, "left")
    changeSelectedText()
  end
end

function changeWholeLineToTheLeftOfCursor()
  hs.eventtap.keyStroke({"shift", "cmd"}, "left")
  changeSelectedText()
end

dictionary = initDict(DICT_PATH)

-- Binds ----------------------------------------------------------------------

hs.hotkey.bind({}, "f3", changeSelectedTextOrLastWord)
hs.hotkey.bind({"cmd"}, "f3", changeWholeLineToTheLeftOfCursor)
