# lyx.local

LyX customization files to make my life easier. With this tool I (and possibly you too) can

- develop local styles in one place with joy,
- deploy and reconfigure easily with shell commands.

*Disclaimer*: Use this tool at your own risk; it may erase important files in your local [UserDir](https://wiki.lyx.org/LyX/UserDir). I would recommend against trying it when you have an approaching deadline.

## 1. Download and initialize

I assume that you have LyX and `bash`. `git` and `make` are recommended but optional. (You can download ZIP instead of `git clone`. `make init` is just and alias for `bash etc/init.sh`, `make deploy` for `bash etc/deploy.sh`, etc.)

If you are on Microsoft Windows, use WSL, MSYS2, MINGW, or Cygwin, though not fully tested on these platforms.

Open a Terminal window, then run

```bash
cd path/to/your/favorite/location
git clone https://github.com/kenjisato/lyx.local
cd lyx.local
make init
```

If you are asked to do so, check `etc/config` file. Since your system and/or application layout are not supported, automatic initialization failed. You must properly define variables `Python`, `LyX`, `LyXDir`, and `UserDir`.

MS Windows users don't need to install Python yourself, though it's very useful. LyX's Windows binary is shipped with it.

## 2. Modify

Take a look at `etc/deploy_targets` file. It defines three array variables.

- `directories`: included directories,
- `exclude`: excluded files, and
- `require_backup`: important files that need to make backup when a duplicate is found in UserDir.

All paths are relative to `LyX` and you can use wildcard. By default, anything in the following directories to LyX's `UserDir`. No exclusion, no backups.

```
LyX
├── bind
├── clipart
├── doc
├── examples
├── images
├── kbd
├── layouts
├── scripts
├── templates
└── ui
```

It is highly likely that you will never need some layout files I ship. You can simply remove those file from `LyX` directory. **NB**: When I make updates to the repository and when you `git pull` after, then those deleted files will come back again.

I put blank `etc/deploy_targets.local` file for your convenience. _I promise_ that I will keep this file as is so that any modification you make to this file won't be affected. This file is read after `etc/deploy_targets` and so if you re-define the array variables (`directories`, `exclude`, `require_backup`), the original definitions are overwritten.

**Example**: Maybe you don't want layout files for `bxjscls` and `pxrubrica` module (both for documents in Japanese), then you write something like below:

```
# etc/deploy_targets.local
exclude=('layouts/bxjs*' 'layouts/pxrubrica.module')
```


## 3. Deploy and reconfigure

Now you can deploy the customization files. With "deploy", I mean to copy files in LyX directory in the local repository to LyX's UserDir. This is done by

```
make deploy    # Or,  bash etc/deploy.sh
```

Then you need to Reconfigure LyX. The following command will execute `configure.py` from within UserDir.

```
make reconfigure  # Or,  bash etc/reconfigure.sh
```

To do both in one go, run

```
make deploy reconfigure
```

Restart LyX and you should see the changes take effect.

### Tips for Mac users

Clicking the red cross button is not enough. Type ⌘Q to properly shut down the app. Or, if don't want to leave Terminal, you may want to use the following command:

```
osascript -e 'quit app "LyX"'
```

Then the following command will re-open your demo document.

```
open demo/yourdemo.lyx
```

## 4. Write demos

When you are developing a module or layout file, you should be writing a LyX file for testing. The place for those demos is the `demo` direcory.

Place a LyX file there and you can compile it to PDF by running

```
make demo
```

This command compiles each LyX file in `demo` directory when the final PDF output is missing or older than the source file. By default the converter format is set to `pdf5`, i.e., the PDF file is created with LuaTeX. If you want to use pdflatex, then

```
make demo FORMAT=pdf2
```

For your information, LyX understands the following PDF formats:

- `pdf` (ps2pdf)
- `pdf2` (pdflatex)
- `pdf3` (dvipdfm)
- `pdf4` (xetex)
- `pdf5` (luatex)

You may desire to make pdflatex the default driver. Then, please edit your local `makefile` at the line defining `FORMAT` variable.

**What's next?**
Someday, you feel comfortable with the behavior of your modules and layouts. Then, move the demo LyX file to `LyX/doc` directory. By doing so, you can open the document from within LyX.

## Wish list

- Provide a way to delete a corresponding file in `UserDir` when a local development version is renamed.
- Write some more layout and module files.
