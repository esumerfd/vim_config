if !hasmapto('<Plug>ChangeCase', 'n')
    nmap cC <Plug>ChangeCase
    nmap cCc cC_
    nmap cCC cC$
endif

if !hasmapto('<Plug>ChangeCase', 'x')
    xmap C <Plug>ChangeCase
endif

