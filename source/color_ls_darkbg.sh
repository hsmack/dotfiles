#
# See end of this file for LS colors definition
#
# Always use color output for `ls`
if [[ "$OSTYPE" =~ ^darwin ]]; then
    alias ls="command ls -G"
    export CLICOLOR=1
    export LSCOLORS=GxFxCxDxBxegedabagaced
else
    alias ls="command ls --color"
    export LS_COLORS='no=00:fi=00:di=01;36:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# Directory listing
if [[ "$(type -P tree)" ]]; then
    alias ll='tree --dirsfirst -aLpughDFiC 1'
    alias lld='ll -d'
else
    alias ll='ls -al'
    alias lld='CLICOLOR_FORCE=1 ll | grep --color=never "^d"'
fi

#
# DIRCOLORS, which is used in the Linux LS_COLORS
#
# di = directory
# fi = file
# ln = symbolic link
# pi = fifo file
# so = socket file
# bd = block (buffered) special file
# cd = character (unbuffered) special file
# or = symbolic link pointing to a non-existent file (orphan)
# mi = non-existent file pointed to by a symbolic link (visible when you type ls -l)
# ex = file which is executable (ie. has ‘x’ set in permissions).
# and colors
# 0 = default colour
# 1 = bold
# 4 = underlined
# 5 = flashing text
# 7 = reverse field
# 31 = red
# 32 = green
# 33 = orange
# 34 = blue
# 35 = purple
# 36 = cyan
# 37 = grey
# 40 = black background
# 41 = red background
# 42 = green background
# 43 = orange background
# 44 = blue background
# 45 = purple background
# 46 = cyan background
# 47 = grey background
# 90 = dark grey
# 91 = light red
# 92 = light green
# 93 = yellow
# 94 = light blue
# 95 = light purple
# 96 = turquoise
# 100 = dark grey background
# 101 = light red background
# 102 = light green background
# 103 = yellow background
# 104 = light blue background
# 105 = light purple background
# 106 = turquoise background
#
# LS_COLORS Define, used in OS X LS_COLORS
#
# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background
#  
# Note that the above are standard ANSI colors.  The actual display may differ depending on the color capabilities of the terminal in use.
#  
# The order of the attributes are as follows:
#  
# 1.   directory
# 2.   symbolic link
# 3.   socket
# 4.   pipe
# 5.   executable
# 6.   block special
# 7.   character special
# 8.   executable with setuid bit set
# 9.   executable with setgid bit set
# 10.  directory writable to others, with sticky bit
# 11.  directory writable to others, without sticky bit
#  
# 
# 
# 



