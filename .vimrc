"自己定义vimrc常见设置和一些键位的设置

if filereadable(expand("~/.vim/.vimrc.hotkey"))
    source ~/.vim/.vimrc.hotkey
endif
"---------------- 加载插件管理文件 --------------------

if filereadable(expand("~/.vim/.vimrc.bundles"))
    source ~/.vim/.vimrc.bundles
endif
if filereadable(expand("~/.vim/.vimrc.bundles.plugin"))
    source ~/.vim/.vimrc.bundles.plugin
endif

" 在插入模式下MAC下的delete不能删除问题
set backspace=2

"--------------- leader设定 -------------
"let mapleader = ','
"let g:mapleader = ','

"------------------------------- 基本设置 -----------------------------------

"开启语法高亮
"syntax enable 该命令只在当前文件有效
"syntax on " 所有缓冲区文件都有效
syntax on
"syntax enable
"-------------- 文件检测 ----------------------
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

"--------------- 配色 -------------------------
set t_Co=256
"set background=dark
"colorscheme Tomorrow-Night-Eighties      " 配色主题
colorscheme molokai
"colorscheme solarized
"set nocp
set autoread                 " 文件修改之后自动载入。
set shortmess=atI            " 启动的时候不显示那个援助索马里儿童的提示

set laststatus=2
"set confirm                  " 取消光标闪烁
set noswapfile               " 关闭交换文件

set wildignore=*.swp,*.bak,*.pyc,*.class,.svn

set cursorcolumn             " 突出显示当前列
set cursorline               " 突出显示当前行

set title 
set novisualbell
set noerrorbells

set magic

set ruler                    " 显示当前行号和列号
set number                   " 显示行号
set nowrap                   " 取消换行

set showcmd                  " 在状态栏显示正在输入的命令
set showmode                 " 显示vim模式

set showmatch                " 括号匹配，高亮
set matchtime=1         

set hlsearch                 " 高亮搜索的文本
set incsearch                " 即时搜索
set ignorecase               " 搜索忽略大小写
set smartcase                " 有一个或以上大写字母时仍大小敏感

"set foldclose=all
"set foldenable               " 代码折叠
"set foldmethod=marker      " 可以分为Manual（手工折叠）、Indent（缩进折叠）、Marker（标记折叠）和Syntax（语法折叠）等几种。
" set foldmethod=indent      " 可以分为Manual（手工折叠）、Indent（缩进折叠）、Marker（标记折叠）和Syntax（语法折叠）等几种。
"set foldlevel=99             
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=javascript tabstop=2 shiftwidth=2 softtabstop=2
au BufRead,BufNewFile *.json set ft=javascript syntax=javascript shiftwidth=2 tabstop=2
au BufRead,BufNewFile *.volt set ft=html syntax=html shiftwidth=2 tabstop=2 "设置 volt phtml 为 html 格式高亮 和缩进
au BufRead,BufNewFile *.phtml set ft=html syntax=html shiftwidth=2 tabstop=2


"set smartindent              " 智能缩进
"set autoindent               " 自动缩进

"------------------------------- tab 相关设置 ---------------------
set tabstop=4                " 设置tab的宽度
set shiftwidth=4             " 每一次缩进对应的空格数
set softtabstop=4            " 按退格键是可以一次删除4个空格
set smarttab                 
set expandtab                " 将tab自动转化为空格
set shiftround               " 缩进时，取整

"------------------------------- 文件编码 -------------------------
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,shift-jis,gb18030,gbkgb2312,cp936 " 自动判断编码
set helplang=cn
set ffs=unix,mac,dos

set formatoptions+=B          " 合并两行中文时，不在中间加空格
set termencoding=utf-8        " 终端编码

"------------------------------- 其他设置 -------------------------
set completeopt=longest,menu  " 让vim的补全菜单和ide一致
set wildmenu
set wildignore=*.0,*~,*.pyc,*.class

autocmd! bufwritepost .vimrc source % " vimrc 文件修改后自动加载

"------------------------------- 自定义快捷键设置 -----------------


" python 文件的一般设置
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType php set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufNewFile *.js exec ":call AutoSetFileHead()"

" php自动完成
autocmd FileType php set omnifunc=phpcomplete#CompletePHP keywordprg=pman
" 当文件类型为php时，将系统自动补全的快捷键更改为 ,a
"autocmd FileType php inoremap <leader>a <C-x><C-o>

" 只有在是PHP文件时，才启用PHP补全
au FileType php call AddPHPFuncList()
function! AddPHPFuncList()
    set dictionary-=~/.vim/funclist.txt dictionary+=~/.vim/funclist.txt dictionary+=~/.vim/phpunit.txt
    set complete-=k complete+=k
endfunction


" =======================================
" 定义函数AutoSetFileHead，自动插入文件头
" =======================================
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# -*- coding: utf-8 -*- ")
    endif

    if &filetype == 'javascript'
        call setline(1,"/*jslint")
        call setline(2, "node :true, continue:true, devel:true")
        call setline(3, ", indent:2, maxerr:50, newcap:true")
        call setline(4, ", nomen:true,  plusplus:true, regexp:true")
        call setline(5, ", sloppy:true, vars:false, white:true")
        call setline(6, "*/")
    endif
    normal G
    normal o
    normal o
endfunc




"set some keyword to highlight
if has("autocmd")
    "Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo', '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif

" ----------------------- 插件设置 ------------------------------


" *********************** 语法检查 ******************************
"let g:syntastic_error_symbol='>>'
"let g:syntastic_warning_symbol='>'
"let g:syntastic_check_on_open=1
"let g:syntastic_check_on_wq=0
"let g:syntastic_enable_highlighting=1
"let g:syntastic_python_checkers=['pyflakes', 'pep8']
"let g:syntastic_python_pep8_args='--ignore=E501,E225'
"
"let g:syntastic_always_populate_loc_list=0
"let g:syntastic_auto_loc_list=0
"let g:syntastic_loc_list_height=3
"
"function! ToggleErrors()
"    let old_last_winnr = winnr('$')
"    lclose
"    if old_last_winnr == winnr('$')
"        "Nothing was closed, open syntastic error location panel
"        Errors
"    endif
"endfunction
"
"nnoremap <leader>s :call ToggleErrors()<cr>

" *********************** autopep8语法检查 ******************************
let g:autopep8_max_line_length=79


" *********************** 自动补全引号等插件设置 ****************
au FileType python let b:delimitMate_nesting_quotes = ['"']

" ********************** 全局搜索 ***********************
let g:ag_prg = "ag --nogroup --nocolor --column"


" python 相关语法检查
let g:pyflakes_use_quickfix = 0
let python_highlight_all = 1

" *********************** markdown 插件设置 *********************
let g:vim_markdown_folding_disable = 1

" 多光标选中编辑设置
" let g:multi_cursor_use_default_mapping = 0
" let g:multi_cursor_next_key='<C-m>'
" let g:multi_cursor_prev_key='<C-p>'
" let g:multi_cursor_skip_key='<C-x>'
" let g:multi_cursor_quit_key='<Esc>'

" *********************** 快速注释 ******************************
"let g:NERDSpaceDelims = 1
"
"" *********************** 文件搜索插件 **************************
"let g:ctrlp_map = '<leader>p'
"let g:ctrlp_cmd = 'CtrlP'
"map <leader>f : CtrlPMRU<CR>
"let g:ctrlp_custom_ignore = {
"            \ 'dir': '\v[\/]\.(git|hg|svn|rvm)$',
"            \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
"            \}
"
"let g:ctrlp_working_path_mode=0
"let g:ctrlp_match_window_bottom=1
"let g:ctrlp_max_height=15
"let g:ctrlp_match_window_reversed=0
"let g:ctrlp_mruf_max=500
"let g:ctrlp_follow_symlinks=1
"
"" ctrlp相关插件 函数搜索
"nnoremap <Leader>fu: CtrlPFunky<Cr>
"nnoremap <Leader>fU:execute 'CtrlpFunky ' . expand('<cword>')<Cr>
"let g:ctrlp_funky_syntax_highlight = 1
"let g:ctrlp_extensions = ['funky']
"
"" *********************** pyflakes_vim 插件设置 *****************
"let g:pyflakes_user_quickfix=0
"
"" *********************** python-syntax *************************
"let python_highlight_all=1
"
"" *********************** vim-markdown **************************
"let g:vim_mardown_folding_disabled=1
"
"" vim，主机复制共享
""vmap <C-c> "+y
""vmap <C-x> "+c    
""vmap <C-v> c<ESC>"+p    
""imap <C-v> <C-r><C-o>+    
""nmap <C-v> "+p
"
"" powerline设置
"set guifont=PowerlineSymbols\ for\ Powerline:h20
"set nocompatible
"set laststatus=2
"let g:Powerline_symbols = 'fancy'
"let Powerline_symbols='compatible'    
"
"" gitgutter设置
"let g:gitgutter_map_keys = 0
"let g:gitgutter_enabled = 0
"let g:gitgutter_highlight_lines = 1
"nnoremap <leader>gs :GitGutterToggle<CR>



let Tlist_JS_Settings = 'javascript;s:string;a:array;o:object;f:function'
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
set autoindent
"set cinkeys={%if
"set cinoptions=2

