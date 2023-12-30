FLAVORS = latte frappe macchiato mocha
STYLESETS = $(FLAVORS:%=dist/catppuccin-%)

all: $(STYLESETS)

dist/catppuccin-%: theme.hbs
	whiskers -o $@ $< $(patsubst dist/catppuccin-%,%,$@)

install: $(STYLESETS)
	mkdir -p ~/.config/aerc/stylesets/
	cp dist/catppuccin-* ~/.config/aerc/stylesets/

clean:
	rm -f $(STYLESETS)

.PHONY: all install clean
