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

autocmd	BufNewFile	*.c			call	Insert_header_42()
autocmd	BufWritePre	*.c			call	Update_header_42()
function!	Update_header_42()
	let s:author = system("echo $USER42 | tr -d '\n'")
	let l:pattern = "/*   Updated:"
	let l:line = getline(9)
	if match(l:line, l:pattern) != -1
		call Insert_header_42_add_info("Updated", "###   ########.fr       */", 9, 1)
	endif
	unlet s:author
endfunction

function!	Insert_header_42_add_info(begin, end, nul_line, setline)
	let l:line = "/*   " . a:begin . ": " . strftime("%Y/%m/%d %H:%M:%S") . " by " . s:author
	let l:cmd = "echo " . s:author . " | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:len = system(l:cmd)
	let l:space = 17 - l:len
	while l:space >= 0
		let l:line = l:line . " "
		let l:space -= 1
	endwhile
	let l:line = l:line . a:end
	if a:setline ==? '1'
		call setline(a:nul_line, l:line)
	else
		call append(a:nul_line, l:line)
	endif
endfunction

function!	Insert_header_42_add_mail()
	let l:mail = system("echo $MAIL42 | tr -d '\n'")
	let l:line = "/*   By: " . s:author . " <" . l:mail . ">"
	let l:cmd = "echo " . s:author . l:mail . " | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:len = system(l:cmd)
	let l:space = 40 - l:len
	while l:space >= 0
		let l:line = l:line . " "
		let l:space -= 1
	endwhile
	let l:line = l:line . "+#+  +:+       +#+        */"
	call append(5, l:line)
endfunction

function!	Insert_header_42_add_file()
	let l:line = "/*   "
	let l:file = expand('%:f')
	let l:cmd = "/usr/bin/basename " . l:file . " | tr -d '\n'"
	let l:file = system(l:cmd)
	let l:line = l:line . l:file
	let l:cmd = "echo " . l:file . " | wc -c | awk '{print $1}' | tr -d '\n'"
	let l:len = system(l:cmd)
	let l:space = 51 - l:len
	while l:space >= 0
		let l:line = l:line . " "
		let l:space -= 1
	endwhile
	let l:line = l:line . ":+:      :+:    :+:   */"
	call append(3, l:line)
endfunction

function!	Insert_header_42()
	let s:author = system("echo $MAIL | tr -d '\n'")
	call append(0, "/* ************************************************************************** */")
	call append(1, "/*                                                                            */")
	call append(2, "/*                                                        :::      ::::::::   */")
	call Insert_header_42_add_file()
	call append(4, "/*                                                    +:+ +:+         +:+     */")
	call Insert_header_42_add_mail()
	call append(6, "/*                                                +#+#+#+#+#+   +#+           */")
	call Insert_header_42_add_info("Created", " #+#    #+#             */", 7, 0)
	call Insert_header_42_add_info("Updated", "###   ########.fr       */", 8, 0)
	call append(9, "/*                                                                            */")
	call append(10, "/* ************************************************************************** */")
	call append(11, "")
	unlet s:author
endfunction
