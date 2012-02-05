"
" Author: Zac McCormick
" https://github.com/zhm/macvimhax
" https://github.com/brentd/vimfiles
"

call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

set nocompatible
syntax enable

filetype on
filetype plugin on
filetype plugin indent on

set backup                         " enable backup just because I can, SSD FTW
set directory=~/.vimtmp            " don't litter my drive with .swp files
set backupdir=~/.vimbackup         " put backup files in .vim directory
set showcmd                        " show current command in status bar
set showmatch                      " show matching braces
set ruler                          " always show the line info
set hlsearch                       " highlight search results
set incsearch                      " search as the expression is being typed
set relativenumber                 " show line numbers
set noerrorbells                   " beeps = no
set visualbell                     " visual bellz 
set tabstop=2                      " 1 tab = 2 spaces
set shiftwidth=2                   " indenting
set autoindent                     " it does what it says
set smartindent                    " it also does what it says, only smarter
set noequalalways                  " all windows are not created equal
set winminwidth=0                  " let me make windows resize down to 0
set shell=/bin/zsh                 " zsh, yo
set guioptions+=LlRrb              " minimal
set guioptions-=LlRrb              " YAGNI
set guioptions-=T                  " hide toolbar
set background=dark                " dark ftw
set lines=999                      " make it big
set laststatus=2                   " always show the status window
set linespace=0                    " set linespace to 0 so it looks pleasing
set guifont=Inconsolata\ XL:h13    " http://www.bitcetera.com/en/techblog/2009/10/09/inconsolata-xl-font/
set antialias                      " pretty text
set expandtab                      " convert tabs to spaces
set cursorline                     " highlight the current line

if has("gui_running")
	set fuoptions=maxvert,maxhorz  " full screen is FULL SCREEN
	"set relativenumber            " relative line numberz
	set transparency=3             " subtle transparency
endif

"create temp/backup directories if they don't exist
silent execute '!mkdir -p ~/.vim/backup'
silent execute '!mkdir -p ~/.vim/tmp'

colorscheme ir_black

"ir_black tweaks, mostly makes NERDTree look prettier
hi directory term=bold gui=bold guifg=#fcfcfc guibg=#111111
hi normal guifg=#e7e3cb guibg=#111111

nmap , \

nmap <leader>w :w!<cr>
nmap <leader>. :tabnext<cr>
nmap <leader>/ :tabnext<cr>

" \d will hide/show the tree
" \b expands to :NERDTreeFromBookmark and then you can autocomplete the name of a bookmark
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>b :NERDTreeFromBookmark

let NERDTreeIgnore=['\.pyc$', '\~$']  "ignore pyc files and anything ending with a ~
let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeDirArrows=1    " ASCII art doesn't work for me
let NERDTreeMinimalUI=1    " YAGNI

" window navigation shortcuts, ctrl h j k l
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" window resizing shortcuts, ctrl u i o p
nnoremap <c-u> <c-w><
nnoremap <c-p> <c-w>>
nnoremap <c-i> <c-w>+
nnoremap <c-o> <c-w>-

" git helpers
nnoremap <leader>gc :Gcommit<cr>
nnoremap <leader>gs :Gstatus<cr>


" shift-enter to exit from insert mode
inoremap <S-CR> <Esc>l

" % hurts my fingers to type
" nnoremap <tab> %
vnoremap <tab> %

" quicker command mode
nnoremap ; :


"javascript files
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.geojson set filetype=javascript
autocmd BufNewFile,BufRead *.ejs set filetype=html.javascript

autocmd BufNewFile,BufRead *.aliases set filetype=sh
autocmd BufNewFile,BufRead *.functions set filetype=sh

autocmd VimEnter * hi NERDTreeDir guifg=#eeeeee gui=bold
autocmd VimEnter * hi NERDTreeDirSlash guifg=#eeeeee
autocmd VimEnter * hi NERDTreeExecFile gui=none


" vim-gist setup
let g:gist_detect_filetype = 1       " auto detect file type from file name
let g:gist_clip_command = 'pbcopy'   " copy link to clipboard after it's posted


" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif


command Xmake :! find `pwd` -iname "*.xcodeproj" -exec xcodebuild -project "{}" $@ \;


" Command-T
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowReverse=1


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
