CC = gcc
CXX = g++

SRC_DIRS = .
BUILD_DIR = $(SRC_DIRS)/pastinha

MKDIR = mkdir -p

SRCS = $(shell find $(SRC_DIRS) -name *.cc) $(shell find $(SRC_DIRS) -name *.c)

OBJS = $(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(SRCS)))

OBJS := $(addprefix $(BUILD_DIR)/, $(OBJS))


INC=\
-I$(SRC_DIRS) \
-I$(SRC_DIRS)/third_party/gemmlowp \
-I$(SRC_DIRS)/third_party/flatbuffers/include \
-I$(SRC_DIRS)/third_party/ruy

# F := $(firstword $(SRCS))
# $(shell cp $(F) foo)
$(warning OBJS E:  $(INC))

all:	

# $(BUILD_DIR):
# 	@echo "textovazio"

