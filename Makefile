# Makefile v1.1.30 - Tuesday, September 5, 2017

SHELL		:= /usr/bin/env bash
PROJECT		:= $(shell basename ${PWD})
ROOT		:= $$(dirname $${PWD} |sed s,$${HOME}/,,)
# ROOT		:= $(shell basename `dirname ${PWD}`)
TIMESTAMP	:= $(shell date +%s)
SUFFIX		:= $(shell date +\~.%s)
BAKDIR		:= local/backups
BACKUPS		:= --suffix='~.$(TIMESTAMP)' --backup-dir=$(BAKDIR) 
EXCLUDES	:= {'.DS_Store','*~*','.idea','__pycache__','flask','*.db','db_repository*','local','tmp/*'}
ROPTS		:= -Cabhuve 'ssh -Aq' --exclude=$(EXCLUDES) $(BACKUPS) --delete

.PHONY: test drysync

test: 
	@echo "Test:"
	@echo "  PROJECT  => $(PROJECT)"
	@echo "  ROOT     => $(ROOT)"
	@echo "  SUFFIX   => $(SUFFIX)"
	@echo "  ROPTS    => $(ROPTS)"

dryget:
	@rsync $(ROPTS) --dry-run btcdev:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

get:
	@rsync $(ROPTS) btcdev:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

drygethq:
	@rsync --dry-run $(ROPTS) hq:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

gethq:
	@rsync $(ROPTS) hq:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

drygetx:
	@rsync --dry-run $(ROPTS) x751:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

getx:
	@rsync $(ROPTS) x751:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

dryputhq:
	@rsync --dry-run $(ROPTS) ~/$(ROOT)/$(PROJECT)/ hq:$(ROOT)/$(PROJECT)

puthq:
	@rsync $(ROPTS) ~/$(ROOT)/$(PROJECT)/ hq:$(ROOT)/$(PROJECT)

dryputx:
	@rsync --dry-run $(ROPTS) ~/$(ROOT)/$(PROJECT)/ x751:$(ROOT)/$(PROJECT)

putx:
	@rsync $(ROPTS) ~/$(ROOT)/$(PROJECT)/ x751:$(ROOT)/$(PROJECT)

dryput:
	@rsync --dry-run $(ROPTS) ~/$(ROOT)/$(PROJECT)/ btcdev:$(ROOT)/$(PROJECT)

put:
	@rsync $(ROPTS) ~/$(ROOT)/$(PROJECT)/ btcdev:$(ROOT)/$(PROJECT)

drysync: dryget dryput

sync: get put


drypurge:
	@rsync --dry-run $(ROPTS) --delete ~/$(ROOT)/$(PROJECT)/ btcdev:$(ROOT)/$(PROJECT)
	@rsync --dry-run $(ROPTS) --delete btcdev:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)

purge:
	@rsync $(ROPTS) --delete ~/$(ROOT)/$(PROJECT)/ btcdev:$(ROOT)/$(PROJECT)
	@rsync $(ROPTS) --delete btcdev:$(ROOT)/$(PROJECT)/ ~/$(ROOT)/$(PROJECT)
