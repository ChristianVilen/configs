Tmux Cheatsheet

		PANES

CTRL+a %			Splitting current window into panes

CTRL+a "			Splitting pane into two vertical ones

CTRL+a Arrows			Move between panes

CTRL+a z			Fullscreen current pane

CTRL+a x			Close current pane

		WINDOWS

CTRL+a c 			New window

CTRL+a number			Change window

CTRL+a ,			Rename current window§

CTRL+a &			Close current window

CTRL+a p/n			Previous/next window

CTRL+a ,			Rename window

		SESSIONS

CTRL+a d			Detach and end session

tmux attach -t 0		To reattach

tmux kill-session -t 0		To end a session

tmux ls				See running sessions
