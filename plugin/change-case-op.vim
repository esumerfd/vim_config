fun! s:ChangeCase(lines, changeFn, tokenize) abort
    return map(copy(a:lines), 'a:changeFn(a:tokenize(v:val))')
endf

fun! ChangeCaseOp(visualtype, ...) abort
    let lines = {}
    let is_visual_mode = a:0

    if is_visual_mode
        let start = getpos("'<")[1:2]
        let end = getpos("'>")[1:2]
    else
        let start = getpos("'[")[1:2]
        let end = getpos("']")[1:2]
    endif

    for lnum in range(start[0], end[0])
        let lines[lnum] = getline(lnum)
    endfor

    " filter out empty lines
    call filter(lines, 'v:val =~ "\\S"')

    if len(lines) == 0
        return
    endif

    let lnums = sort(keys(lines), 'N')
    let firstLnum = lnums[0]
    let lastLnum = lnums[-1]
    let startCol = start[1] - 1
    let endCol = end[1]

    let type = { '': 'block',
                \ 'V': 'line',
                \ 'v': 'char',
                \ 'block': 'block',
                \ 'line': 'line',
                \ 'char': 'char'
                \ }[a:visualtype]

    " simplify handling for char motion that affects only a single line
    if len(lines) == 1 && type == 'char'
        let type = 'block'
    endif

    if type == 'block'
        let lines = map(lines, 'strpart(v:val, startCol, endCol - startCol)')
        call filter(lines, 'v:val =~ "\\S"')
        let lnums = sort(keys(lines), 'N')

    elseif type == 'char'
        let lines[firstLnum] = strpart(lines[firstLnum], startCol)
        let lines[lastLnum] = strpart(lines[lastLnum], 0, endCol)
    endif

    let info = ''
    for k in keys(g:changecase_modifiers)
        let info = info . k . ':' . g:changecase_modifiers[k].name . ' '
    endfor

    echo info
    let key = nr2char(getchar())
    " clear status line
    echo ''

    if !has_key(g:changecase_modifiers, key) && key !~ '[[:punct:][:blank:]]'
        return
    endif

    if has_key(g:changecase_modifiers, key)
        let ModifyFn = g:changecase_modifiers[key].modifier
        let TokenizeFn = g:changecase_modifiers[key].tokenizer
    else
        let s:join_char = key
        let ModifyFn = function('s:JoinWithArbitraryChar')
        let TokenizeFn = g:changecase_tokenizers.compounds
    endif

    let newLines = s:ChangeCase(lines, ModifyFn, TokenizeFn)

    " treat first and last line separately if type == 'line'
    if type == 'char'
        call setline(firstLnum, s:ReplaceStringFragment(
                    \ getline(firstLnum),
                    \ startCol,
                    \ len(getline(firstLnum)),
                    \ newLines[firstLnum]))

        call setline(lastLnum, s:ReplaceStringFragment(
                    \ getline(lastLnum),
                    \ 0,
                    \ endCol,
                    \ newLines[lastLnum]))

        let lnums = lnums[1:-2]
    endif

    for lnum in lnums
        if type != 'block'
            let startCol = 0
            let endCol = len(getline(lnum))
        endif

        call setline(lnum, s:ReplaceStringFragment(
                    \ getline(lnum),
                    \ startCol,
                    \ endCol,
                    \ newLines[lnum]))
    endfor

    silent! call repeat#set("\<Plug>ChangeCaseRepeat".key, v:count)
endf

fun! s:ReplaceStringFragment(line, startCol, endCol, repl) abort
    return strpart(a:line, 0, a:startCol)
                \. a:repl
                \. strpart(a:line, a:endCol)
endf

fun! s:TokenizeCompounds(str) abort
    let res = []
    let pat = '\v([[:punct:]]|\s+|\ze\u\l|\U\zs\ze\u)'

    let whitespace = {
                \ 'start': strpart(a:str, 0, match(a:str, '\S')),
                \ 'end': strpart(a:str, match(a:str, '\s*$'))
                \ }

    let str = substitute(a:str, '\v(^\s+|\s+$)', '', 'g')

    " Handle leading whitespace
    if match(str, '\S') > 0
        call add(res, strpart(str, 0, match(str, '\S')))
    endif

    let res = res + split(str, pat)

    " Handle trailing whitespace
    if match(str, '\s*$') < len(str)
        call add(res, strpart(str, match(str, '\s*$')))
    endif

    let res[0] = whitespace.start . res[0]
    let res[-1] = res[-1] . whitespace.end

    return res
endf

fun! s:TokenizeWordBorders(str) abort
    return split(a:str, '\v<|>')
endf

fun! s:ToPascalCase(toks) abort
    let toks = map(copy(a:toks), 'substitute(tolower(v:val), "\\a", "\\u&", "")')
    return join(toks, '')
endf

fun! s:ToCamelCase(toks) abort
    let res = s:ToPascalCase(a:toks)
    return substitute(res, '\a', '\l&', '')
endf

fun! s:ToUpperCase(toks) abort
    return toupper(join(a:toks, ''))
endf

fun! s:ToLowerCase(toks) abort
    return tolower(join(a:toks, ''))
endf

fun! s:ToSnakeCase(toks) abort
    let res = s:ModifyLetterCase(a:toks, s:GuessCase(a:toks))
    return join(res, '_')

endf

fun! s:ToKebapCase(toks) abort
    let res = s:ModifyLetterCase(a:toks, s:GuessCase(a:toks))
    return join(res, '-')
endf

fun! s:ModifyLetterCase(toks, case) abort
    if a:case == 'upper'
        return map(a:toks, 'toupper(v:val)')
    elseif a:case == 'lower'
        return map(a:toks, 'tolower(v:val)')
    else
        return a:toks
    endif
endf

fun! s:JoinWithArbitraryChar(toks) abort
    let res = join(a:toks, s:join_char)
    unlet! s:join_char
    return res
endf

fun! s:ToTitleCase(toks) abort
    let toks = []

    for t in a:toks
        let text = tolower(t)

        if index(g:changecase_lowercase_title_words, t) == -1
            let text = substitute(text, '\a', '\u&', '')
        endif

        call add(toks, text)
    endfor

    " first word always starts with an uppercase letter, ignore non-word tokens before
    let firstWordIdx = match(toks, '\a')
    if firstWordIdx > -1
        let toks[firstWordIdx] = substitute(toks[firstWordIdx], '\a', '\u&', '')
    endif

    return join(toks, '')
endf

fun! s:GuessCase(toks) abort
    if !g:changecase_guess_case
        return 'keep'
    elseif match(a:toks, '\u\{2,}') > -1
        return 'upper'
    else
        return 'lower'
    endif
endf

let g:changecase_tokenizers = {
            \ 'word_boundaries': function('s:TokenizeWordBorders'),
            \ 'compounds': function('s:TokenizeCompounds')
            \ }

let g:changecase_modifiers = {
            \ 'c': {
            \   'name': 'camelCase',
            \   'modifier': function('s:ToCamelCase'),
            \   'tokenizer': g:changecase_tokenizers.compounds },
            \ 'p': {
            \   'name': 'PascalCase',
            \   'modifier': function('s:ToPascalCase'),
            \   'tokenizer': g:changecase_tokenizers.compounds },
            \ 'u': {
            \   'name': 'UPPER CASE',
            \   'modifier': function('s:ToUpperCase'),
            \   'tokenizer': g:changecase_tokenizers.word_boundaries },
            \ 'l': {
            \   'name': 'lower case',
            \   'modifier': function('s:ToLowerCase'),
            \   'tokenizer': g:changecase_tokenizers.word_boundaries },
            \ 's': {
            \   'name': 'snake_case',
            \   'modifier': function('s:ToSnakeCase'),
            \   'tokenizer': g:changecase_tokenizers.compounds },
            \ 'k': {
            \   'name': 'kebap-case',
            \   'modifier': function('s:ToKebapCase'),
            \   'tokenizer': g:changecase_tokenizers.compounds },
            \ 't': {
            \     'name': 'Title Case',
            \     'modifier': function('s:ToTitleCase'),
            \     'tokenizer': g:changecase_tokenizers.word_boundaries }
            \ }

let g:changecase_guess_case = 1
let g:changecase_lowercase_title_words = ['a', 'amid', 'an', 'and', 'anti', 'as', 'at', 'but', 'by', 'down', 'for', 'from', 'if', 'in', 'into', 'like', 'near', 'of', 'off', 'on', 'once', 'onto', 'over', 'past', 'per', 'plus', 'save', 'than', 'that', 'the', 'to', 'up', 'upon', 'via', 'when', 'with']

nnoremap <silent> <Plug>ChangeCaseRepeat .
nnoremap <silent> <Plug>ChangeCase :<C-u>set operatorfunc=ChangeCaseOp<CR>g@
vnoremap <silent> <Plug>ChangeCase :<C-u>call ChangeCaseOp(visualmode(), 1)<CR>
