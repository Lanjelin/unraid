# neofetch and fastfetch for unraid

Unraid logo for use with neofetch and fastfetch.

## How to use

`neofetch --ascii neo-unraid-circle.txt --ascii_colors 1 7`
`fastfetch --logo fast-unraid-wave-24.txt`

### Tools used

[jp2a](https://github.com/cslarsen/jp2a)
[jp2a2neofetch.py](https://gist.github.com/OpenBagTwo/54f209cbe8abbd04b9d5b0b880b6a8a2)

#### Commands

```bash
jp2a --colors --width=44 --background=light --color-depth=4 unraid-wave.jpg | ./jp2a2neofetch.py >! neo-unraid-wave.txt
jp2a --colors --width=44 --background=dark --color-depth=4 unraid-circle.png | ./jp2a2neofetch.py >! neo-unraid-circle.txt # needed additional cleanup

jp2a --colors --width=44 --background=light --color-depth=4 unraid-wave.jpg >! fast-unraid-wave-4.txt
jp2a --colors --width=44 --background=light --color-depth=24 unraid-wave.jpg >! fast-unraid-wave-24.txt
jp2a --colors --width=44 --background=dark --color-depth=4 unraid-circle.png >! fast-unraid-circle-4.txt
jp2a --colors --width=44 --background=dark --color-depth=24 unraid-circle.png >! fast-unraid-circle-24.txt
```
