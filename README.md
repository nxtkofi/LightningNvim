## Preview
![Dashboard with open console and Neo-Tree](/Preview/Pasted%20image%2020241103022048.png)
![Dashboard on enter, example random header](/Preview/Pasted%20image%2020241103021712.png)
![Dashboard on enter, example random header](/Preview/Pasted%20image%2020241103021637.png)
![Dashboard on enter, example random header](/Preview/Pasted%20image%2020241103021543.png)

## LightningNvim
Is a productivity tool. It was made for people who just like
me want to stay in a flow for as long as possible.
LightningNvim provides
- Debugging tools for Java and Typescript (React too).
- In-file translation 
- Markdown files support 
- Obsidian integration
- AutoSave
- pasting images from clipboard into Your .md files<br/>
and many more plugins that You will find incredibly useful.

## Dashboard images
How do I set my own dashboard images? Very easy! We're going
to use [Asthestarsfalll's img2art github repository](https://github.com/Asthestarsfalll/img2art) but
with a quick style fix from me, that's going to speed up the
process by 90%.

>[!important]
> For more details or custom output options visit [Asthestarsfalll's img2art github repository](https://github.com/Asthestarsfalll/img2art) <br/>
> Without him none of this would be possible! 

#### img2art Installation

##### Prerequisites
Due to the fix that we had to apply make sure that You have python's `poetry` installed on your system.
1. Clone [my fork](https://github.com/nxtkofi/img2art) of ASthestarsfalll's repository.
`git clone https://github.com/nxtkofi/img2art`
2. Install requirements inside the project root
```
cd img2art
python -m venv
source venv/bin/activate 
pip install typer opencv-python numpy
```

We're now ready to go!
Run:
`poetry run python -m img2art.cli ~/path/to/picture.jpg --scale 0.3 --threshold 20 --save-raw ./test.lua --alpha`

What does it do:
- `--scale 0.3` This is scaling for our image. Pick a value so it fits into Your dashboard
- `--threshold 20` This is black-white threshold point. I suggest You play around it for a bit to see what's the best outcome for Your picture. Usually it's something between 20-150
- `./test.lua` This is where our output file will go and what name will it receive. Leave .lua extension. You may change the name.
- `--alpha` This makes sure that we get our picture in desired output style (ready to paste into alpha's dashboard!).

You should have Your output file now!
Move it into header_img folder.
Now to set a header image go ahead and check out my ./lua/custom/plugins/alpha.lua file.<br/>
Function `load_random_header()` loads random header image from header_img folder on nvim startup.

>[!important]
> Make sure you add `local header = load_random_header()` - otherwise Your image will not get initialized.


>[!tip]
> I also wrote a function `change_header()` which let's you change header when you press `w` in dashboard.


## Keymaps
All keymaps are defined in /lua/keymaps.lua (except for
those that were defined in plugin files - those are listed
at the end of keymaps.lua so You can easily find them!)

## Used packages
##### Thanks to all plugin creators! 

<i>"You guys, you guys are the real heroes!"</i>

- numToStr/Comment.nvim
- goolord/alpha-nvim
- windwp/nvim-autopairs
- OlegGulevskyy/better-ts-errors.nvim
- mistricky/codesnap.nvim
- sindrets/diffview.nvim
- 3rd/image.nvim
- HakonHarnes/img-clip.nvim
- rebelot/kanagawa.nvim
- kdheepak/lazygit.nvim
- OXY2DEV/markview.nvim
- nvim-neo-tree/neo-tree.nvim
- rcarriga/nvim-dap-ui
- mfussenegger/nvim-jdtls
- neovim/nvim-lspconfig"
- JoosepAlviste/nvim-ts-context-commentstring
- epwalsh/obsidian.nvim
- olimorris/onedarkpro.nvim
- hedyhli/outline.nvim
- rose-pine/neovim
- rachartier/tiny-inline-diagnostic.nvim
- folke/todo-comments.nvim
- akinsho/toggleterm.nvim
- uga-rosa/translate.nvim
- xiyaowong/transparent.nvim
- pmizio/typescript-tools.nvim
- Asthestarsfalll/img2art
- andrewferrier/wrapping.nvim
