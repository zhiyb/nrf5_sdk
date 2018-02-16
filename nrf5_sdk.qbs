import qbs
import qbs.FileInfo

Project {
    property string sdk_name: "nrf5_sdk"

    references: [
        "external",
    ]

    StaticLibrary {
        name: sdk_name + ".device"
        files: ["device/**"]

        Export {
            Depends {name: "cpp"}
            cpp.includePaths: ["device"]
            cpp.defines: [
                project.target.toUpperCase(),
                "BOARD_" + project.board.toUpperCase(),
                "CONFIG_GPIO_AS_PINRESET",
                "FLOAT_ABI_HARD",
                "NRF52_PAN_74",
                "NRF_SD_BLE_API_VERSION=5",
                "S132",
                "SOFTDEVICE_PRESENT",
                "SWI_DISABLE0",
            ]
            cpp.driverFlags: [
                "-mcpu=cortex-m4", "-mthumb", "-mabi=aapcs",
                "-mfloat-abi=hard", "-mfpu=fpv4-sp-d16",
                "--specs=nano.specs",
            ]
            cpp.commonCompilerFlags: [
                "-ffunction-sections", "-fdata-sections",
                "-fno-strict-aliasing", "-fno-builtin", "-fshort-enums",
                "-Wno-unused-parameter",
            ]
            cpp.linkerFlags: ["--gc-sections"]
        }
    }

    StaticLibrary {
        name: sdk_name + ".libraries.log.src"
        Depends {name: "external.fprintf"}
        files: [
            "libraries/experimental_log/src/**"
        ]

        Export {
            Depends {name: "external.fprintf"}
        }
    }

    StaticLibrary {
        name: sdk_name + ".libraries.all"
        Depends {name: "app.config"}
        Depends {name: product.sdk_name + ".device"}
        cpp.commonCompilerFlags: ["-Wno-expansion-to-defined"]
        files: [
            "boards/**",
            "drivers_nrf/**",
            "softdevice/common/**",
            "softdevice/" + project.softdevice + "/headers/**",
            "libraries/**",
            "toolchain/*.h",
            "toolchain/system_nrf52.c",
            "toolchain/gcc/gcc_startup_nrf52.S",
            "toolchain/cmsis/include/**",
        ]
        excludeFiles: [
            "**/*_iar.*", "**/*_keil.*",
            "**/*_freertos.*", "**/*_rtx.*",
            "**/deprecated/**",
            "**/*_freertos.*",
            "drivers_nrf/nrf_soc_nosd/**",
            "drivers_nrf/spi_master/spi_5W_master.*",
            "libraries/block_dev/**",
            "libraries/bootloader/**",
            "libraries/cli/**",
            "libraries/eddystone/**",
            "libraries/ecc/**",
            "libraries/crypto/**",
            "libraries/crypto/backend/cc310_lib/**",
            "libraries/experimental_log/src/**",
        ]

        property var directories: [
            "boards",
            "drivers_nrf/ble_flash",
            "drivers_nrf/clock",
            "drivers_nrf/common",
            "drivers_nrf/comp",
            "drivers_nrf/delay",
            "drivers_nrf/gpiote",
            "drivers_nrf/hal",
            "drivers_nrf/i2s",
            "drivers_nrf/lpcomp",
            //"drivers_nrf/nrf_soc_nosd",
            "drivers_nrf/pdm",
            "drivers_nrf/power",
            "drivers_nrf/ppi",
            "drivers_nrf/pwm",
            "drivers_nrf/qdec",
            "drivers_nrf/qspi",
            "drivers_nrf/radio_config",
            "drivers_nrf/rng",
            "drivers_nrf/rtc",
            "drivers_nrf/saadc",
            "drivers_nrf/sdio",
            "drivers_nrf/sdio/config",
            "drivers_nrf/spi_master",
            "drivers_nrf/spi_slave",
            "drivers_nrf/swi",
            "drivers_nrf/systick",
            "drivers_nrf/timer",
            "drivers_nrf/twis_slave",
            "drivers_nrf/twi_master",
            /*"drivers_nrf/twi_master/deprecated",
            "drivers_nrf/twi_master/deprecated/config",*/
            "drivers_nrf/uart",
            "drivers_nrf/usbd",
            "drivers_nrf/wdt",
            "softdevice/common",
            "softdevice/" + project.softdevice + "/headers",
            "softdevice/" + project.softdevice + "/headers/nrf52",
            "libraries/atomic",
            "libraries/atomic_fifo",
            "libraries/balloc",
            "libraries/block_dev",
            "libraries/block_dev/empty",
            "libraries/block_dev/qspi",
            "libraries/block_dev/ram",
            "libraries/block_dev/sdc",
            "libraries/bootloader",
            "libraries/bootloader/ble_dfu",
            "libraries/bootloader/dfu",
            "libraries/bootloader/serial_dfu",
            "libraries/bootloader/usb_dfu",
            "libraries/bsp",
            "libraries/button",
            "libraries/cli",
            "libraries/cli/ble_uart",
            "libraries/cli/cdc_acm",
            "libraries/cli/rtt",
            "libraries/cli/uart",
            "libraries/crc16",
            "libraries/crc32",
            "libraries/crypto",
            "libraries/crypto/backend",
            "libraries/crypto/backend/cc310_lib",
            "libraries/crypto/backend/micro_ecc",
            "libraries/crypto/backend/nrf_crypto_sw",
            "libraries/csense",
            "libraries/csense_drv",
            "libraries/ecc",
            "libraries/eddystone",
            "libraries/experimental_log",
            "libraries/experimental_log/src",
            "libraries/experimental_memobj",
            "libraries/experimental_mpu",
            "libraries/experimental_ringbuf",
            "libraries/experimental_section_vars",
            "libraries/experimental_stack_guard",
            "libraries/experimental_task_manager",
            "libraries/fds",
            "libraries/fifo",
            "libraries/fstorage",
            "libraries/gfx",
            "libraries/gpiote",
            "libraries/hardfault",
            "libraries/hardfault/nrf51",
            "libraries/hardfault/nrf51/handler",
            "libraries/hardfault/nrf52",
            "libraries/hardfault/nrf52/handler",
            "libraries/hci",
            "libraries/led_softblink",
            "libraries/low_power_pwm",
            "libraries/mem_manager",
            "libraries/mutex",
            "libraries/pwm",
            "libraries/pwr_mgmt",
            "libraries/queue",
            "libraries/scheduler",
            "libraries/sdcard",
            "libraries/sensorsim",
            "libraries/serial",
            "libraries/sha256",
            "libraries/simple_timer",
            "libraries/slip",
            "libraries/sortlist",
            "libraries/spi_mngr",
            "libraries/strerror",
            "libraries/svc",
            "libraries/timer",
            "libraries/twi",
            "libraries/twi_mngr",
            "libraries/uart",
            "libraries/usbd",
            "libraries/usbd/class",
            "libraries/usbd/class/audio",
            "libraries/usbd/class/cdc",
            "libraries/usbd/class/cdc/acm",
            "libraries/usbd/class/hid",
            "libraries/usbd/class/hid/generic",
            "libraries/usbd/class/hid/kbd",
            "libraries/usbd/class/hid/mouse",
            "libraries/usbd/class/msc",
            "libraries/usbd/config",
            "libraries/util",
            "toolchain",
            "toolchain/cmsis/include",
        ]
        cpp.includePaths: directories

        Export {
            Depends {name: "cpp"}
            Depends {name: "app.config"}
            Depends {name: product.sdk_name + ".device"}
            cpp.includePaths: product.directories
            cpp.commonCompilerFlags: ["-Wno-expansion-to-defined"]
        }
    }

    StaticLibrary {
        name: sdk_name + ".ble"
        Depends {name: product.sdk_name + ".libraries.log.src"}
        cpp.commonCompilerFlags: [
            "-Wno-missing-field-initializers",
            "-Wno-implicit-function-declaration",
            "-Wno-sign-compare",
        ]
        files: ["ble/**"]
        excludeFiles: [
            "**/*_nrf51.*",
            "ble/ble_services/ble_escs/**",
        ]

        property var directories: [
            "ble/ble_advertising",
            "ble/ble_db_discovery",
            "ble/ble_dtm",
            "ble/ble_racp",
            "ble/ble_radio_notification",
            "ble/ble_services",
            "ble/ble_services/ble_ancs_c",
            "ble/ble_services/ble_ans_c",
            "ble/ble_services/ble_bas",
            "ble/ble_services/ble_bas_c",
            "ble/ble_services/ble_bps",
            "ble/ble_services/ble_cscs",
            "ble/ble_services/ble_cts_c",
            "ble/ble_services/ble_dfu",
            "ble/ble_services/ble_dis",
            "ble/ble_services/ble_escs",
            "ble/ble_services/ble_gls",
            "ble/ble_services/ble_hids",
            "ble/ble_services/ble_hrs",
            "ble/ble_services/ble_hrs_c",
            "ble/ble_services/ble_hts",
            "ble/ble_services/ble_ias",
            "ble/ble_services/ble_ias_c",
            "ble/ble_services/ble_ipsp",
            "ble/ble_services/ble_lbs",
            "ble/ble_services/ble_lbs_c",
            "ble/ble_services/ble_lls",
            "ble/ble_services/ble_nus",
            "ble/ble_services/ble_nus_c",
            "ble/ble_services/ble_rscs",
            "ble/ble_services/ble_rscs_c",
            "ble/ble_services/ble_tps",
            /*"ble/ble_services/experimental_ble_lns",
            "ble/ble_services/experimental_ble_ots",
            "ble/ble_services/experimental_gatts_c",
            "ble/ble_services/experimental_nrf_ble_cgms",
            "ble/ble_services/experimental_nrf_ble_ots_c",*/
            "ble/ble_services/nrf_ble_bms",
            "ble/common",
            "ble/nrf_ble_gatt",
            "ble/nrf_ble_qwr",
            "ble/peer_manager",
        ]
        cpp.includePaths: directories

        Export {
            Depends {name: "cpp"}
            Depends {name: product.sdk_name + ".libraries.log.src"}
            cpp.includePaths: product.directories
        }
    }
}
