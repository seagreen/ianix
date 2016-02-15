set colorcolumn&
set noexpandtab
set nolist

colorscheme peaksea

" A replacement for gofmt that also updates imports.
"
" Requires this package:
"
"    go get code.google.com/p/go.tools/cmd/goimports
"
let g:gofmt_command="goimports"
