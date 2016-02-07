Setting up
  Source Reference : https://gist.github.com/simme/1297707

  # First install tmux
  brew install tmux
   
  # For mouse support (for switching panes and windows)
  # Only needed if you are using Terminal.app (iTerm has mouse support
  Download and install application in zip package found here http://www.culater.net/software/SIMBL/SIMBL.php
      Installing SIMBL Plugins
      Most plugins should come with an installer, however it's easy to do it yourself.
      Plugins can be copied into /Library/Application Support/SIMBL/Plugins for all users, or ~/Library/Application Support/SIMBL/Plugins for just your account.

  Then download and install https://bitheap.org/mouseterm/
      It is a DMG file
   
  # More on mouse support http://floriancrouzat.net/2010/07/run-tmux-with-mouse-support-in-mac-os-x-terminal-app/
   
  # Enable mouse support in ~/.tmux.conf
  set-option -g mouse-select-pane on
  set-option -g mouse-select-window on
  set-window-option -g mode-mouse on
   
  # Install Teamocil to pre define workspaces
  https://github.com/remiprev/teamocil
   
  # See http://files.floriancrouzat.net/dotfiles/.tmux.conf for configuration examples

Usage commands

  Ctrl+b "          - split pane horizontally.
  Ctrl+b %          - split pane vertically.
  Ctrl+b arrow key  - switch pane.
  Hold Ctrl+b, don't release it and hold one of the arrow keys - resize pane.
  Ctrl+b c          - (c)reate a new window.
  Ctrl+b n          - move to the (n)ext window.
  Ctrl+b p          - move to the (p)revious window
  Ctrl+b Shift+D    - detach from current TMUX session


Command to get the list of current active Tmux sessions
```
tmux list sessions
```

Attaching tmux session 10
```
tmux attach -t 10
```

