if filereadable("./.vim")
	source ./.vim
endif

set tags+=~/.vim/systags

if has("syntax")
	syntax on " 语法高亮
endif
colorscheme ron " elflord ron peachpuff default 设置配色方案，vim自带的配色方案保存在/usr/share/vim/vim72/colors目录下
"set background=dark
" detect file type
filetype on
filetype plugin on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
	au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
	"have Vim load indentation rules and plugins according to the detected filetype
	filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.

set ignorecase " 搜索模式里忽略大小写
set smartcase " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项。只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用。
set autowrite " 自动把内容写回文件: 如果文件被修改过，在每个 :next、:rewind、:last、:first、:previous、:stop、:suspend、:tag、:!、:make、CTRL-] 和 CTRL-^命令时进行；用 :buffer、CTRL-O、CTRL-I、'{A-Z0-9} 或 `{A-Z0-9} 命令转到别的文件时亦然。
set autoindent " 设置自动对齐(缩进)：即每行的缩进值与上一行相等；使用 noautoindent 取消设置
set smartindent " 智能对齐方式

set fileencodings=utf-8,gbk,gb2312
set smarttab
set expandtab
set tabstop=4 " 设置制表符(tab键)的宽度
set softtabstop=4 " 设置软制表符的宽度
set shiftwidth=4 " (自动) 缩进使用的4个空格
set cindent " 使用 C/C++ 语言的自动缩进方式
set cinoptions={0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s "设置C/C++语言的具体缩进方式
"set backspace=2 " 设置退格键可用
set showmatch " 设置匹配模式，显示匹配的括号
set linebreak " 整词换行
set whichwrap=b,s,<,>,[,] " 光标从行首和行末时可以跳到另一行去
"set hidden " Hide buffers when they are abandoned
set mouse=a " Enable mouse usage (all modes) "使用鼠标
set number " Enable line number "显示行号
"set previewwindow " 标识预览窗口
set history=8 " set command history to 50 "历史记录50条


"--状态行设置--
set laststatus=2 " 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set ruler " 标尺，用于显示光标位置的行号和列号，逗号分隔。每个窗口都有自己的标尺。如果窗口有状态行，标尺在那里显示。否则，它显示在屏幕的最后一行上。

"--命令行设置--
set showcmd " 命令行显示输入的命令
set showmode " 命令行显示vim当前模式

"--find setting--
set incsearch " 输入字符串就显示匹配点
set hlsearch

"--ctags setting--
" 按下F5重新生成tag文件，并更新taglist
map <F5> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+fq .<CR><CR> :TlistUpdate<CR>
imap <F5> <ESC>:!ctags -R --c++-kinds=+p --fields=+iaS --extra=+fq .<CR><CR> :TlistUpdate<CR>

"-- Taglist setting --
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
let Tlist_Use_Right_Window=1 "让窗口显示在右边，0的话就是显示在左边
let Tlist_Show_One_File=1 "让taglist可以同时展示多个文件的函数列表
let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
let Tlist_Exit_OnlyWindow=1 "当taglist是最后一个分割窗口时，自动推出vim
"是否一直处理tags.1:处理;0:不处理
let Tlist_Process_File_Always=1 "实时更新tags
let Tlist_Enable_Fold_Column=0
let Tlist_WinWidth=26

"-- QuickFix setting --
"" 按下F6，执行make clean
map <F9> :cclose<CR>
" 按下F7，执行make编译程序，并打开quickfix窗口，显示编译信息
map <F6> :make<CR><CR><CR> :copen<CR><CR>
" " 按下F8，光标移到上一个错误所在的行
map <F7> :cp<CR>
" " 按下F9，光标移到下一个错误所在的行
map <F8> :cn<CR>
" " 以上的映射是使上面的快捷键在插入模式下也能用
imap <F9> <ESC>:cclose<CR>
imap <F6> <ESC>:make<CR><CR><CR> :copen<CR><CR>
imap <F7> <ESC>:cp<CR>
imap <F8> <ESC>:cn<CR>

"-- Cscope setting --
if has("cscope")
	set csprg=cscope " 指定用来执行cscope的命令
	set csto=1 " 设置cstag命令查找次序：0先找cscope数据库再找标签文件；1先找标签文件再找cscope数据库
	set cst " 同时搜索cscope数据库和标签文件
	set cscopequickfix=s-,c-,d-,i-,t-,e- " 使用QuickFix窗口来显示cscope查找结果
	set nocsverb
	if filereadable("cscope.out") " 若当前目录下存在cscope数据库，添加该数据库到vim
		cs add cscope.out
	elseif $CSCOPE_DB != "" " 否则只要环境变量CSCOPE_DB不为空，则添加其指定的数据库到vim
		cs add $CSCOPE_DB
	endif
	set csverb
endif
" 将:cs find c等Cscope查找命令映射为<C-_>c等快捷键（按法是先按Ctrl+Shift+-, 然后很快再按下c）
nmap <F2> :cs find s <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <F3> :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR> :copen<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i <C-R>=expand("<cfile>")<CR><CR> :copen<CR><CR>

"NERD Tree
let NERDChristmasTree=1
let NERDTreeAutoCenter=1
"let NERDTreeBookmarksFile=$VIM.'/Data/NerdBookmarks.txt'
let NERDTreeMouseMode=2
let NERDTreeShowBookmarks=0
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=0
let NERDTreeWinPos='left'
let NERDTreeWinSize=31
map ,f :NERDTreeFind<CR>
map ,n :NERDTreeToggle<CR>
map ,t :TlistToggle<CR>

"-- omnicppcomplete setting --
map <F1> a<C-X><C-O>
imap <F1> <C-X><C-O>
" 按下F2根据头文件内关键字补全
"map <F2> <C-X><C-I>
"imap <F2> <C-X><C-I>
set completeopt=menu,menuone " 关掉智能补全时的预览窗口
let OmniCpp_MayCompleteDot = 1 " autocomplete with .
let OmniCpp_MayCompleteArrow = 1 " autocomplete with ->
let OmniCpp_MayCompleteScope = 1 " autocomplete with ::
let OmniCpp_SelectFirstItem = 2 " select first item (but don't insert)
let OmniCpp_NamespaceSearch = 2 " search namespaces in this and included
" files
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window
let OmniCpp_GlobalScopeSearch=1 " enable the global scope search
let OmniCpp_DisplayMode=1 " Class scope completion mode: always show all
"members
let OmniCpp_DefaultNamespaces=["std"]
"let OmniCpp_ShowScopeInAbbr=1 " show scope in abbreviation and remove the
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"last column
let OmniCpp_ShowAccess=1
set nocp
filetype plugin on
hi PmenuSel ctermfg=7 ctermbg=4 " 改变选中菜单颜色
hi Pmenu ctermfg=7 ctermbg=0 "改变菜单颜色
"autocmd VimEnter * Tlist|NERDTree
autocmd FileType qf wincmd J

set nocompatible

"2.backspace有几种工作方式，默认是vi兼容的。对新手来说很不习惯。对老vi 不那么熟悉的人也都挺困扰的。可以用
set backspace=indent,eol,start

map <F4> :NERDTreeToggle<CR>:TlistToggle<CR>
imap <F4> <ESC>:NERDTreeToggle<CR>:TlistToggle<CR>

map <C-N> <ESC>:nohl<CR>

map <C-h> <C-W><LEFT>
imap <C-h> <ESC><C-W><LEFT>
map <C-l> <C-W><RIGHT>
imap <C-l> <ESC><C-W><RIGHT>
map <C-k> <C-W><UP>
imap <C-k> <ESC><C-W><UP>
map <C-j> <C-W><DOWN>
imap <C-j> <ESC><C-W><DOWN>

imap <C-d> <ESC>:!dict <C-R><C-W><CR>
map <C-d> :!dict <C-R><C-W><CR>


set cursorline

"折叠选项
set foldmethod=syntax
set foldcolumn=0 " 设置折叠栏宽度
set foldlevel=100 "不折叠代码

if has("autocmd")
  au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
  au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
endif
