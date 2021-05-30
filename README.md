# Resume

This repository contains my [jsonresume](https://jsonresume.org/) and instructions on how to build it as well as export.


## Build

Use the following build command to create `build/resume.pdf`. Some themes do not go well with pdf exporting, as
it is done with chromium headless browser. Openning a local server and pressing `Print` in Chrome generally works better.
_The theme is just an example, other themes can be used._

```
make clean pdf THEME=stackoverflow
```

## Serve

Use the following command to create a container serving the resume with the specified theme at `http://localhost:4000`.
This page can be printed or save as a PDF. _The theme is just an example, other themes can be used._

```
make server THEME=stackoverflow
```

## General observations
1. Only themes in the specific format are installed, that is `jsonresume-theme-*`
2. Some themes fail to generate the server or the pdf (shrug)
3. Some themes are old and contain different json keyworks like `website` instead of `url`, few of them actually do everything right