function(gettext_handler)
    set(prefix template)

    set(multiValues LANGUAGES SOURCES)
    set(singleValues STARTER FINISH)

    include(CMakeParseArguments)
    cmake_parse_arguments(${prefix}
            "${flags}"
            "${singleValues}"
            "${multiValues}"
            ${ARGN})

    if (template_STARTER)

        foreach(language ${template_LANGUAGES})
            execute_process(COMMAND mkdir -p ../po/${language})
        endforeach()

        foreach(source ${template_SOURCES})
            string(REPLACE "." ";" source ${source})
            list(GET source 0 name)
            list(GET source 1 prefix)
            execute_process(COMMAND xgettext --keyword=_ --language=C
                    --add-comments --package-name=${PROJECT_NAME}
                    --package-version=${PROJECT_VERSION} --sort-output
                    -o ../po/${name}.pot ../${name}.${prefix} --msgid-bugs-address=example@website.com)

            execute_process(COMMAND sed -i "s/charset=CHARSET/charset=UTF-8/g" ../po/${name}.pot)
        endforeach()

        foreach(lang ${template_LANGUAGES})
            foreach(source ${template_SOURCES})
                string(REPLACE "." ";" source ${source})
                list(GET source 0 name)
                execute_process(COMMAND msginit --input=../po/main.pot --locale=${lang} --output=../po/${lang}/${name}.po)
            endforeach()
        endforeach()
    endif()

    if(template_FINISH)
        foreach(lang ${template_LANGUAGES})
            execute_process(COMMAND mkdir -p ../gettext-out/${lang}/LC_MESSAGES/)
            foreach(source ${template_SOURCES})
                string(REPLACE "." ";" source ${source})
                list(GET source 0 name)
                execute_process(COMMAND msgfmt --output-file=../gettext-out/${lang}/LC_MESSAGES/${name}.mo ../po/${lang}/${name}.po)
            endforeach()
        endforeach()
    endif()
endfunction()