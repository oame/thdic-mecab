# $Id: Makefile.am,v 1.25 2003/08/15 03:11:58 masayu-a Exp $
MKDICDIR      = @CHASEN_MKCHADIC_DIR@
dicdir        = @CHASEN_DIC_DIR@/@PACKAGE@
manual_files   = @CHASEN_MANUAL_FILES@
lexical_dic   = @CHASEN_LEXICAL_DIC@
gen_data      = @CHASEN_GENDATA@
pre_data      = @CHASEN_PREDATA@

SUBDIRS = doc 
dic_DATA      = $(pre_data) $(gen_data)
EXTRA_DIST    = $(pre_data) $(lexical_dic) $(manual_files) @PACKAGE@.spec
CLEANFILES    = $(gen_data)
#
matrix.cha table.cha:
	$(MKDICDIR)/makemat

chadic.da: 
	$(MKDICDIR)/makeda chadic *.dic

install-data-local:
	if test -f @CHASEN_CHASENRC_PATH@  ; then \
		echo "Please modify @CHASEN_CHASENRC_PATH@"; \
	else \
		cp chasenrc @CHASEN_CHASENRC_PATH@ ;\
	fi

sjis-dist: dist
	gtar xzvf ipadic-@VERSION@.tar.gz
	cp -R ipadic-@VERSION@ ipadic-sjis-@VERSION@
	for name in ipadic-sjis-@VERSION@/*.dic ;do \
		mv "$$name" "$$name.org" ; \
		nkf -s -c "$$name.org" > "$$name";	\
		rm -f "$$name.org" ; \
	done
	for name in ipadic-sjis-@VERSION@/*.cha ;do \
		mv "$$name" "$$name.org" ; \
		nkf -s -c "$$name.org" > "$$name";	\
		rm -f "$$name.org" ; \
	done
	for name in ipadic-sjis-@VERSION@/*ja ;do \
		mv "$$name" "$$name.org" ; \
		nkf -s -c "$$name.org" > "$$name";	\
		rm -f "$$name.org" ; \
	done
	for name in ipadic-sjis-@VERSION@/chasenrc* ;do \
		mv "$$name" "$$name.org" ; \
		nkf -s -c "$$name.org" > "$$name";	\
		rm -f "$$name.org" ; \
	done
	gtar czvf ipadic-sjis-@VERSION@.tar.gz ipadic-sjis-@VERSION@
	zip -r ipadic-sjis-@VERSION@.zip ipadic-sjis-@VERSION@
	rm -rf ipadic-sjis-@VERSION@

en-dist: dist
	gtar xzvf ipadic-@VERSION@.tar.gz
	mv ipadic-@VERSION@ ipadic-en-@VERSION@
	for name in ipadic-en-@VERSION@/*.dic ;do \
		mv "$$name" "$$name.org" ; \
		perl script/dic-en.pl -g data/grammar.tbl -t data/ctypes.tbl -i "$$name.org" -o "$$name";	\
		rm -f "$$name.org" ; \
	done
	mv ipadic-en-@VERSION@/connect.cha ipadic-en-@VERSION@/connect.cha.org
	perl script/conn-en.pl -g data/grammar.tbl -t data/ctypes.tbl -f data/cforms.tbl \
		-i ipadic-en-@VERSION@/connect.cha.org -o ipadic-en-@VERSION@/connect.cha
	rm -f ipadic-en-@VERSION@/connect.cha.org
	ruby script/japeng.rb cforms.cha > ipadic-en-@VERSION@/cforms.cha
	ruby script/japeng.rb ctypes.cha > ipadic-en-@VERSION@/ctypes.cha
	cp -f data/chasenrc ipadic-en-@VERSION@/chasenrc
	cp -f data/grammar.cha.en ipadic-en-@VERSION@/grammar.cha
	gtar czvf ipadic-en-@VERSION@.tar.gz ipadic-en-@VERSION@
	zip -r ipadic-en-@VERSION@.zip ipadic-en-@VERSION@
	rm -rf ipadic-en-@VERSION@

rpm: dist
	rpm -ta ipadic-@VERSION@.tar.gz
