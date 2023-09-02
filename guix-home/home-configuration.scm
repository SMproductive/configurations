;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (gnu home services desktop)
             (guix gexp)
             (gnu packages shells)
             (gnu packages video)
             (gnu home services shells)
             (gnu home services)
             (gnu home services guix)
             (guix channels))
(home-environment
 ;; Below is the list of Home services.  To search for available
 ;; services, run 'guix home search KEYWORD' in a terminal.
 (services
  ;; Shells
  (list (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") ("la" . "ls -al")
                              ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")
                              ("pm" . "ppm ~/.ppm_passwords pipe")
                              ("up" . "guix pull; nix-channel --update")
                              ("sup" . "sudo -E guix system reconfigure ~/configurations/guix/system.scm")
                              ("hup" . "guix home reconfigure ~/configurations/guix-home/home-configuration.scm")
                              ("nup" . "nix-env -u")
                              ("gc" . "sudo guix system delete-generations; sudo guix gc; guix gc; sudo nix-collect-garbage -d; nix-collect-garbage -d")
                              ("vup" . "sudo sysctl -w net.ipv4.ip_forward=1; sudo wg-quick up wg0")
                              ("vdown" . "sudo sysctl -w net.ipv4.ip_forward=0; sudo wg-quick down wg0")))
                   ;;(bashrc (list (local-file
                   ;;              ".bashrc" "bashrc")))
                   (bash-profile (list (local-file
                                        ".profile"
                                        "profile")))))
        (service home-zsh-service-type
                 (home-zsh-configuration
                  (zshrc (list (local-file
                                "../zsh/.zshrc" "zshrc")))
                  (zprofile (list (local-file
                                   ".profile"
                                   "zprofile")))))
        (service home-redshift-service-type
                 (home-redshift-configuration
                  (location-provider 'manual)
                  (latitude 47.070713)    ;northern hemisphere
                  (longitude 15.439504) ;west of Greenwich
                  (daytime-temperature 5700)
                  (nighttime-temperature 3600)))
        ;; Keyboard settings
        (service home-xmodmap-service-type
                 (home-xmodmap-configuration
                  (key-map '(("remove Lock" . "Caps_Lock")
                             ("remove Control" . "Control_L")
                             ("keysym Control_L" . "Caps_Lock")
                             ("keysym Caps_Lock" . "Control_L")
                             ("add Lock" . "Caps_Lock")
                             ("add Control" . "Control_L")))))
        ;; Default shell
        (simple-service 'some-useful-env-vars-service
                        home-environment-variables-service-type
                        `(("SHELL" . ,(file-append zsh "/bin/zsh"))))
        ;; Configurations
        (service home-files-service-type
                 `((".Xresources" , (local-file "../Xresources"))
                   (".xinitrc" , (local-file "../xinitrc"))
                   (".login" , (local-file "../login"))
                   ;; (".xsession" , (local-file "../xinitrc")) ;; FIXME needs to be a physical link
                   (".vimrc" , (local-file "../init.vim"))))
        (service home-xdg-configuration-files-service-type
                 `(("gtk-3.0/settings.ini" ,(local-file "../gtk-3.0/settings.ini"))
                   ("gtk-4.0/settings.ini" , (local-file "../gtk-4.0/settings.ini"))
                   ("nvim/init.vim" , (local-file "../init.vim"))
                   ("qutebrowser/config.py" , (local-file "../qutebrowser/config.py"))
                   ("mpv/mpv.conf" ,(local-file "../mpv/mpv.conf"))
                   ("foot/foot.ini" , (local-file "../foot.ini"))
                   ;; ZSH
                   ("zsh/functions.zsh" , (local-file "../zsh/functions.zsh"))
                   ;; Wayland
                   ("swaylock/config" ,(local-file "../swaylock/config"))
                   ("sway/config" ,(local-file "../sway/config"))
                   ("sway/swaybar.sh" ,(local-file "../sway/swaybar.sh"))

                   ("waybar/config" , (local-file "../waybar/config"))
                   ("waybar/style.css" , (local-file "../waybar/style.css"))

                   ("hypr/hyprpaper.conf" ,(local-file "../hypr/hyprpaper.conf"))
                   ("hypr/hyprland.conf" ,(local-file "../hypr/hyprland.conf"))))
        ;; Channels
        (simple-service 'variant-packages-service
                        home-channels-service-type
                        (list
                         (channel
                          (name 'nordic-channel)
                          (url "https://gitlab.com/SMproductive/nordic-channel.git")
                          (branch "master"))
                         (channel
                          (name 'nonguix)
                          (url "https://gitlab.com/nonguix/nonguix")
                          (branch "master")
                          (introduction
                           (make-channel-introduction
                            "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
                            (openpgp-fingerprint
                             "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))))))
 ;; Below is the list of packages that will show up in your
 ;; Home profile, under ~/.guix-home/profile.
 (packages (specifications->packages (list "curl"
                                           "dconf"
                                           "editorconfig-core-c"
                                           "emacs-next-pgtk"
                                           "emacs-pdf-tools"
                                           "emacs-vterm"
                                           "fd" ;; For emacs file search
                                           "lf"
                                           "feh"
                                           "git"
                                           "glslang"
                                           "htop"
                                           "ispell"
                                           "markdown"
                                           "neovim"
                                           "openssh"
                                           "pavucontrol"
                                           "playerctl"
                                           "ripgrep"
                                           "shellcheck"
										   "font-jetbrains-mono"
										   "font-awesome"
                                           "yt-dlp"

                                           ;; System stuff
                                           ;; "sway"
                                           ;; "fzf"
                                           "waybar-experimental"
                                           "swayidle"
                                           ;; "swaylock"
                                           ;; "qtwayland@5"
										   "brightnessctl"
                                           "foot"  ;FIXME locale error
                                           "bemenu"
                                           "wl-clipboard"


                                           ;; "nordic-dwm"
                                           ;; "nordic-st"
                                           ;; "nordic-slstatus"
                                           ;; "nordic-slock"
                                           ;; "dmenu"
                                           ;; "xclip"
                                           "nss-certs"))))
