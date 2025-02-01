## Preview

![arcane_ekko image preview](./assets/README-img/2025-02-01-at-15-01-04.avif)
*Arcane_ekko.jpg image preview*
---
![Arcane wild rune image](./assets/README-img/2025-02-01-at-15-02-21.avif)
*You can change images while at dashboard with `w` key*
---
![Manage tasks](./assets/README-img/2025-02-01-at-15-05-17.avif)
*`<C-t>` Let's You manage Your daily tasks from Your Zettelkasten!*
---
![Updated task](./assets/README-img/2025-02-01-at-15-05-53.avif)
*And You can see them update in real-time!*
---
![Running typr from dashboard](./assets/README-img/2025-01-26-at-01-38-57.avif)
*Running Typr plugin directly from dashboard*
---
![Quick markdown look](./assets/README-img/2025-01-26-at-01-40-22.avif)
*Quick markdown look*
---

![Showcase](https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExeHRkbGxuMnY2Mnh5eXF2aHVhNWRtd2QxZDF1MTVydm5idWZkcnBpcyZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/0fq1PBCdISAc2DckVg/giphy.gif)<br>
If You're using kitty You can preview images inside of neovim and paste them with `<leader>v`!
The script on `<leader>v` automatically searches the closest `/assets/` directory and pastes an image there. If it can't find one - it creates it for you!
## LightningNvim
Was made for people who just like
me want to stay in a flow for as long as possible.
LightningNvim provides
- Debugging tools for Java and Typescript (React too).
- In-file text translation 
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
python -m venv ./venv
source venv/bin/activate 
pip install typer opencv-python numpy
```

3. We're now ready to go! Run:
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

- sindrets - diffview.nvim
- ray-x - go.nvim
- andrewferrier - wrapping.nvim
- lewis6991 - gitsigns.nvim
- tadaa - vimade
- mistricky - codesnap.nvim
- robitx - gp.nvim
- epwalsh - obsidian.nvim
- tpope - vim-sleuth
- mbbill - undotree
- windwp - nvim-ts-autotag
- xiyaowong - transparent.nvim
- nvim-treesitter - nvim-treesitter
- olimorris - onedarkpro.nvim
- hrsh7th - nvim-cmp
- akinsho - toggleterm.nvim
- rose-pine - neovim
- cljoly - telescope-repo.nvim
- numToStr - Comment.nvim
- nvim-telescope - telescope.nvim
- neovim - nvim-lspconfig
- rebelot - kanagawa.nvim
- nvim-neo-tree - neo-tree.nvim
- OXY2DEV - markview.nvim
- 3rd - image.nvim
- stevearc - conform.nvim
- folke - lazydev.nvim
- goolord - alpha-nvim
- mfussenegger - nvim-jdtls
- kdheepak - lazygit.nvim
- rachartier - tiny-inline-diagnostic.nvim
- Bilal2453 - luvit-meta
- echasnovski - mini.nvim
- JoosepAlviste - nvim-ts-context-commentstring
- uga-rosa - translate.nvim
- zbirenbaum - copilot.lua
- HakonHarnes - img-clip.nvim
- nvim-lualine - lualine.nvim
- windwp - nvim-autopairs
- folke - todo-comments.nvim 
- OlegGulevskyy - better-ts-errors.nvim
- hedyhli - outline.nvim
- airblade - vim-rooter
- pmizio - typescript-tools.nvim
- rcarriga - nvim-dap-ui
