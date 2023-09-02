;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Modules
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (nordic-channel packages suckless))
(use-service-modules desktop linux nix pm virtualization xorg)
(use-package-modules bootloaders certs linux package-management suckless vim vpn xdisorg)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           Configurations
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define %xorg-config
  "Section \"InputClass\"
  Identifier \"Touchpads\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsTouchpad \"on\"
  Option \"Tapping\" \"on\"
  Option \"TappingDrag\" \"on\"
  Option \"DisableWhileTyping\" \"on\"
  Option \"MiddleEmulation\" \"on\"
  Option \"ScrollMethod\" \"twofinger\"
EndSection
Section \"InputClass\"
  Identifier \"Keyboards\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsKeyboard \"on\"
EndSection
")

;; Kernel
(operating-system
 (kernel linux-5.15)
 (firmware (cons* iwlwifi-firmware
                  %base-firmware))
 (initrd microcode-initrd)

 ;; Host
 (host-name "Production")
 (timezone "Europe/Vienna")
 (locale "en_US.utf8")
 ;;(keyboard-layout (keyboard-layout "de"))
 (keyboard-layout (keyboard-layout
                   "us"));; #:options '("ctrl:swapcaps")))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                           Packages
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (packages (append (list neovim
                         nix
                         nss-certs ;for HTTPS access
                         ntfs-3g
						 wireguard-tools
                         ;; ;; Wayland TODO dwl configuration and desktop file
                         ;; foot
                         ;; qtwayland-5
                         ;; swaybg
                         ;; swaylock
                         ;; xorg-server-xwayland
                         ;; ;; dwl
                         ;; nordic-dwl
                         ;; bemenu
                         ;; ;; Sway
                         ;; sway
                         ;; swayidle

                         ;; Xorg suckless
                         dmenu
                         nordic-dwm
                         nordic-slstatus
                         nordic-st
                         xss-lock)
                   %base-packages))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                           Services
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (services (cons* (simple-service 'wireguard-module
                                  kernel-module-loader-service-type
                                  '("wireguard"))
                  (service nix-service-type)
                  (service libvirt-service-type
                           (libvirt-configuration
                            (unix-sock-group "libvirt")))
                  (service tlp-service-type
                           (tlp-configuration
                            (cpu-scaling-governor-on-ac (list "performance"))
                            (cpu-scaling-governor-on-bat (list "powersave"))
                            ;;(cpu-energy-perf-policy-on-ac (list "performance"))
                            ;;(cpu-energy-perf-policy-on-bat (list "power"))
                            (cpu-max-perf-on-ac 100)
                            (cpu-max-perf-on-bat 30)
                            (cpu-min-perf-on-ac 0)
                            (cpu-min-perf-on-bat 0)
                            (cpu-boost-on-ac? #t)
                            (cpu-boost-on-bat? #t)
                            (sched-powersave-on-bat? #t)))
                  ;; Display manager
                  ;; Slim on X11
                  (screen-locker-service nordic-slock "slock")
                  (service slim-service-type
                           (slim-configuration
                            (default-user "max")
                            (xorg-configuration
                             (xorg-configuration
                              (keyboard-layout keyboard-layout)
                              (extra-config (list %xorg-config))))))
                  (modify-services %desktop-services
                                   (delete gdm-service-type))))

 ;; GDM on wayland
 ;;(screen-locker-service swaylock)
 ;; (modify-services %desktop-services
 ;;                  (gdm-service-type config =>
 ;;                                    (gdm-configuration
 ;;                                     (wayland? #t)
 ;;                                     (default-user "max")
 ;;                                     (xorg-configuration
 ;;                                      (xorg-configuration
 ;;                                       (keyboard-layout keyboard-layout)
 ;;                                       (extra-config (list %xorg-config)))))))))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                           Users
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (users (cons (user-account
               (name "max")
               (group "users")
               (supplementary-groups '(
									   "dialout"
                                       "wheel"
									   "libvirt"
                                       "audio"
                                       "video"
                                       "kvm"
                                       "input")))
              %base-user-accounts))

 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;;                           Disk and Bootloader
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets (list "/boot/efi"))
              (keyboard-layout keyboard-layout)))
 (swap-devices (list (swap-space
                      (target "/dev/sda2"))))
 (file-systems (cons* (file-system
                       (mount-point "/boot/efi")
                       (device "/dev/sda1")
                       (type "vfat"))
                      (file-system
                       (device "tmpfs")
                       (mount-point "/tmp")
                       (type "tmpfs"))
                      (file-system
                       (mount-point "/")
                       (device "/dev/sda3")
                       (type "ext4")) %base-file-systems)))
