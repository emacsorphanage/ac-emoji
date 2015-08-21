# ac-emoji

[auto-complete](https://github.com/auto-complete/auto-complete) source of [emoji](http://www.emoji-cheat-sheet.com/).


## Screencast

![ac-emoji](image/ac-emoji.gif)


## Command

#### `M-x ac-emoji-setup`

Set auto-complete emoji source to `ac-sources`


## Sample Configuration

```lisp
(add-hook 'markdown-mode-hook 'ac-emoji-setup)
(add-hook 'git-commit-mode-hook 'ac-emoji-setup)
```
