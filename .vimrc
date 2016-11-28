"
" Author: Zac McCormick
" https://github.com/zhm/macvimhax
"

" call pathogen#helptags()
" call pathogen#runtime_append_all_bundles()

set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'wincent/Command-T'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-dispatch'
Bundle 'vim-scripts/Gist.vim'
Bundle 'vim-scripts/Conque-Shell'
Bundle 'vim-scripts/OmniCppComplete'
Bundle 'vim-scripts/applescript.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
Bundle 'kchmck/vim-coffee-script'
Bundle 'msanders/cocoa.vim'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'int3/vim-taglist-plus'
Bundle 'vim-ruby/vim-ruby'
Bundle 'lyricallogical/ant.vim'
Bundle 'zhm/a.vim'
Bundle 'godlygeek/tabular'
Bundle 'msanders/snipmate.vim'
Bundle 'digitaltoad/vim-jade'
Bundle 'guileen/vim-node'
Bundle 'kelan/gyp.vim'
Bundle 'zhm/TagHighlight'
Bundle 'Lokaltog/vim-powerline'
Bundle 'vim-scripts/genutils'
Bundle 'vim-scripts/multiselect'
Bundle 'b4winckler/vim-angry'
Bundle 'wavded/vim-stylus'
Bundle 'goldfeld/vim-seek'
Bundle 'jQuery'
Bundle 'gmarik/github-search.vim'
Bundle 'Gundo'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'swaroopch/vim-markdown-preview'
Bundle 'AndrewRadev/switch.vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'mattn/webapi-vim'
Bundle 'mmozuras/vim-github-comment'
Bundle 'junegunn/goyo.vim'
Bundle 'groenewege/vim-less'
Bundle 'leafgarland/typescript-vim'
Bundle 'mtscout6/vim-cjsx'
" Bundle 'bling/vim-airline'
" Bundle 'airblade/vim-gitgutter'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'Lokaltog/powerline'

filetype plugin indent on

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
set guifont=Inconsolata-dz\ for\ Powerline:h13 "https://gist.github.com/1595572
" set guifont=Menlo:h15 "https://gist.github.com/1595572
"set guifont=Inconsolata\ XL:h13    " http://www.bitcetera.com/en/techblog/2009/10/09/inconsolata-xl-font/
set antialias                      " pretty text
set expandtab                      " convert tabs to spaces
set cursorline                     " highlight the current line
"set clipboard+=unnamed             " add the unnamed register to the clipboard
set synmaxcol=1024                 " long lines don't get highlighting (slooooow)

set wildignore+=node_modules/**,.bundle/**

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
hi CursorLine term=none ctermbg=None ctermfg=None guibg=#222222 cterm=none

nmap , \

nmap <leader>w :w!<cr>
nmap <leader>. :tabnext<cr>
nmap <leader>/ :tabnext<cr>

" \d will hide/show the tree
" \b expands to :NERDTreeFromBookmark and then you can autocomplete the name of a bookmark
map <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>
map <leader>b :NERDTreeFromBookmark

map <leader>z :execute '!/usr/bin/osascript ~/dotfiles/test.scpt ' . getcwd() . ' &'<CR><CR>

let NERDTreeIgnore=['\.pyc$', '\~$']  "ignore pyc files and anything ending with a ~
let NERDTreeQuitOnOpen=0   " don't collapse NERDTree when a file is opened
let NERDTreeDirArrows=1    " ASCII art doesn't work for me
let NERDTreeMinimalUI=1    " YAGNI

let g:github_user = 'zhm'
let g:github_comment_open_browser = 1

let g:airline_powerline_fonts=1

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

nnoremap <leader>[ ^
nnoremap <leader>] $
nnoremap <leader>cw yiw
nnoremap <leader>rw "_ciw<c-r>"<esc>
nnoremap <leader>e $
nnoremap <leader>f ^
nnoremap <s-h> b
nnoremap <s-l> w

" nnoremap <C-K> O<Esc>j
" nnoremap <C-J> o<Esc>k

" insert a new line at the cursor without leaving normal mode
nnoremap <s-enter> a<cr><esc>
nnoremap <c-enter> I<cr><esc>k
nnoremap <a-enter> o<esc>k

" use emacs-style shortcuts for command mode like the terminal
cnoremap <C-A> <Home>
cnoremap <C-E> <End>

noremap <Up>     :echo "No"<cr>
noremap <Down>   :echo "No"<cr>
noremap <Left>   :echo "No"<cr>
noremap <Right>  :echo "No"<cr>
inoremap <Up>    :echo "No"<cr>
inoremap <Down>  :echo "No"<cr>
inoremap <Left>  :echo "No"<cr>
inoremap <Right> :echo "No"<cr>

" move single lines using vim-unimpaired
nmap <C-Up> [e
nmap <C-Down> ]e
" move multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

"select last edited text using the edit markers
nmap gV `[v`]

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

map <leader>ct :!/usr/local/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"TagHighlight
map <leader>ht :UpdateTypesFileOnly<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set tags+=~/.tags/node
au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set tags+=~/.tags/stdlibcpp
au BufRead,BufNewFile *.cson set ft=coffee
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

set completeopt=menu

" switch between cpp/hpp
function! SwitchSourceHeader()
  if (expand ("%:e") == "cpp")
    find %:t:r.hpp
  else
    find %:t:r.cpp
  endif
endfunction

" nmap <leader>s :call SwitchSourceHeader()<CR>

" a.vim mapping
nmap <leader>s :AV<CR>
nmap <leader>r :A<CR>

"javascript files
autocmd BufNewFile,BufRead *.json set filetype=javascript
autocmd BufNewFile,BufRead *.geojson set filetype=javascript
autocmd BufNewFile,BufRead *.ejs set filetype=html.javascript

autocmd BufNewFile,BufRead *.aliases set filetype=sh
autocmd BufNewFile,BufRead *.functions set filetype=sh

autocmd VimEnter * hi NERDTreeDir guifg=#eeeeee gui=bold
autocmd VimEnter * hi NERDTreeDirSlash guifg=#eeeeee
autocmd VimEnter * hi NERDTreeExecFile gui=none

command! -nargs=1 -range SuperRetab <line1>,<line2>s/\v%(^ *)@<= {<args>}/\t/g

"easytags config
let g:easytags_cmd = '/usr/local/bin/ctags'
let g:easytags_include_members = 1

" vim-gist setup
let g:gist_detect_filetype = 1       " auto detect file type from file name
let g:gist_clip_command = 'pbcopy'   " copy link to clipboard after it's posted

" syntastic/c++
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_check_header = 1
"let g:syntastic_mode_map = { 'passive_filetypes': ['cpp', 'hpp'] }
let g:syntastic_cpp_compiler_options = ' -std=c++14 -I/usr/local/include/node -I/Users/zacmcc/local/include -I/usr/local/include'

let g:syntastic_javascript_checkers = ['eslint']

" vim-powerline
let g:Powerline_symbols = 'fancy'

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif


command Xmake :! find `pwd` -iname "*.xcodeproj" -exec xcodebuild -project "{}" $@ \;
"command CppInclude b:syntastic_cpp_cflags = ' -I/usr/include/libsoup-2.4'
command! -nargs=1 CppInclude let b:syntastic_cpp_cflags = <q-args>

" Command-T
let g:CommandTMaxHeight=20
let g:CommandTMatchWindowReverse=1


function! StripWhitespace()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

command! Strip call StripWhitespace()<cr>
nnoremap <leader>l :Strip<cr>

" tabularize is a long word.
command! -nargs=1 Tab call Tabularize(<f-args>)


""" FocusMode, adopted from http://paulrouget.com/e/vimdarkroom/
function! ToggleFocusMode()
  if (&foldcolumn != 12)
    set laststatus=0
    set numberwidth=10
    set foldcolumn=12
    set noruler
    hi FoldColumn ctermbg=000000
    hi LineNr ctermfg=0 ctermbg=0
    hi NonText ctermfg=0
  else
    set laststatus=2
    set numberwidth=4
    set foldcolumn=0
    set ruler
    "execute 'colorscheme ' . g:colors_name
  endif
endfunc

nnoremap <leader>fm :call ToggleFocusMode()<cr>
command! Focus call ToggleFocusMode()<cr>



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
