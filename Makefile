CC = gcc #compilador de C
CXX = g++ #compilador de c++

SRC_DIRS = .
BUILD_DIR = $(SRC_DIRS)/build

MKDIR = mkdir -p

# SRCS é o nome de todos os arquivos .cc e .c caminho completo desde o diretório raiz do projeto
SRCS = $(shell find $(SRC_DIRS) -name *.cc) $(shell find $(SRC_DIRS) -name *.c)

# não precisa dessa linha
# $(SRCS) := $(addprefix $(SRC_DIRS)/, $(SRCS))

# substitui todas as extensões .cc e .c por .o da variavel SRCS
# ou seja, tem o nome e caminho de todos os arquivos .o que serão gerados pelos arquivos source
OBJS = $(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(SRCS)))

# adiciona o caminho da pasta build "build/" aos objetos
OBJS := $(addprefix $(BUILD_DIR)/, $(OBJS))

INC=\
-I$(SRC_DIRS) \
-I$(SRC_DIRS)/third_party/gemmlowp \
-I$(SRC_DIRS)/third_party/flatbuffers/include \
-I$(SRC_DIRS)/third_party/ruy

CXXFLAGS = $(INC) -O3 -DNDEBUG --std=c++11 -g -DTF_LITE_STATIC_MEMORY

CCFLAGS = $(INC) -O3 -DNDEBUG --std=c99 -g

LDFLAGS = -lm

TARGET_EXEC = hello_world

.PHONY: 
	clean

all: $(BUILD_DIR)/$(TARGET_EXEC)

$(BUILD_DIR):
	$(MKDIR) $@

$(BUILD_DIR)/%.o: %.c $(BUILD_DIR)
	$(MKDIR) $(dir $@)
	$(CC) $(CCFLAGS) -c $< -o $@

$(BUILD_DIR)/%.o: %.cc $(BUILD_DIR)
	$(MKDIR) $(dir $@)
	$(CXX) $(CXXFLAGS) -c $< -o $@

$(BUILD_DIR)/$(TARGET_EXEC) : $(OBJS) $(BUILD_DIR)
	$(CXX) $(LDFLAGS) $(OBJS) -o $@

clean:
	rm -rf $(BUILD_DIR)