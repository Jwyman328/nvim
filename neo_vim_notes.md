
### prime explanations on some vid about neovim
  by default kick start comes with treesitter  

  Use core utils in vim because always in terminal
  - Strip out logs, process logs, strip out values. Grep replace.

  Prime recommends kickstart over lunar vim for starting vim setup
  - Prime would add fugitive, undo tree, telescope, harpoon. And an lsp.

  Getting closer to how your environment works will only expand your mind.

  Customize it to how your think

  You can do $vim.api.
  $vim.api.nvim_create_buf


  Harpoon allows you to do jump lists to jump easily between different files.

  vimtutor helps you learn vim.

 ### youtube video 
 - https://www.youtube.com/watch?v=87AXw9Quy9U&ab_channel=Vhyrro
 - have neovim installed 
 - what is the command to start neovim?
   - $nvim
- how to see which version of veovim?
    - $nvim -v
- neovim at its core is something that edits text, and your hwole keyboard turns into a macro array and then you can run those macros on the text. 
- thanks to lua it is extendable and scriptable.
- the help command is important in neovim, you can see information about anything that is in neovim. it is all in the help pages.
    - :help <something> 
- lua is a simple programming language, it has little keywords and concept of tables makes thngs extensible.
- what is init.lua file?
  - it is the entry point that neovim will look for and try to launch it.
  - it should be in some /config folder based on your operating system.
- how do we ask neovim where it is looking for our init.lua file?
    - there are a distinction between functions from lua and vimscript form vim itself. vimscript is supported in neovim, it is slower and uglier so we tend to use lua instead 
    - thereis no native lua function to ask neovim about the config path.    
- we can always type tab to see all the posibilities of our entered command for example
  - :help st (then hit tab) it will show us all the possible "st" help commands we could envoke.
- :help :stdpath 
  -this will tell us which paths we can search for with the stdpath function. 
- :echo
  - this will print out the value of a vimscript function

# Why I use vim
https://www.youtube.com/watch?v=o4X8GU7CCSU&list=PLnu5gT9QrFg36OehOdECFvxFFeMHhb_07
https://www.josean.com/posts/terminal-setup
### how do we save an item in neovim?
  - :w
### How do we save and quit at the same time in neovim?
  - :wq

Cheatsheet for vim
- https://devhints.io/vim 

### What is the formula for vim commands?
- first operator
   - y, c, d, 
- second motion
  - fw, w, e, $   


### What does pressing an operator twice do?
- it will do that command for the entire row

### What does c mean?
- it means change, it will delete and then enter into interactive mode.

### How do you duplicate an operation?
- .

### How do you undo something?
- u

### Hows do you redo something?
- control r

### How do I search for something in the file?
- /something (then press enter)
- then use the n and N to go back and forth between the items

### Making the mac terminal better
- https://www.youtube.com/watch?v=CF1tMjvHDRA&list=PLnu5gT9QrFg36OehOdECFvxFFeMHhb_07&index=2
- use iterm2 instead of default terminal from mac
# What is iterm2?
- https://iterm2.com/
  - it is a replacement for Terminal in mac
  - it is open source free software.
  - has additional functionality than regular terminal
  - has built in splitting of and duplicating of windows in the terminal

# What is oh my zshell?
- gives you access to powerful plugins and themes in zsh.
- https://ohmyz.sh/
- it is used to configure terminal(zsh), make it look nice and install some plugins 
- we alter the ~/.zshrc file to add our customizations to it, like adding the plugins we want 
- it helps us with better autocomplete, syntax highlighting in our zsh terminal
- lets us pick a theme and apply it easily.
- gives us things that are preconfigured I think? and then we can alter them as needed.

# How do we accept a suggested autocomplete in the terminal?
- to apply a suggestion we can hit the right arrow. 

# How do I write and quit a file in neovim?
- :wq

# How do I enter into the terminal in neovim?
- :terminal

# How do I switch between terminal mode and non terminal mode?
- press esc to leave terminal mode, press i to enter into  
- this was not natural though I had to run a command to set up that short cut 
  - :tnoremap <Esc> <C-\><C-n>
   - per https://vi.stackexchange.com/questions/4919/exit-from-terminal-mode-in-neovim-vim-8
   - huh I guess i have to do that in each terminal?
     - how do I get that in my init.lua so I don't always ahve to do that 
        - I figured it out with   
         - vim.api.nvim_set_keymap('t', '<Leader><ESC>', '<C-\\><C-n>', { noremap = true })
         - so I just do leader ESC and it should bring me out of the locked in terminal mode but it looks like I need to do ESC leader ESC I guess




# Learning a little bit of lua before I continue
- https://learnxinyminutes.com/docs/lua/
- two dashes start a one line comment
```lua
-- this is a comment

--[[
  a multiline comment
  another line here
]]
```

1. variables and flow control

```lua
num = 42
s = 'walernate' -- string are immutable like Python
t = "double quptes are also fine"
u = [[
multi line string in double brackets
]]
t = nil -- Undefines t;  Lua has garbage collection

-- Blocks are denoted with keywords like do/end;
while num < 50 do
  num = num + 1
end

-- if Clauses
if num > 40 then 
  print("over 40")
elseif S ~= 'walernate' then
-- ~= is not equals to 
  io.write("not over 40/n")
else
  thisIsGlobal = 5; -- by default variables are global

  local line = io.read() -- you can set variables as local with local keyword

  print("printer is coming, " .. line)
end


undefinedVariable = anUnknownVariable -- now this will be nil

aBoolValue = false 

-- only nil and false are falsy; 0 and '' are true.

-- 'or' and 'and' are short circuited
-- This is similar to the a?b:c operator in C/js
ans = aBoolValue and 'yes' or 'no' --> return 'no'

for i = 1, 100, 100 do -- The range includes both ends.
  karlSum = karlSum + i 
end

-- In general, the range is begin, end[, step].

-- Another loop contruct:
repeat
  print('the way of the future')
  num = num - 1
until num == 0


--------
--- 2. Functions.
--------

function fib(n)
  if n < then return 1 end
  return fib(n-2) + fib(n-2)
end

----------
----3. Tables.
-----------
--[[
Tables = Lua's only compound data structure; 
they are associative arrays.
Similar to php arrays or js objects, they are hash-lookup dicts 
that can also be used as lists.

Using tables as dictionaries / maps:
]]--

t = {key1='value1', key2 = false}
-- string keys can use js like dot notation
print(t.key1)
t.newKey = {}
t.key2 = nil

-- using tables as lists / arrays.

-- List literals implicitly set up int keys:
v = {'value1', 'value2', 1.21, 'gigawatts'}
for i = 1, #v do -- #v is the size of v for lists.
  print(v[1]) -- indices start at 1!! so insane.
end

-- a list is not a real type. v is just a table
-- with consecutive integer keys, treated as a list.


----------
----3.1 Metatables and meta methods.
----------

--- a table can have a metatable that gives the table 
--- operator overloadish behavior. Later wel'' see 
--- how metatables 'support js-prototype behavior.

f1 = {a = 1, b = 2}  -- Represents the fraction a/b.
f2 = {a = 2, b = 3}

-- This would fail:
-- s = f1 + f2

metafraction = {}
function metafraction.__add(f1, f2)
  sum = {}
  sum.b = f1.b * f2.b
  sum.a = f1.a * f2.b + f2.a * f1.b
  return sum
end

setmetatable(f1, metafraction)
setmetatable(f2, metafraction)


----------------------------------------------------
-- 3.2 Class-like tables and inheritance.
----------------------------------------------------

-- Classes aren't built in; there are different ways
-- to make them using tables and metatables.

-- Explanation for this example is below it.

Dog = {}                                   -- 1.

function Dog:new()                         -- 2.
  newObj = {sound = 'woof'}                -- 3.
  self.__index = self                      -- 4.
  return setmetatable(newObj, self)        -- 5.
end

function Dog:makeSound()                   -- 6.
  print('I say ' .. self.sound)
end

mrDog = Dog:new()                          -- 7.
mrDog:makeSound()  -- 'I say woof'         -- 8.
```

### How do you import files in lua
```lua
-- main.lua

-- Import the module
local myModule = require("module")

-- Access the variables and functions from the module
print(myModule.variable)
myModule.printMessage()
```

### Walking through kickstart init.lua file in neovim
- what is the leader in kickstart set to ?
  - it is set to the space
- what is the prefix for window based commands in vim?
  - ctr w
- so how would I quit out of say a top window that pops up after a :help command
  - ctr w q

- What is a leader in neovim?
  - it is a key used before custom key bindings   
  - using the leader helps you avoid clashes with the built in vim bindings

- lazyvim is our plugin manager.
- telescope is out fuzzy finder.
- treesitter is for highliht, edit and navigate code.


### TJ setup kickstart video https://www.youtube.com/watch?v=stqUbv-5u2s
- he says start with vimtutor 

#### vimtutor
##### how do I quit and not save anything in vim?
- :q!

##### Command number motion
- d2w
  - delete two words

##### p command where will it put the text?
- after the cursor
-

##### Replacing characters
- use the r then the correct character to overwrite a character

##### Finding a closing (, [, {
- use % to find a closing tag

```js
function gun(){
   console.log("shoot")
}

```
- very useful for debugging when you are missing a ) or ] or }

#### Moving forward or backwards for arbitrary set of characters
- use W to move forward 
- use B to move backwards
- use E to move end of section
- for example if I wanted to move forwards or backwards on this set of characters
  - :s/old/new other word

#### Substituting aka find and replace
- to find and replace a single work in a line 
  -  :s/old/new
- to find and replace all encounters of a word in a line
  - :s/old/new/g
- to replace all occurances of something in a file
  - :%s/old/new/g
- to find all but replace one at a time in a file
  - :%s/old/new/gc


##### Execute external shell command
- :! then type some shell command


#### How to enter replace mode for a serious of characters
- R
  - this will put you in replace mode until you hit escape

# Back to tj video
- https://www.youtube.com/watch?v=stqUbv-5u2s
- how do I search for files?
  - space sf



#### How do we update our language servers?
- to start I went into a typescipt file and didn't have any of the autocomplete installed, to add the typescript LSP I needed to type in 
:Mason 
(then press enter)
this opened up something inside of neovim and I would scroll down to the lsp or linter or formatter that I wanted to install and would press i.
- that would then install it.

#### My typscript language server is not working, how do I get more info on it?
- inside of a typescript file type the neovim command
- :LspInfo

#### so what was the issue with the ts server and how did I fix it?
- the issue was the node version.
- the way I fixed it was by installing nvm on my system and then installing node version 20, instead of the outdated version12.
- then in my terminal I did $ nvm use default
 - the default version I set to 20
- I also had to setup where nvm was in my ~/.zprofile
- https://stackoverflow.com/questions/58280757/how-to-upgrade-node-to-specific-version-in-macos-mojave-and-update-the-active-p
- https://stackoverflow.com/questions/47190861/how-can-the-default-node-version-be-set-using-nvm


## now going back to tjs tutorial
- telescope is used for all the fuzzyfinding like leader s f file searching

#### How can we findout more about our various vim. commands in our lua.init file?
- for example if we want to know more about vim.o.hlsearch
- :Telescope help_tags

#### What is the .setup on each  plugin?
- the .setup { allows you to provide customization to each plugin.

#### telescope in the init.lua
- we use vim.keymap.set to set new keymaps
  - vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    - the first paramter is the mode, 'n' means normal mode
    - the second parameter is the telescope function we are going to call 
    - third is the desciption we are giving it when someone looks to see what it is and why we called it this keymap.

#### What are some of our telescope searching commands
- space / will fuzzy search  inside of a file?
- space ? shows recently opened files
- space space shows currently open buffers


#### What about treesitter?
- used for highlighting
- also additional going to previous function, next function etc.

#### How we configure our lsp
- also implements all our gd, gr, leaderD, lsp keybindings.
- idk why telescope is involved with this.


#### How do I see the recently visited files?
- leader space 

#### How do I see all recently opened files
- leader ?

##### How do I run the formatter?
- leader f
- I created my own keymap for this in lua.init with
  - nmap('<leader>f',vim.lsp.buf.format, 'Format file')


#### Setting up a file tree 
- https://github.com/nvim-neo-tree/neo-tree.nvim
- I ran :Neotree to open it 
- how do I switch between vim windows?
  - https://superuser.com/questions/280500/how-does-one-switch-between-windows-on-vim
  -  control W W
  - or control W then h and l to move left and right
  - in the file path window you can do f to search


#### Setting up git viewer integration
https://github.com/sindrets/diffview.nvim
- I don't have keymaps set up but to open the diff viewer do 
  - :DiffviewOpen
- To close it do
  -  : DiffviewClose



#### How to add a new file in Neotree window?
- a key will do it and then prompts you to enter in a new name


#### Search Grep was not working here is how I fixed it
- https://www.youtube.com/watch?v=6ivxInASPdM
