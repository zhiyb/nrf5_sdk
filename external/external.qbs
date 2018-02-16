import qbs
import qbs.FileInfo

Project {
    references: [
    ]

    StaticLibrary {
        name: "external.fprintf"
        Depends {name: "cpp"}
        Depends {name: product.sdk_name + ".libraries.all"}
        files: ["fprintf/**"]

        Export {
            Depends {name: "cpp"}
            Depends {name: product.sdk_name + ".libraries.all"}
            cpp.includePaths: ["fprintf"]
        }
    }
}
