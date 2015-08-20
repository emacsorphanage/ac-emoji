.PHONY : data

EMACS ?= emacs

data:
	$(EMACS) --script author/update_emoji.el > ac-emoji-data.el
