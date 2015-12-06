" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    .rush.vim                                          :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: jbernabe <jbernabe@student.42.fr>          +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2015/12/05 16:24:02 by jbernabe          #+#    #+#              "
"    Updated: 2015/12/05 16:49:40 by jbernabe         ###   ########.fr        "
"                                                                              "
" **************************************************************************** "

"column
set cursorcolumn

" identation
set autoindent
set shiftwidth=4
set tabstop=4
set cindent

inoremap        (  ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap        {  {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : ")"

let @/='\s\{2}'
set hls

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\|\s+\s{1}/
autocmd BufWinLeave * call clearmatches()
set backup
set backupdir=~/.emacs.d/
set directory=~/.emacs.d/
set statusline+=col:\ %c,
