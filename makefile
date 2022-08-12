MAKE=$(MAKE) -nologo -s

RELEASE_FILES= \
	..\release\circular_node.e \
	..\release\observer.e \
	..\release\person.e \
	..\release\subject.e

.SILENT:

.SUFFIXES: .e

default:
	"echo Available targets:"
	"echo."
	"echo   build - build all"
	"echo   clean - clean all"

build: $(RELEASE_FILES)

$(RELEASE_FILES): ../src/$$(@F)
	chcp 65001
	sed -f loop.sed $** > $@

.e{..\src}.e:
	chcp 65001
	powershell -command "Get-Content -Path $< | Out-File -Encoding utf8 -FilePath $<1"
	sed -f latex2e.sed $<1 > $<2
	powershell -command "ec -preference pretty_printer.line_processing wrap -pretty $<2 | Out-File -Encoding utf8 -FilePath $@"
	del $<1 $<2

clean:
	-del /q ..\src\*.e
	-del /q ..\release\*.e
