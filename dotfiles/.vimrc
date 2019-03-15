"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SETS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on

"Convert tabs to spaces
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Search details
set incsearch
set hlsearch
" Do no wrap searching
set nowrapscan
" To aid the colorscheme...
set t_Co=256
" Create line numbers on the left side of vi, 6 digits worth
set number
set numberwidth=6
" Set text wrapping at 80 columns
set tw=80
" Indent to the tab positiion when  you cross over the 80 line limit.
set smartindent
" Leave a couple of lines at the top and bottom when scrolling
set scrolloff=2
" Give context on where you are in the file
set ruler
" wrapping is a problem more often than not.
set nowrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make 'Q' not annoyingly enter into ex edit mode!
"nnoremap Q <nop>
"nnoremap K <nop>

" Always show a ctags list
"nnoremap <C-]> g<C-]>

" Window splitting (vertical and horizontal)
"nnoremap <C-v> :vsp<CR>
"nnoremap <C-h> :sp<CR>
" Auto completion
"imap <tab> <C-p>
if executable('ag')
    " Use ag over grep
    set gepprg=ag\ --color \ -n \ -B 5 \ -A 5

    " Use af in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --color -g ""'

    " ag is fast enough that we don't need to cache
    let g"ctrlp_use_caching = 0
endif

let g:ycm_global_ycm_extra_conf = "~/Projects/workRequest/bugfixes/release/.ycm_extra_conf.py"

" bind \ to grep short cut
command -nargs=+ -complete=file -bar Ag silent! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" DOXYGEN
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <F5> O/A*74.A//**oi *Brief.Detailed.@returnsA*76.A/6kb
map <F6> O/**/O
map <F7> A /**<  */hhi


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UNDO
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('persistent_undo')
    set undodir=$HOME/.vim/undodir
    set undofile
    set undolevels=1000
    set undoreload=10000
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCOMPLETE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('wildmenu')
"    set wildmode=list:longest,full
    set wildignore+=*.a,*.o,*.orig,*~
    set wildmenu
    set wildmode=longest,list
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MOUSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow the mouse to be used for selecting
" :set mouse=""     Disable all mouse behaviour.
" :set mouse=a      Enable all mouse behaviour (the default).
" :set mouse+=v     Enable visual mode (v)
" :set mouse-=c     Disable mouse in command mode.


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
highlight Folded       ctermfg=7   ctermbg=8
highlight FoldColumn   ctermfg=7   ctermbg=8
highlight Search       ctermfg=16  ctermbg=11
highlight VertSplit    ctermfg=8   ctermbg=0
highlight StatusLine   ctermfg=8   ctermbg=2
highlight StatusLineNC ctermfg=8   ctermbg=60
highlight LineNr       ctermfg=60
highlight Comment      ctermfg=60
highlight Number       ctermfg=202
highlight Search       ctermfg=15  ctermbg=12
highlight Todo         ctermfg=15  ctermbg=11


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SYNTAX HIGHLIGHTING
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match pointer /\*[a-z,A-Z,0-9]*++/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight pointer term = NONE ctermfg=Yellow
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match privCtx /privCtx/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight privCtx term = NONE ctermfg=Yellow
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match annotate
\ /\/\*\* [\:A-Za-z0-9 \n\r\*\\\/]* \*\*\//
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight annotate
\ term=NONE ctermfg=8 ctermbg=2 cterm=bold
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match wescam /moduleSend\w*/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax keyword wescam
\ MSG_Q_ID msgQDelete msgQCreate msgQSend msgQReceive
\ moduleAddCmdQ moduleRemoveCmdQ moduleAddCmd moduleGetCmd moduleRemoveCmd
\ moduleAddCmdRespQ moduleRemoveCmdRespQ moduleAddCmdResp moduleAddCmdResp
\ moduleRemoveCmdResp
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight wescam term=NONE ctermfg=Yellow

autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match defining /#\(define\|undef\) \w*/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight defining term=NONE ctermfg=205

"syn match unimportant /moduleLogError(.*\n\=.*\n\=.*);/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match unimportant
\ /moduleLogError([a-zA-Z0-9-+><,\n \*"%.\\/&:?\[\]_\(\)]*);/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight unimportant term=NONE ctermfg=244
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match this /this/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp highlight this term=NONE ctermfg=3
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match Identifier /\w\+_t\ze\W/
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax match Identifier 'rtems_[a-z_]*\( \|(\)'
autocmd BufRead,BufNewFile *.c,*.h,*.cpp syntax keyword cSpecial
\ TRUE FALSE
\ UNITY UNITY_FLOAT UNITY_SHIFT
\ UNITY7 UNITY7_FLOAT UNITY7_SHIFT
\ UNITY23 UNITY23_FLOAT UNITY23_SHIFT
\ BIT_1 BIT_2 BIT_3 BIT_4 BIT_5 BIT_6 BIT_7 BIT_8
\ BIT_9 BIT_10 BIT_11 BIT_12 BIT_13 BIT_14 BIT_15
\ BIT_A BIT_B BIT_C BIT_D BIT_E BIT_F
\ BIT_16 BIT_17 BIT_18 BIT_19 BIT_20 BIT_21 BIT_22
\ BIT_23 BIT_24 BIT_25 BIT_26 BIT_27 BIT_28 BIT_29
\ BIT_30 BIT_31


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTO COMMANDS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
" autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
" autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
" autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
" autocmd BufRead,BufNewFile *.[ch] endif

" Remove trailing whitepsaces for each line on save.
" Highlight text that goes past the 80 line limit.
augroup vimrc_autocmds
" autocmd BufReadPre * setlocal foldmethod=syntax
" autocmd BufWinEnter * if &fdm == 'syntax' | setlocal foldmethod=manual | endif
  autocmd BufEnter * highlight OverLength ctermbg=7 ctermfg=0 guibg=#707070
  autocmd BufEnter * match OverLength /\%81v.*/
augroup END

if has("autocmd")
" autocmd BufRead,BufNewFile *.[ch] let fname = expand('<afile>:p:h') . '/types.vim'
" autocmd BufRead,BufNewFile *.[ch] if filereadable(fname)
" autocmd BufRead,BufNewFile *.[ch]   exe 'so ' . fname
" autocmd BufRead,BufNewFile *.[ch] endif
" Remove trailing whitepsaces for each line on save.
  autocmd BufWritePre * :%s/\s\+$//e
endif

augroup cprog
  " Remove all cprog autocommands
  au!

  " For *.c and *.h files set formatting of comments and set C-indenting on.
  " For other files switch it off.
  " Don't change the order, it's important that the line with * comes first.
    autocmd BufRead,BufNewFile *       set formatoptions=tcql nocindent comments&
    autocmd BufRead,BufNewFile *.c,*.h,*.cpp set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
    set cino=:0,(0,c1
  augroup END

  autocmd BufWritePre * :%s/\s\+$//e
endif

" Automatically update the ctags file when a file is written
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGINS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-c> :y+
nnoremap <C-f> :%s/
nnoremap <C-o> :!
nnoremap <C-j> :!
nnoremap <F7> :! git rev-parse --abbrev-ref HEAD <CR>

" get the notename
function! GetNoteName()
    let s:branch = system('git rev-parse --abbrev-ref HEAD')
    let s:shortBranch = substitute(s:branch,".*\/rm\/","","")
    let l:noteName = "~/notes/" . substitute(s:shortBranch,"_.*","","") . ".md"
    execute "vsplit" l:noteName
endfunction

nnoremap <C-m> :call GetNoteName()<CR>
" Git Fugitive
"set statusline=%{fugitive#statusline()}


" execute pathogen#infect()
" set rtp+=/usr/local/opt/fzf
"/home/linuxbrew/.linuxbrew/opt/fzf
""""""""""""
" VIM PLUG "
""""""""""""
if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf'
call plug#end()

" Open files in vertical horizontal split
nnoremap <silent> <C-g> :call fzf#run({
    \   'right': winwidth('.') / 2,
    \   'sink':  'vertical botright split',
    \   'height': '40%'})<CR>
nnoremap <C-p> :Files<Cr>
