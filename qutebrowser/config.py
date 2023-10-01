config.load_autoconfig(False)
## Colors
#config.set("colors.webpage.darkmode.enabled", True)

c.colors.statusbar.url.fg = '#ECEFF4'
c.colors.statusbar.url.error.fg = '#BF616A'
c.colors.statusbar.url.warn.fg = '#EBCB8B'
c.colors.statusbar.url.hover.fg = '#81A1C1'
c.colors.statusbar.url.success.http.fg = '#B48EAD'
c.colors.statusbar.url.success.https.fg = '#A3BE8C'
c.colors.statusbar.command.fg = '#ECEFF4'
c.colors.statusbar.command.bg = '#2E3440'
c.colors.statusbar.command.private.fg = '#ECEFF4'
c.colors.statusbar.command.private.bg = '#2E3440'
c.colors.statusbar.insert.fg = '#2E3440'
c.colors.statusbar.insert.bg = '#EBCB8B'
c.colors.statusbar.caret.fg = '#2E3440'
c.colors.statusbar.caret.bg = '#B48EAD'
c.colors.statusbar.caret.selection.fg = '#EBCB8B'
c.colors.statusbar.caret.selection.bg = '#B48EAD'
c.colors.statusbar.passthrough.fg = '#ECEFF4'
c.colors.statusbar.passthrough.bg = '#2E3440'
c.colors.statusbar.normal.bg = 'black'
c.colors.statusbar.normal.fg = '#ECEFF4'
c.colors.statusbar.private.bg = 'black'
c.colors.statusbar.private.fg = '#ECEFF4'
c.colors.statusbar.progress.bg = '#A3BE8C'

c.colors.tabs.bar.bg = 'black'
c.colors.tabs.odd.bg = 'black'
c.colors.tabs.even.bg = 'black'
c.colors.tabs.odd.fg = '#ECEFF4'
c.colors.tabs.even.fg = '#ECEFF4'
c.colors.tabs.selected.odd.bg = '#434C5E'
c.colors.tabs.selected.even.bg = '#434C5E'
c.colors.tabs.selected.odd.fg = '#ECEFF4'
c.colors.tabs.selected.even.fg = '#ECEFF4'
c.colors.tabs.indicator.start = '#D08770'
c.colors.tabs.indicator.error = '#BF616A'
c.colors.tabs.indicator.stop = '#A3BE8C'

c.colors.completion.scrollbar.fg = '#D8DEE9'
c.colors.completion.scrollbar.bg = '#2E3440'
c.colors.completion.fg = ['#88C0D0', '#ECEFF4', '#ECEFF4']
c.colors.completion.odd.bg = '#3B4252'
c.colors.completion.even.bg = '#434C5E'
c.colors.completion.category.fg = '#A3BE8C'
c.colors.completion.category.bg = '#434C5E'
c.colors.completion.category.border.top = '#ECEFF4'
c.colors.completion.category.border.bottom = '#ECEFF4'
c.colors.completion.item.selected.fg = '#A3BE8C'
c.colors.completion.item.selected.bg = '#4C566A'
c.colors.completion.item.selected.border.top = '#EBCB8B'
c.colors.completion.item.selected.border.bottom = '#EBCB8B'
c.colors.completion.item.selected.match.fg = '#A3BE8C'
c.colors.completion.match.fg = '#A3BE8C'

c.colors.downloads.bar.bg = 'black'
c.colors.downloads.error.bg = '#BF616A'
c.colors.downloads.error.fg = '#ECEFF4'
c.colors.downloads.start.bg = 'black'
c.colors.downloads.start.fg = '#ECEFF4'
c.colors.downloads.stop.bg = 'black'
c.colors.downloads.stop.fg = '#BF616A'

c.colors.hints.fg = '#ECEFF4'
c.colors.hints.match.fg = '#A3BE8C'
c.colors.hints.bg = 'black'

c.colors.messages.error.bg = '#BF616A'
c.colors.messages.error.fg = '#ECEFF4'
c.colors.messages.error.border = '#EBCB8B'
c.colors.messages.info.bg = '#5E81AC'
c.colors.messages.info.fg = '#ECEFF4'
c.colors.messages.info.border = '#B48EAD'
c.colors.messages.warning.bg = '#D08770'
c.colors.messages.warning.fg = '#ECEFF4'
c.colors.messages.warning.border = '#5E81AC'

c.colors.keyhint.bg = 'black'
c.colors.keyhint.fg = '#ECEFF4'
c.colors.keyhint.suffix.fg = '#A3BE8C'

c.colors.prompts.bg = '#2E3440'
c.colors.prompts.fg = '#ECEFF4'
c.colors.prompts.border = '#8FBCBB'
c.colors.prompts.selected.bg = '#4C566A'
c.colors.prompts.selected.fg = '#A3BE8C'

## Font
c.fonts.default_family = ["JetBrainsMono", "FreeSerif"]
c.fonts.default_size = '12pt'

## Layout
c.scrolling.bar = 'never'
c.statusbar.position = 'bottom'
c.downloads.remove_finished = 5

## Cookies
c.content.cookies.accept = 'no-3rdparty'
config.set('content.cookies.accept', 'no-3rdparty', 'https://search.brave.com/')
c.content.cookies.store = True

## JS
c.content.javascript.enabled = False

## Site specific configurations
with config.pattern("https://search.brave.com/*") as p:
    p.content.javascript.enabled = True
with config.pattern("https://*.electrominati.com/*") as p:
    p.content.javascript.enabled = True
with config.pattern("https://gitlab.com/*") as p:
    p.content.javascript.enabled = True
with config.pattern("https://github.com/*") as p:
    p.content.javascript.enabled = True
with config.pattern("https://*.tutanota.com/*") as p:
    p.content.javascript.enabled = True


# Adblock
c.content.blocking.method = 'both'

## Pages
c.url.default_page = 'https://search.brave.com/'
c.url.searchengines = {'DEFAULT': 'https://search.brave.com/search?q={}&source=web'}
c.url.start_pages = ['https://search.brave.com/']

## Bindings for command mode
config.bind('<Ctrl-k>', 'completion-item-focus prev', mode='command')
config.bind('<Ctrl-j>', 'completion-item-focus next', mode='command')

## Bindings for normal mode
config.bind('ch', 'history-clear')
config.bind('<Alt-x>', 'set-cmd-text :')
config.bind('A', 'adblock-update')
config.bind('~', 'hint links spawn mpv {hint-url}')
config.bind('!', 'hint links spawn mpv --vid=no {hint-url}')
config.bind('@', 'hint links spawn mpv --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" {hint-url} --speed=1.25')
config.bind('#', 'hint links spawn mpv --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" {hint-url} --speed=1.5')
config.bind('$', 'hint links spawn mpv --ytdl-format="bestvideo[height<=?1080]+bestaudio/best" {hint-url} speed=2')
config.bind('Z', 'hint links spawn st -e yt-dlp {hint-url}')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind('<Alt-s>', 'set-cmd-text :set content.javascript.enabled true')
config.bind('<Alt-c>', 'set-cmd-text :set content.cookies.accept')

## Bug fix
# c.qt.chromium.sandboxing = 'disable-all'
