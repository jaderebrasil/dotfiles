DFMRPATH=".local/share/dotfiles"
DFMREPO="git@gitlab.com:jaderbrasil/dotfiles.git"
DFMBKP=".local/share/dotfiles-bkp"

git clone --bare $DFMREPO $HOME/$DFMRPATH
function dfmconfig {
   /usr/bin/git --git-dir=$HOME/$DFMRPATH/ --work-tree=$HOME $@
}
mkdir -p $HOME/$DFMBKP
dfmconfig checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
dfmconfig checkout
dfmconfig config status.showUntrackedFiles no
