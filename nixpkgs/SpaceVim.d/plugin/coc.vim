inoremap <silent><expr> <c-space> coc#refresh()

call coc#config('coc.preferences', {
			\ "autoTrigger": "always",
			\ "maxCompleteItemCount": 10,
			\ "codeLens.enable": 1,
			\ "diagnostic.virtualText": 1,
			\ "eslint.filetypes": ["javascript", "typescript"],
      \ "solargraph.diagnostics": 1,
      \ "solargraph.autoformat": 1,
      \ "solargraph.formatting": 1,
      \ "solargraph.hover": 1,
      \ "solargraph.useBundler": 1,
      \ "tabnine.binary_path": "/home/ghedamat/bin/TabNine",
			\})

let s:coc_extensions = [
			\ 'coc-dictionary',
			\ 'coc-json',
			\ 'coc-ultisnips',
			\ 'coc-tag',
			\ 'coc-elixir',
			\ 'coc-solargraph',
			\ 'coc-html',
			\ 'coc-ember',
			\ 'coc-json',
			\ 'coc-tsserver',
			\ 'coc-rls',
			\]

for extension in s:coc_extensions
	call coc#add_extension(extension)
endfor
