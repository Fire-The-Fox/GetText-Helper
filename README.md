# GetText-Helper

CMake function that can pre-generate stuff required for your C program's translation

# Usage

```cmake

set(PROJECT_VERSION {version})
...
include(GettextHandler.cmake)
gettext_handler(
        STARTER FALSE   // if set to TRUE, it will recreate base for translations
        LANGUAGES en sk // list of languages separated by space
        SOURCES main.c  // list of source files which you want to translate separated by space
        FINISH FALSE    // set this to TRUE, if you are done translating
)
...
```
