function! myspacevim#before() abort
  call SpaceVim#logger#info('myspacevim#before called')
endfunction

function! myspacevim#after() abort
  inoremap <silent><expr> <c-space> coc#refresh()

  let s:coc_extensions = [
        \ 'coc-dictionary',
        \ 'coc-elixir',
        \ 'coc-ember',
        \ 'coc-eslint',
        \ 'coc-html',
        \ 'coc-json',
        \ 'coc-json',
        \ 'coc-rls',
        \ 'coc-solargraph',
        \ 'coc-tabnine',
        \ 'coc-tag',
        \ 'coc-go',
        \ 'coc-tsserver',
        \ 'coc-ultisnips',
        \]

  for extension in s:coc_extensions
    call coc#add_extension(extension)
  endfor

  "command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " trailing whitespace
  EnableWhitespace

  " custom indent
  autocmd FileType rust set shiftwidth=4
  autocmd FileType rust set softtabstop=4
  let g:rustfmt_autosave = 1

  " H L mappings
  nnoremap H 0
  nnoremap L $

  " alternate file mapping
  nnoremap <space><space> <c-^>

  " alternate completion cycling
  inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

  " coc vim inoremap <silent><expr> <c-space> coc#refresh()

  let g:neomake_typescript_enabled_makers = ['eslint']

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " Remap for format selected region
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap for do codeAction of current line
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Fix autofix problem of current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

  " Use `:Format` to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Use `:Fold` to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
  let g:coc_fzf_preview = ''
  let g:coc_fzf_opts = []

  echo "bar"
endfunction

