Fonts Setup
============

```
# copy fonts
mkdir ~/.fonts
cp PowerlineSymbols.otf ~/.fonts
fc-cache -vf ~/.fonts

# set symbols cannot be displayed fallback to Powerline Symbols
mkdir ~/.fonts.conf.d
cp 10-powerline-symbols.conf ~/.fonts.conf.d/
```
