
mkdir -p ~/.vim/bundle

url_list=(
https://github.com/tpope/vim-pathogen.git
#https://github.com/vim-scripts/EasyGrep.git
https://github.com/andymass/vim-matchup.git
https://github.com/scrooloose/nerdtree.git
https://github.com/scrooloose/nerdcommenter.git
https://github.com/tpope/vim-surround.git
https://github.com/mbbill/undotree.git
https://github.com/itchyny/lightline.vim.git
https://github.com/Raimondi/delimitMate.git
#https://github.com/vim-scripts/vcscommand.vim.git
#https://github.com/ctrlpvim/ctrlp.vim.git
https://github.com/ervandew/supertab.git
https://github.com/junegunn/vim-easy-align.git
#https://github.com/cjrh/vim-conda.git
#https://github.com/davidhalter/jedi-vim.git
https://github.com/sirver/ultisnips.git
https://github.com/honza/vim-snippets.git
https://github.com/kana/vim-textobj-user.git
https://github.com/michaeljsmith/vim-indent-object.git
https://github.com/tpope/vim-fugitive.git
#https://github.com/junegunn/fzf.git
https://github.com/Yggdroot/LeaderF.git
)

#echo ${#url_list[@]}

for url in ${url_list[@]}; do

plug_name=$(echo  "${url}" | sed -e s@.*/@@g | sed -e s@\.git\$@@ )
#echo ${plug_name}


if [ -d ~/.vim/bundle/${plug_name} ]; then
	echo '[>>>>>>>>>>>>>>>>>>> Update   plugin: ' ${plug_name}
	cd ~/.vim/bundle/${plug_name}
	git pull origin master
	cd -
else
	echo '[>>>>>>>>>>>>>>>>>>> Download plugin: ' ${plug_name}
	git clone ${url} ~/.vim/bundle/${plug_name}
fi


done
