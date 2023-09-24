-- Esto es necesario para que VimTeX se cargue correctamente. El "indent" es opcional.
-- La mayoría de los gestores de complementos lo hacen automáticamente.
vim.cmd('filetype plugin indent on')

-- Esto habilita las características relacionadas con la sintaxis de Vim y Neovim. Sin esto, algunas características de VimTeX no funcionarán (consulte ":help vimtex-requirements" para obtener más información).
vim.cmd('syntax enable')

-- Opciones de visualizador: Se puede configurar el visualizador especificando un método de visualización incorporado:
vim.g.vimtex_view_method = 'zathura'

-- O con una interfaz genérica:
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf#src:@line@tex'

-- VimTeX utiliza latexmk como el backend de compilador por defecto. Si lo utiliza, lo cual se recomienda encarecidamente, probablemente no necesite configurar nada. Si desea otro backend de compilador, puede cambiarlo de la siguiente manera. La lista de backends compatibles y una explicación adicional se proporciona en la documentación, consulte ":help vimtex-compiler".
vim.g.vimtex_compiler_method = 'latexmk'
