# Makefile template for Frama-C/Eva case studies.
# For details and usage information, see the Frama-C User Manual.

### Prologue. Do not modify this block. #######################################
FRAMAC ?= frama-c # FRAMAC is defined in path.mk when it is included, but the
                  # user can override it in the command-line.
include $(shell $(FRAMAC)-config -print-share-path)/analysis-scripts/prologue.mk
###############################################################################
include ../wp.mk

# Edit below as needed. Suggested flags are optional.

MACHDEP = x86_64

## Preprocessing flags (for -cpp-extra-args)
CPPFLAGS    += \

## General flags
FCFLAGS     += \
  -kernel-warn-key annot:missing-spec=abort \
  -kernel-warn-key typing:implicit-function-declaration=abort \
  #-main main \
  #-kernel-msg-key pp \

## Eva-specific flags
EVAFLAGS    += \
  -eva-warn-key builtins:missing-spec=abort \

## GUI-only flags
FCGUIFLAGS += \
  -add-symbolic-path=. \

## Analysis targets (suffixed with .eva)
TARGETS = swap.wp

### Each target <t>.eva needs a rule <t>.parse with source files as prerequisites
swap.parse: \
  main.c \

### Epilogue. Do not modify this block. #######################################
include $(shell $(FRAMAC)-config -print-share-path)/analysis-scripts/epilogue.mk
###############################################################################
