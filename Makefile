DEV_ROCKS = inspect luacheck

play:
	@love src/

build: clean
	cd src && zip -9qry ../dist/rhino.love . && cd -
	cd dist && cp rhino.love rhino.app/Contents/Resources/
	cd dist && zip -9qry rhino-osx.zip rhino.app

clean:
	rm -f dist/rhino{.love,-osx.zip}

dev:
	@for rock in $(DEV_ROCKS) ; do \
		if ! luarocks list | grep $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock ; \
    else \
      echo $$rock already installed, skipping ; \
    fi \
	done;
	@yarn global add luamin

lint:
	@luacheck -q .

setup:
	mkdir -p dist
	mkdir -p src/vendor
	curl -L https://bitbucket.org/rude/love/downloads/love-0.10.2-macosx-x64.zip > dist/love.zip
	unzip -q -d dist dist/love.zip
	mv dist/love.app dist/rhino.app

update:
	cd src/vendor ; \
	wget -nv -N 'https://raw.githubusercontent.com/flintinatux/chipmunk/master/chipmunk.lua'
