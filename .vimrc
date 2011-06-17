"
" Author: Zac McCormick
" https://github.com/zhm/macvimhax
"

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible
syntax enable

filetype on
filetype plugin on
filetype plugin indent on

set backup                         " enable backup just because I can, SSD FTW
set directory=~/.vim/tmp           " don't litter my drive with .swp files
set backupdir=~/.vim/backup        " put backup files in .vim directory
set showcmd                        " show current command in status bar
set showmatch                      " show matching braces
set ruler                          " always show the line info
set hlsearch                       " highlight search results
set incsearch                      " search as the expression is being typed
set number                         " show line numbers
set noerrorbells                   " beeps = no
set tabstop=4                      " 1 tab = 4 spaces
set shiftwidth=4                   " indenting
set autoindent                     " it does what it says
set smartindent                    " it also does what it says, only smarter
set noequalalways                  " all windows are not created equal
set winminwidth=0                  " let me make windows resize down to 0
set shell=/bin/bash                " s3tup my sh3ll, bro
set guioptions+=LlRrb              " minimal
set guioptions-=LlRrb              " YAGNI
set guioptions-=T                  " hide toolbar
set background=dark                " dark ftw
set nowrap                         " disable word wrapping
set lines=999                      " make it big
set laststatus=2                   " always show the status window
set linespace=2                    " slightly adjust line spacing so it's prettier
set guifont=Panic\ Sans:h12        " Panic Sans, from Coda (http://www.panic.com/coda/)

if has("gui_running")
    set fuoptions=maxvert,maxhorz  " full screen is FULL SCREEN
	set relativenumber             " relative line numberz
	set transparency=4             " yes, I tried 3 and 5.
endif

"create temp/backup directories if they don't exist
silent execute '!mkdir -p ~/.vim/backup'
silent execute '!mkdir -p ~/.vim/tmp'

colorscheme ir_black

"ir_black tweaks, mostly makes NERDTree look prettier
hi directory term=bold gui=bold guifg=#fcfcfc guibg=#111111
hi normal guifg=#e7e3cb guibg=#111111

" \d will hide/show
" \b will enter :NERDTreeFromBookmark and then
" you can autocomplete the name of a bookmark
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>b :NERDTreeFromBookmark
let NERDTreeIgnore=['\.pyc$', 'CVS', '\~$']
let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeDirArrows=1    " ASCII art doesn't work for me
let NERDTreeMinimalUI=1    " YAGNI

"window navigation shortcuts, ctrl h j k l
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-h> <c-w>h
nmap <c-l> <c-w>l

"window resizing shortcuts, ctrl u i o p
nmap <c-u> <c-w><
nmap <c-p> <c-w>>
nmap <c-i> <c-w>+
nmap <c-o> <c-w>-

"javascript files
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.geojson set filetype=javascript




"
" Everything below is from Janus.
" https://github.com/carlhuda/janus
"
"

" Project Tree
autocmd VimEnter * call s:CdIfDirectory(expand("<amatch>"))
autocmd FocusGained * call s:UpdateNERDTree()
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()

" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

" If the parameter is a directory, cd into it
function s:CdIfDirectory(directory)
  let explicitDirectory = isdirectory(a:directory)
  let directory = explicitDirectory || empty(a:directory)

  if explicitDirectory
    exe "cd " . fnameescape(a:directory)
  endif

  " Allows reading from stdin
  " ex: git diff | mvim -R -
  if strlen(a:directory) == 0 
    return
  endif

  if directory
    NERDTree
    wincmd p
    bd
  endif

  if explicitDirectory
    wincmd p
  endif
endfunction

" NERDTree utility function
function s:UpdateNERDTree(...)
  let stay = 0

  if(exists("a:1"))
    let stay = a:1
  end

  if exists("t:NERDTreeBufName")
    let nr = bufwinnr(t:NERDTreeBufName)
    if nr != -1
      exe nr . "wincmd w"
      exe substitute(mapcheck("R"), "<CR>", "", "")
      if !stay
        wincmd p
      end
    endif
  endif

  if exists(":CommandTFlush") == 2
    CommandTFlush
  endif
endfunction

" Utility functions to create file commands
function s:CommandCabbr(abbreviation, expansion)
  execute 'cabbrev ' . a:abbreviation . ' <c-r>=getcmdpos() == 1 && getcmdtype() == ":" ? "' . a:expansion . '" : "' . a:abbreviation . '"<CR>'
endfunction

function s:FileCommand(name, ...)
  if exists("a:1")
    let funcname = a:1
  else
    let funcname = a:name
  endif

  execute 'command -nargs=1 -complete=file ' . a:name . ' :call ' . funcname . '(<f-args>)'
endfunction

function s:DefineCommand(name, destination)
  call s:FileCommand(a:destination)
  call s:CommandCabbr(a:name, a:destination)
endfunction

" Public NERDTree-aware versions of builtin functions
function ChangeDirectory(dir, ...)
  execute "cd " . fnameescape(a:dir)
  let stay = exists("a:1") ? a:1 : 1

  NERDTree

  if !stay
    wincmd p
  endif
endfunction

function Touch(file)
  execute "!touch " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Remove(file)
  let current_path = expand("%")
  let removed_path = fnamemodify(a:file, ":p")

  if (current_path == removed_path) && (getbufvar("%", "&modified"))
    echo "You are trying to remove the file you are editing. Please close the buffer first."
  else
    execute "!rm " . shellescape(a:file, 1)
  endif

  call s:UpdateNERDTree()
endfunction

function Mkdir(file)
  execute "!mkdir " . shellescape(a:file, 1)
  call s:UpdateNERDTree()
endfunction

function Edit(file)
  if exists("b:NERDTreeRoot")
    wincmd p
  endif

  execute "e " . fnameescape(a:file)

ruby << RUBY
  destination = File.expand_path(VIM.evaluate(%{system("dirname " . shellescape(a:file, 1))}))
  pwd         = File.expand_path(Dir.pwd)
  home        = pwd == File.expand_path("~")

  if home || Regexp.new("^" + Regexp.escape(pwd)) !~ destination
    VIM.command(%{call ChangeDirectory(fnamemodify(a:file, ":h"), 0)})
  end
RUBY
endfunction

" Define the NERDTree-aware aliases
call s:DefineCommand("cd", "ChangeDirectory")
call s:DefineCommand("touch", "Touch")
call s:DefineCommand("rm", "Remove")
call s:DefineCommand("e", "Edit")
call s:DefineCommand("mkdir", "Mkdir")
