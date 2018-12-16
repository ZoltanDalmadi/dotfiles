set -x TERM screen-256color
set -gx PATH ~/.npm-global/bin ~/Apps/google-cloud-sdk/bin ~/bin $PATH

#switch $TERM
#  case 'st-*' # suckless' simple terminal
#  tput smkx

#  function st_smkx --on-event fish_postexec
#    tput smkx
#  end
#  function st_rmkx --on-event fish_preexec
#    tput rmkx
#  end
#end

# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'


function fish_prompt
  set last_status $status
  set_color $fish_color_user
  printf '%s' $USER
  set_color normal
  printf '@'
  set_color $fish_color_host
  printf '%s ' (hostname)
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal
  printf '%s ' (__fish_git_prompt)
end

function ..
  cd .. $argv
end

function df
  command df -h $argv
end

function ls
  command ls -lah --group-directories-first $argv
end

function diff
  colordiff $argv
end

function du
  command du -c -h $argv
end

function free
  command free -m $argv
end

function grep
  command grep --color=auto $argv
end

function mkdir
  command mkdir -p -v $argv
end

function tree
  command tree -C $argv
end

if test (id -u) -ne 0
  function pacman
    sudo pacman $argv
  end

  function systemctl
    sudo systemctl $argv
  end

  function docker
    sudo docker $argv
  end
end

function pacupg -d 'Synchronize with repositories and then upgrade packages that are out of date on the local system.'
  pacman -Syu $argv
end

function pacupd -d 'Refresh of all package lists after updating /etc/pacman.d/mirrorlist.'
  pacman -Sy $argv
end

function pacin -d 'Install specific package(s) from the repositories.'
  pacman -S $argv
end

function pacun -d 'Remove the specified package(s), its configuration(s) and unneeded dependencies.'
  pacman -Rcsn $argv
end

function pacorph -d 'Remove orphaned packages.'
  pacman -Rs (pacman -Qqdt) $argv
end

function pacsearch -d 'Search for package(s) in the repositories'
  pacman -Ss $argv
end
